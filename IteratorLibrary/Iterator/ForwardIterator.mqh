#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

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
   _tForwardIteratorBase operator ++() {return cProxy=cProxy.Next();}
};

template<typename Type>
class STD_ForwardIteratorPtr:public STD_ForwardIteratorBasePtr<_tForwardIterator<Type>,STD_ForwardIteratorPtr,_tForwardIteratorProxy<Type>,Type>{
public:
   STD_ForwardIteratorPtr(const _tForwardIteratorProxy<Type> &proxy):
      STD_ForwardIteratorBasePtr<_tForwardIterator<Type>,STD_ForwardIteratorPtr,_tForwardIteratorProxy<Type>,Type>(proxy){}
};

template<typename Type>
struct _tForwardIterator:public _tForwardIteratorBase<_tForwardIterator,STD_ForwardIteratorPtr<Type>,_tForwardIteratorProxy<Type>,Type>{
   _tForwardIterator(const _tForwardIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardIterator,STD_ForwardIteratorPtr<Type>,_tForwardIteratorProxy<Type>,Type>(proxy){}
};

#endif