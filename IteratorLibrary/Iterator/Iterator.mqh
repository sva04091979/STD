#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) dIt.__GetAccess().cIteratorProxy.cIteratorValue

template<typename ProxyType,typename Type>
struct _tIteratorBase{
   ProxyType* cProxy;
public:
   _tIteratorBase(ProxyType &mProxy):cProxy(&mProxy){}
   _tIteratorAccess<ProxyType> __GetAccess() const {return cProxy.__GetAccess();}
   Type Dereference() const {return _(cProxy);}
   void operator =(const _tIteratorBase &mOther) {cProxy=mOther.Proxy();}
   void operator =(ProxyType &mProxy) {cProxy=&mProxy;}
   bool operator ==(const _tIteratorBase &other) const {return cProxy==other.Proxy();}
   bool operator !=(const _tIteratorBase &other) const {return cProxy!=other.Proxy();}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) {return cProxy!=&mProxy;}
protected:
   ProxyType* Proxy() const {return cProxy;}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIteratorProxy<Type>,Type>{
   _tIterator(_tIteratorProxy<Type> &proxy):_tIteratorBase<_tIteratorProxy<Type>,Type>(proxy){}
};

#endif