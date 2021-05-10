#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "Iterator.mqh"
#include "..\Proxy\ForwardProxy.mqh"

#define _tForwardIterator __std(Iterator)
#define _tForwardIteratorBase __std(BaseIterator)

template<typename IteratorType>
class STD_Iterator_PTR{
   
}

template<typename ProxyType,typename Type>
struct _tForwardIterator:public _tIteratorBase<ProxyType,Type>{
public:
   _tForwardIterator(ProxyType &mProxy):_tIteratorBase<ProxyType,Type>(&mProxy){}
   
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIteratorProxy<Type>,Type>{
   _tIterator(_tIteratorProxy<Type> &proxy):_tIteratorBase<_tIteratorProxy<Type>,Type>(proxy){}
};

#endif