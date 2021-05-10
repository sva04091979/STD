#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) dIt.__GetAccess().cIteratorProxy.cValue

template<typename IteratorType,typename ProxyType,typename Type>
class STD_IteratorBasePtr{
   ProxyType* cProxy;
public:
   STD_IteratorBasePtr(ProxyType &mProxy):cProxy(&mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cProxy.__GetAccess();}
   void operator =(const STD_IteratorBasePtr &mOther) {cProxy=mOther.Proxy();}
   void operator =(const ProxyType &mProxy) {cProxy=(ProxyType*)&mProxy;}
   void operator =(const IteratorType &it) {cProxy=it.It().cProxy;}
   bool operator ==(const STD_IteratorBasePtr &other) const {return cProxy==other.Proxy();}
   bool operator !=(const STD_IteratorBasePtr &other) const {return cProxy!=other.Proxy();}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) const {return cProxy!=&mProxy;}
   bool operator ==(const IteratorType &it) const {return cProxy==it.It().cProxy;}
   bool operator !=(const IteratorType &it) const {return cProxy!=it.It().cProxy;}
protected:
   ProxyType* Proxy() const {return cProxy;}
};

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
struct _tIteratorBase{
protected:
   IteratorPtrType cIterator;
public:
   _tIteratorBase(ProxyType &mProxy):cIterator(mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cIterator.__GetAccess();}
   void operator =(const IteratorType &mOther) {cIterator=mOther.It();}
   void operator =(const IteratorPtrType &it) {cIterator=it;}
   bool operator ==(const IteratorType &other) const {return cIterator==other.It();}
   bool operator !=(const IteratorType &other) const {return cIterator!=other.It();}
   bool operator ==(const IteratorPtrType &mProxy) const {return cIterator==cIterator;}
   bool operator !=(const IteratorPtrType &mProxy) const {return cIterator!=cIterator;}
   IteratorPtrType* It() {return &cIterator;}
   const IteratorPtrType* It() const {return &cIterator;}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIterator,STD_IteratorBasePtr<_tIterator,_tIteratorProxy<Type>,Type>,_tIteratorProxy<Type>,Type>{
   _tIterator(_tIteratorProxy<Type> &proxy):_tIteratorBase<_tIterator,STD_IteratorBasePtr<_tIterator,_tIteratorProxy<Type>,Type>,_tIteratorProxy<Type>,Type>(proxy){}
};


#endif