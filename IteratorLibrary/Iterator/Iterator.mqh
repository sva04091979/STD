#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) STD_SingletoneIteratorAccess::Ptr().GetAccess((dIt).__GetAccess()).__GetProxy().cValue[STD_SingletoneIteratorAccess::Index()]

class STD_SingletoneIteratorAccess{
   static int cIndex;
   STD_SingletoneIteratorAccess(){}
public:
   static STD_SingletoneIteratorAccess* Ptr(){
      static STD_SingletoneIteratorAccess instance;
      return &instance;
   }
   static int Index() {return cIndex;}
   template<typename IteratorPtrType>
   IteratorPtrType* GetAccess(IteratorPtrType* it){
      cIndex=it.__GetIndex();
      return it;
   }
};

int STD_SingletoneIteratorAccess::cIndex=0;
STD_SingletoneIteratorAccess* __tmp_STD_SingletoneIteratorAccess=STD_SingletoneIteratorAccess::Ptr();

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
class STD_IteratorBasePtr{
protected:
   int cIndex;
   ProxyType* cProxy;
public:
   STD_IteratorBasePtr(const ProxyType &mProxy):cIndex(0),cProxy((ProxyType*)&mProxy){}
   STD_IteratorBasePtr(const ProxyType &mProxy,int index):cIndex(index),cProxy((ProxyType*)&mProxy){}
   STD_IteratorBasePtr* __GetAccess() {return &this;}
   const STD_IteratorBasePtr* __GetAccess() const {return &this;}
   ProxyType* __GetProxy() const {return cProxy;}
   int __GetIndex() const {return cIndex;}
   void operator =(const IteratorPtrType &mOther) {cProxy=mOther.cProxy; cIndex=mOther.cIndex;}
   void operator =(const IteratorType &it) {const IteratorPtrType* other=it.__GetAccess(); cProxy=other.cProxy; cIndex=other.cIndex;}
   bool operator ==(const IteratorPtrType &other) const {return cProxy==other.cProxy;}
   bool operator !=(const IteratorPtrType &other) const {return cProxy!=other.cProxy;}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) const {return cProxy!=&mProxy;}
   bool operator ==(const IteratorType &it) const {return cProxy==it.__GetAccess().cProxy;}
   bool operator !=(const IteratorType &it) const {return cProxy!=it.__GetAccess().cProxy;}
};

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
struct _tIteratorBase{
protected:
   IteratorPtrType cIterator;
public:
   _tIteratorBase(const ProxyType &mProxy):cIterator(mProxy){}
   const IteratorPtrType* __GetAccess() const {return &cIterator;}
   IteratorPtrType* __GetAccess() {return &cIterator;}
   void operator =(const IteratorType &mOther) {cIterator=mOther.__GetAccess();}
   void operator =(const IteratorPtrType &it) {cIterator=it;}
   bool operator ==(const IteratorType &other) const {return cIterator==other.__GetAccess();}
   bool operator !=(const IteratorType &other) const {return cIterator!=other.__GetAccess();}
   bool operator ==(const IteratorPtrType &mProxy) const {return cIterator==cIterator;}
   bool operator !=(const IteratorPtrType &mProxy) const {return cIterator!=cIterator;}
};

template<typename Type>
class STD_IteratorPtr:public STD_IteratorBasePtr<_tIterator<Type>,STD_IteratorPtr,_tIteratorProxy<Type>,Type>{
public:
   STD_IteratorPtr(const _tIteratorProxy<Type> &proxy):STD_IteratorBasePtr<_tIterator<Type>,STD_IteratorPtr,_tIteratorProxy<Type>,Type>(proxy){}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIterator,STD_IteratorPtr<Type>,_tIteratorProxy<Type>,Type>{
   _tIterator(const _tIteratorProxy<Type> &proxy):_tIteratorBase<_tIterator,STD_IteratorPtr<Type>,_tIteratorProxy<Type>,Type>(proxy){}
};

#endif