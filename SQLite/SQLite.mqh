#ifndef _STD_SQLLITE_
#define _STD_SQLLITE_
#ifdef __MQL4__

#include "SQLiteError.mqh"

#define DATABASE_OPEN_READONLY 0x1
#define DATABASE_OPEN_READWRITE 0x2
#define DATABASE_OPEN_CREATE 0x4
#define DATABASE_OPEN_MEMORY 0x80
#define DATABASE_OPEN_COMMON 0x1000

#ifdef DB_NO_ERROR_CONTROL
   #define ErrorSet(dErr)
#else
   #define ErrorSet(dErr) SQLiteError=dErr
#endif

#import "sqliteconnector.dll"
   int DBTest(const uchar &filename_utf8[],uint flags);
   bool DBExec(int db,const uchar &sql[],int& errTextPtr);
   uint DBTextBuffSize(int textPtr);
   void DBGetText(int textPtr,uchar &buff[],uint buffSize);
#import

#import "sqlite3.dll"
   int sqlite3_open_v2(uchar &filename[], /* Database filename (UTF-8) */
                       int &ppDb,      /* OUT: SQLite db handle */
                       uint flags,         /* Flags */
                       int zVfs);      /* Name of VFS module to use */
   int sqlite3_close_v2(int database);
   int sqlite3_exec(int database,                                  /* An open database */
                    uchar &sql[],                           /* SQL to be evaluated */
                    int, /* (*callback)(void*,int,char**,char**),*/  /* Callback function */
                    int, /*void *,*/        /* 1st argument to callback */
                    int); /*char **errmsg);*/                              /* Error msg written here */
   int sqlite3_prepare_v2(
     int db,/*sqlite3 *db,*/            /* Database handle */
     uchar &zSql[],/*const char *zSql,*/       /* SQL statement, UTF-8 encoded */
     int nByte,              /* Maximum length of zSql in bytes. */
     int &ppStmt,/*sqlite3_stmt **ppStmt,*/  /* OUT: Statement handle */
     int/*const char **pzTail*/     /* OUT: Pointer to unused portion of zSql */
   );
   int sqlite3_finalize(int pStmt/*sqlite3_stmt *pStmt*/);
   void sqlite3_free(int);
   int sqlite3_errcode(int db);
#import

//----------------------------------------------------------------------------------------
int DatabaseTest(string filename,uint flags){
   static string filesPath=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\";
   static string commonFilesPath=TerminalInfoString(TERMINAL_COMMONDATA_PATH)+"\\Files\\";
   bool isCommon=bool(flags&DATABASE_OPEN_COMMON);
   flags&=~DATABASE_OPEN_COMMON;
   filename=isCommon?commonFilesPath+filename:filesPath+filename;
   uchar fname[];
   StringToCharArray(filename,fname,0,WHOLE_ARRAY,CP_UTF8);
   return DBTest(fname,flags);
}
//---------------------------------------------------------------------------------------
int DatabaseLastError(int database){
   return database==INVALID_HANDLE?-1:sqlite3_errcode(database);
}
//---------------------------------------------------------------------------------------
int DatabaseOpen(string filename,uint flags){
   static string filesPath=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\";
   static string commonFilesPath=TerminalInfoString(TERMINAL_COMMONDATA_PATH)+"\\Files\\";
   bool isCommon=bool(flags&DATABASE_OPEN_COMMON);
   flags&=~DATABASE_OPEN_COMMON;
   filename=isCommon?commonFilesPath+filename:filesPath+filename;
   uchar fname[];
   StringToCharArray(filename,fname,0,WHOLE_ARRAY,CP_UTF8);
   int ret;
   if (0!=sqlite3_open_v2(fname,ret,flags,NULL)){
      DatabaseClose(ret);
      return INVALID_HANDLE;}
   else return ret;
}
//-----------------------------------------------------------------------------------------
void DatabaseClose(int database){
   if (database!=INVALID_HANDLE) sqlite3_close_v2(database);
}


//-----------------------------------------------------------------------------------------
bool DatabaseExecute(int database,string sql){
   uchar query[];
   StringToCharArray(sql,query,0,WHOLE_ARRAY,CP_UTF8);
   int textPtr=0;
   bool ret=DBExec(database,query,textPtr);
   if (!ret){
      uchar buff[];
      uint len=DBTextBuffSize(textPtr);
      int buffSize=ArrayResize(buff,len);
      DBGetText(textPtr,buff,buffSize);
      sqlite3_free(textPtr);
      PrintFormat("DB execute error: %s",CharArrayToString(buff,0,WHOLE_ARRAY,CP_UTF8));
      }
   int errCode=sqlite3_exec(database,query,NULL,NULL,NULL);
   ErrorSet(errCode);
   return !errCode;
}
//----------------------------------------------------------------------------------------
/*
int DatabasePrepare(int database,string  sql){
   int ret;
   uchar query[];
   StringToCharArray(sql,query,0,WHOLE_ARRAY,CP_UTF8);
   int errCode=sqlite3_prepare_v2(database,query,-1,ret,NULL);
   ErrorSet(errCode);
   return !errCode?ret:INVALID_HANDLE;
}
*/
//--------------------------------------------------------------------------------------------
/*
void DatabaseFinalize(int request){
   int errCode=sqlite3_finalize(request);
   ErrorSet(errCode);
}
*/
#endif
#endif