#ifndef _STD_SQLLITE_
#define _STD_SQLLITE_
#ifdef __MQL4__


#define DATABASE_OPEN_READONLY 0x1
#define DATABASE_OPEN_READWRITE 0x2
#define DATABASE_OPEN_CREATE 0x4
#define DATABASE_OPEN_MEMORY 0x80
#define DATABASE_OPEN_COMMON 0x1000

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
#import

string DatabaseErrorCode(int errCode){
   return (string)errCode;
}

void DatabaseErrorCheck(string func, int errCode){
   if (errCode!=0)
      PrintFormat("%s error: %s",func,DatabaseErrorCode(errCode));
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
   int ret=0;
   int errCode=sqlite3_open_v2(fname,ret,flags,NULL);
   DatabaseErrorCheck(__FUNCTION__,errCode);
   return !errCode?ret:INVALID_HANDLE;
}
//-----------------------------------------------------------------------------------------
void DatabaseClose(int database){
   int errCode=sqlite3_close_v2(database);
   DatabaseErrorCheck(__FUNCTION__,errCode);
}
//-----------------------------------------------------------------------------------------
bool DatabaseExecute(int database,string sql){
   uchar query[];
   StringToCharArray(sql,query,0,WHOLE_ARRAY,CP_UTF8);
   int errCode=sqlite3_exec(database,query,NULL,NULL,NULL);
   DatabaseErrorCheck(__FUNCTION__,errCode);
   return !errCode;
}

#endif
#endif