#ifndef _STD_DEFINE_
#define _STD_DEFINE_

#ifdef __MQL5__
   #define NAMESPACE(dName) namespace dName {
   #define END_SPACE }
   #define __std(dName) STD::dName
   #define _tSizeT ulong
#else
   #define NAMESPACE(dName)
   #define END_SPACE
   #define __std(dName) dName
   #define _tSizeT uint
#endif

#define EQUITY AccountInfoDouble(ACCOUNT_EQUITY)
#define BALLANCE AccountInfoDouble(ACCOUNT_BALANCE)
#define TOTAL_PROFIT AccountInfoDouble(ACCOUNT_PROFIT)
#define ASK SymbolInfoDouble(NULL,SYMBOL_ASK)
#define BID SymbolInfoDouble(NULL,SYMBOL_BID)
#define OPEN(i) iOpen(NULL,PERIOD_CURRENT,i)
#define CLOSE(i) iClose(NULL,PERIOD_CURRENT,i)
#define HIGH(i) iHigh(NULL,PERIOD_CURRENT,i)
#define LOW(i) iLow(NULL,PERIOD_CURRENT,i)
#define VOLUME(i) iVolume(NULL,PERIOD_CURRENT,i)
#define SPREAD int(SymbolInfoInteger(NULL,SYMBOL_SPREAD))

#ifdef _DEBUG
   #define DEL(dObj) do if (CheckPointer(dPtr)==POINTER_DYNAMIC) delete dPtr; while(false)
   #define DELETE(dObj) do if (CheckPointer(dPtr)==POINTER_DYNAMIC) {delete dPtr; dPtr=NULL;} while(false)
#else
   #define DEL(dObj) delete dObj
   #define DELETE(dObj) do {delete dObj; dObj=NULL;} while(false)
#endif

#define _(dPtr) dPtr.Dereference()
#define _p(dPtr) dPtr.OverloadPtr()
#define __sf StringFormat

#define MINUTE          60
#define HOUR            3600
#define DAY             86400
#define WEEK            604800
#define JANUARY         2678400
#define FEBRUARY        2419200
#define FEBRUARY_BIG    2505600
#define MARCH           JANUARY
#define APRIL           2592000
#define MAY             JANUARY
#define JUNE            APRIL
#define JULY            JANUARY
#define AUGUST          JANUARY
#define SEPTEMBER       APRIL
#define OCTOBER         JANUARY
#define NOVEMBER        APRIL
#define DECEMBER        JANUARY
#define QUATER_1        7776000
#define QUATER_1_BIG    7862400
#define QUATER_2        7862400
#define QUATER_3        7948800
#define QUATER_4        QUATER_3
#define HALF_YEAR_1     15638400
#define HALF_YEAR_1_BIG 15724800
#define HALF_YEAR_2     15897600
#define YEAR            31536000
#define YEAR_BIG        31622400

#define _rv(dVal) (__std(FRVWrape(dVal))).cVal

#ifdef USING_STD
   #define _eCompare __std(ECompare)
   #define _eDirect __std(EDirect)
   #define _fMove __std(Move)
   #define _fSwap __std(Swap)
#endif

NAMESPACE(STD)

enum ECompare{
   LESS=-1,
   EQUALLY=0,
   MORE=1
};

enum EDirect{
   UP=1,
   DOWN=-1
};

template<typename T>
T* Move(T* &mPtr){
   T* ret=mPtr;
   mPtr=NULL;
   return ret;}

template<typename T1,typename T2>
void Swap(T1 &l,T2 &r){
   T1 tmp=l;
   l=r;
   r=tmp;}

template<typename T>
class RVWrape{
public:
   T cVal;
   RVWrape(T mVal):cVal(mVal){}
   RVWrape(RVWrape<T> &mOther){this=mOther;}
};

template<typename T>
RVWrape<T> FRVWrape(T fVal){return RVWrape<T>(fVal);}

END_SPACE

#endif