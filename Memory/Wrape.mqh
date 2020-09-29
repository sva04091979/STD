#ifndef _STD_C_WRAPE_
#define _STD_C_WRAPE_

#include <STD\Define\StdDefine.mqh>

#ifdef USING_STD
   #define _tWrape __std(CWrape)
   #define _tNumeric __std(CWrapeNumeric)
   #define _tReference __std(CWrapeRefer)
#endif

NAMESPACE(STD)

template<typename T,typename Type>
class CWrape{
protected:
   T     cValue;
protected:
         CWrape(){}
public: 
   Type* const Set(const Type &mVal) {cValue=_(mVal); return &this;}
   Type* const This()   {return (Type*)&this;}
   T Get() const {return cValue;}
   T Dereference() const {return cValue;}
   T operator =(const Type &mVal)   {cValue=_(mVal); return cValue;}
};

template<typename T>
class CWrapeNumeric:public CWrape<T,CWrapeNumeric<T>>{
public:
         CWrapeNumeric():CWrape<T,CWrapeNumeric<T>>(){}
         CWrapeNumeric(T mValue):CWrape<T,CWrapeNumeric<T>>(){cValue=mValue;}
         CWrapeNumeric(const CWrapeNumeric<T> &mWrape):CWrape<T,CWrapeNumeric<T>>(){cValue=_(mWrape);}
   CWrapeNumeric<T>* const Set(T mVal)                      {cValue=mVal; return &this;}
   bool operator !()                                  const {return !cValue;}
   bool operator ==(T mValue)                         const {return cValue==mValue;}
   bool operator ==(const CWrapeNumeric<T> &mValue)   const {return cValue==_(mValue);}
   bool operator <(T mValue)                          const {return cValue<mValue;}
   bool operator <(const CWrapeNumeric<T> &mValue)    const {return cValue<_(mValue);}
   bool operator >(T mValue)                          const {return cValue>mValue;}
   bool operator >(const CWrapeNumeric<T> &mValue)    const {return cValue>_(mValue);}
   bool operator <=(T mValue)                         const {return cValue<=mValue;}
   bool operator <=(const CWrapeNumeric<T> &mValue)   const {return cValue<=_(mValue);}
   bool operator >=(T mValue)                         const {return cValue>=mValue;}
   bool operator >=(const CWrapeNumeric<T> &mValue)   const {return cValue>=_(mValue);}
   T operator =(T mVal)                                     {return cValue=mVal;}
   T operator ++()                                          {return ++cValue;}
   T operator ++(int)                                       {return cValue++;}
   T operator --()                                          {return --cValue;}
   T operator --(int)                                       {return cValue--;}
   T operator +=(T mValue)                                  {return cValue+=mValue;}
   T operator +=(const CWrapeNumeric<T> &mValue)            {return cValue+=_(mValue);}
   T operator -=(T mValue)                                  {return cValue-=mValue;}
   T operator -=(const CWrapeNumeric<T> &mValue)            {return cValue-=_(mValue);}
   T operator *=(T mValue)                                  {return cValue*=mValue;}
   T operator *=(const CWrapeNumeric<T> &mValue)            {return cValue*=_(mValue);}
   T operator /=(T mValue)                                  {return cValue/=mValue;}
   T operator /=(const CWrapeNumeric<T> &mValue)            {return cValue/=_(mValue);}
   T operator %=(T mValue)                                  {return Remainder(cValue,mValue);} 
   T operator %=(const CWrapeNumeric<T> &mValue)            {return Remainder(cValue,_(mValue));}
private:
   T Remainder(T &mRes,T mVal);
};
//-------------------------------------------------------------------------------------------
template<typename T>
T CWrapeNumeric::Remainder(T &mRes,T mVal){
   long res=long(mRes/mVal);
   return mRes-=T(res*mVal);
}

template<typename T>
class CWrapeRefer:public CWrape<T,CWrapeRefer<T>>{
public:
         CWrapeRefer(){}
         CWrapeRefer(const T &mValue) {cValue=mValue;}
         CWrapeRefer(const CWrapeRefer<T> &mWrape) {cValue=_(mWrape);}
   CWrapeRefer<T>* const Set(const T &mVal)                 {cValue=mVal; return &this;}     
   T operator =(const T &mVal)                              {cValue=mVal; return cValue;}
};

END_SPACE

#endif