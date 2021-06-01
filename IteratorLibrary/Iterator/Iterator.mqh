#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) (dIt).__GetAccess().cIteratorProxy.cValue[cIndex]

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
class STD_IteratorBasePtr{
protected:
   int cIndex;
   ProxyType* cProxy;
public:
   STD_IteratorBasePtr(const ProxyType &mProxy):cIndex(0),cProxy((ProxyType*)&mProxy){}
   STD_IteratorBasePtr(const ProxyType &mProxy,int index):cIndex(index),cProxy((ProxyType*)&mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cProxy.__GetAccess(cIndex);}
   void operator =(const IteratorPtrType &mOther) {cProxy=mOther.Proxy(); cIndex=mOther.Index();}
   void operator =(const IteratorType &it) {IteratorPtrType* other=it.It(); cProxy=other.Proxy(); cIndex=other.Index();}
   bool operator ==(const IteratorPtrType &other) const {return cProxy==other.Proxy();}
   bool operator !=(const IteratorPtrType &other) const {return cProxy!=other.Proxy();}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) const {return cProxy!=&mProxy;}
   bool operator ==(const IteratorType &it) const {return cProxy==it.It().Proxy();}
   bool operator !=(const IteratorType &it) const {return cProxy!=it.It().Proxy();}
   int Index() const {return cIndex;}
protected:
   ProxyType* Proxy() const {return cProxy;}
};

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
_tIteratorAccess<ProxyType> __GetAccess(STD_IteratorBasePtr<IteratorType,IteratorPtrType,ProxyType,Type>* ptr) {return ptr.__GetAccess();}

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
struct _tIteratorBase{
protected:
   IteratorPtrType cIterator;
public:
   _tIteratorBase(const ProxyType &mProxy):cIterator(mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cIterator.__GetAccess();}
   void operator =(const IteratorType &mOther) {cIterator=mOther.It();}
   void operator =(const IteratorPtrType &it) {cIterator=it;}
   bool operator ==(const IteratorType &other) const {return cIterator==other.It();}
   bool operator !=(const IteratorType &other) const {return cIterator!=other.It();}
   bool operator ==(const IteratorPtrType &mProxy) const {return cIterator==cIterator;}
   bool operator !=(const IteratorPtrType &mProxy) const {return cIterator!=cIterator;}
   IteratorPtrType* It() {return &cIterator;}
   const IteratorPtrType* It() const {return &cIterator;}
   int Index() const {return cIterator.Index();}
};

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
_tIteratorAccess<ProxyType> __GetAccess(_tIteratorBase<IteratorType,IteratorPtrType,ProxyType,Type> &it) {return it.__GetAccess();}

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