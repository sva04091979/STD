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
struct _tForwardIterator:public _tForwardIteratorBase<_tForwardIterator,STD_ForwardIteratorPtr<Type>,_tForwardIteratorProxy<Type>,Type>{
   _tForwardIterator(const _tForwardIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardIterator,STD_ForwardIteratorPtr<Type>,_tForwardIteratorProxy<Type>,Type>(proxy){}
};

#endif