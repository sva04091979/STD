#ifndef _STD_SQLLITE_
#define _STD_SQLLITE_
#ifdef __MQL4__

#include "SQLiteError.mqh"

#define SQLITE_OK 0
#define SQLITE_DONE 101

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
int sqlite3_prepare16_v2(
     int db,/*sqlite3 *db,          */  /* Database handle */
     string query,/*const void *zSql,     */  /* SQL statement, UTF-16 encoded */
     int,/*int nByte,            */  /* Maximum length of zSql in bytes. */
     int& pStmt,/*sqlite3_stmt **ppStmt,*/  /* OUT: Statement handle */
     int/*const void **pzTail   */  /* OUT: Pointer to unused portion of zSql */
   );   
int sqlite3_finalize(int request);
void sqlite3_free(int);
int sqlite3_errcode(int db);
string sqlite3_errmsg16(int db);
int sqlite3_db_handle(int request);
int sqlite3_column_count(int request);
int sqlite3_step(int request);
string sqlite3_column_origin_name16(int request,int columNumber);
#import

enum ENUM_DATABASE_FIELD_TYPE{
   DATABASE_FIELD_TYPE_INVALID,
   DATABASE_FIELD_TYPE_INTEGER,
   DATABASE_FIELD_TYPE_FLOAT,
   DATABASE_FIELD_TYPE_TEXT,
   DATABASE_FIELD_TYPE_BLOB,
   DATABASE_FIELD_TYPE_NULL
};


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
   if (SQLITE_OK!=sqlite3_open_v2(fname,ret,flags,NULL)){
      PrintFormat("DB open error: %s",sqlite3_errmsg16(ret));
      DatabaseClose(ret);
      return INVALID_HANDLE;}
   else return ret;
}
//-----------------------------------------------------------------------------------------
void DatabaseClose(int database){
   if (database!=INVALID_HANDLE&&SQLITE_OK!=sqlite3_close_v2(database))
      PrintFormat("DB close error: %s",sqlite3_errmsg16(database));
}
//-----------------------------------------------------------------------------------------
bool DatabaseExecute(int database,string sql){
   if (database==INVALID_HANDLE) return false;
   uchar query[];
   StringToCharArray(sql,query,0,WHOLE_ARRAY,CP_UTF8);
   int ret=sqlite3_exec(database,query,NULL,NULL,NULL);
   if (ret!=SQLITE_OK){
      PrintFormat("DB execute error: %s",sqlite3_errmsg16(database));
      }
   return !ret;
}
//----------------------------------------------------------------------------------------
int DatabasePrepare(int database,string  sql){
   if (database==INVALID_HANDLE) return INVALID_HANDLE;
   int ret;
   int errCode=sqlite3_prepare16_v2(database,sql,-1,ret,NULL);
   if (errCode!=0)
      PrintFormat("DB prepare error: %s",sqlite3_errmsg16(database));
   return !errCode?ret:INVALID_HANDLE;
}
//--------------------------------------------------------------------------------------------
void DatabaseFinalize(int request){
   if (request==INVALID_HANDLE) return;
   int errCode=sqlite3_finalize(request);
   if (errCode!=SQLITE_OK)
      PrintFormat("DB finalize error: %s",sqlite3_errmsg16(sqlite3_db_handle(request)));
}
//----------------------------------------------------------------------------
bool DatabaseRead(int request){
   if (request==INVALID_HANDLE) return false;
   switch(sqlite3_step(request)){
      case SQLITE_DONE:
         return true;
      default:
         PrintFormat("DB read error: %s",sqlite3_errmsg16(sqlite3_db_handle(request)));
         return false;
   }
}
//----------------------------------------------------------------------------
int DatabaseColumnsCount(int request){
   return request==INVALID_HANDLE?-1:sqlite3_column_count(request);
}
//-----------------------------------------------------------------------------
bool DatabaseColumnName(int request,int column,string& name){
   if (request==INVALID_HANDLE) return false;
   name=sqlite3_column_origin_name16(request,column);
   if (name==NULL)
         PrintFormat("DB column name error: %s",sqlite3_errmsg16(sqlite3_db_handle(request)));
   return name!=NULL;
}
//-----------------------------------------------------------------------------


#endif
#endif