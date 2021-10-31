#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#define _UNIT_TEST_

#include "Iterator.mqh"
#include "..\Proxy\ForwardProxy.mqh"

#define _tForwardIterator __std(ForwardIterator)
#define _tForwardConstIterator __std(ForwardConstIterator)
#define _tForwardIteratorBase __std(ForwardIteratorBase)

template<typename ProxyType,typename AccessType>
struct _tForwardIteratorBase:public _tIteratorBase<ProxyType,AccessType>{
public:
   _tForwardIteratorBase(const ProxyType &mProxy):_tIteratorBase<ProxyType,AccessType>(mProxy){}
   _tForwardIteratorBase(const _tForwardIteratorBase<ProxyType,AccessType> &mOther):_tIteratorBase<ProxyType,AccessType>(mOther){}
   ProxyType* operator ++() {return cProxy=cProxy.Next();}
   _tForwardIteratorBase<ProxyType,AccessType> operator ++(int){
      _tForwardIteratorBase<ProxyType,AccessType> ret(this);
      cProxy=cProxy.Next();
      return ret;
   }
};

template<typename Type>
struct _tForwardIterator:public _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>{
   _tForwardIterator(const _tForwardIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>(proxy){}
   _tForwardIterator(const _tForwardIterator<Type> &other):
      _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>(other){}
};

template<typename Type>
struct _tForwardConstIterator:public _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>{
   _tForwardConstIterator(const _tForwardConstIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(proxy){}
   _tForwardConstIterator(const _tForwardConstIterator<Type> &other):
      _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(other){}
};

#endif