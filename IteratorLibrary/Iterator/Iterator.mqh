#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) dIt.__GetAccess().cIteratorProxy.cValue

template<typename ProxyType,typename Type>
class STD_Iterator_Base_Ptr{
   ProxyType* cProxy;
public:
   STD_Iterator_Base_Ptr(ProxyType &mProxy):cProxy(&mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cProxy.__GetAccess();}
   void operator =(const STD_Iterator_Base_Ptr &mOther) {cProxy=mOther.Proxy();}
   void operator =(ProxyType &mProxy) {cProxy=&mProxy;}
   bool operator ==(const STD_Iterator_Base_Ptr &other) const {return cProxy==other.Proxy();}
   bool operator !=(const STD_Iterator_Base_Ptr &other) const {return cProxy!=other.Proxy();}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) const {return cProxy!=&mProxy;}
protected:
   ProxyType* Proxy() const {return cProxy;}
};

template<typename IteratorPtrType,typename ProxyType,typename Type>
struct _tIteratorBase{
   IteratorPtrType cIterator;
public:
   _tIteratorBase(ProxyType &mProxy):cIterator(mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cIterator.__GetAccess();}
   void operator =(const _tIteratorBase &mOther) {cIterator=mOther.cIterator;}
   void operator =(IteratorPtrType &it) {cIterator=it;}
   bool operator ==(const _tIteratorBase &other) const {return cIterator==other.cIterator;}
   bool operator !=(const _tIteratorBase &other) const {return cIterator!=other.cIterator;}
   bool operator ==(const IteratorPtrType &mProxy) const {return cIterator==cIterator;}
   bool operator !=(const IteratorPtrType &mProxy) const {return cIterator!=cIterator;}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<STD_Iterator_Base_Ptr<_tIteratorProxy<Type>,Type>,_tIteratorProxy<Type>,Type>{
   _tIterator(_tIteratorProxy<Type> &proxy):_tIteratorBase<STD_Iterator_Base_Ptr<_tIteratorProxy<Type>,Type>,_tIteratorProxy<Type>,Type>(proxy){}
};

#endif