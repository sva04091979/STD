#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) ((dIt).__GetAccess()).value

template<typename ProxyType,typename Type>
struct _tIteratorBase{
protected:
   ProxyType* cProxy;
public:
   _tIteratorBase(const ProxyType &mProxy):cProxy(&mProxy){}
   _tIteratorBase(const _tIteratorBase<ProxyType,Type>& other):cProxy(other.cProxy){}
   _tIteratorAccess<Type>* __GetAccess() {return &cPoxy.__GetAccess();}
   const _tIteratorAccess<Type>* __GetAccess() const {return &cPoxy.__GetAccess();}
   void operator =(const _tIteratorBase<ProxyType,Type> &it) {cProxy=it.cProxy;}
   bool operator ==(const _tIteratorBase<ProxyType,Type> &it) const {return cProxy.__GetAccess()==it.__GetAccess();}
   bool operator !=(const _tIteratorBase<ProxyType,Type> &it) const {return !(operator ==(it));}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIteratorProxy<Type>,Type>{
   _tIterator(const _tIteratorProxy<Type> &proxy):_tIteratorBase<_tIteratorProxy<Type>,Type>(proxy){}
};

#endif