#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "Iterator.mqh"
#include "..\Proxy\ForwardProxy.mqh"

#define _tForwardIterator __std(ForwardIterator)
#define _tForwardIteratorBase __std(ForwardIteratorBase)

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
class STD_ForwardIteratorBasePtr:public STD_IteratorBasePtr<IteratorType,IteratorPtrType,ProxyType,Type>{
public:
   STD_ForwardIteratorBasePtr(const ProxyType &proxy):
      STD_IteratorBasePtr<IteratorType,IteratorPtrType,ProxyType,Type>(proxy){}
   IteratorPtrType* Next(){
      cProxy=cProxy.Next();
      return &this;
   }
};

template<typename IteratorType,typename IteratorPtrType,typename ProxyType,typename Type>
struct _tForwardIteratorBase:public _tIteratorBase<IteratorType,IteratorPtrType,ProxyType,Type>{
public:
   _tForwardIteratorBase(const ProxyType &mProxy):_tIteratorBase<IteratorType,IteratorPtrType,ProxyType,Type>(mProxy){}
   IteratorPtrType* operator ++() {return cIterator.Next();}
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