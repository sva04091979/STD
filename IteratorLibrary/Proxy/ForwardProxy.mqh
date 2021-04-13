#ifndef _STD_FORWARD_ITERATOR_PROXY_
#define _STD_FORWARD_ITERATOR_PROXY_

#include "IteratorProxy.mqh"

#define _tForwardIteratorProxy __std(ForwardProxy)
#define _tForwardIteratorProxyBase __std(ForwardProxyBase)

template<typename ProxyType,typename Type>
class _tForwardIteratorProxyBase:public _tIteratorProxyBase<ProxyType,Type>{
protected:
   _tForwardIteratorProxyBase* cNext;
public:
   _tForwardIteratorProxyBase():_tIteratorProxyBase<ProxyType,Type>(),cNext(NULL){}
   _tForwardIteratorProxyBase(_tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,Type>(),cNext(&next){}
   _tForwardIteratorProxyBase(const Type &val):_tIteratorProxyBase<ProxyType,Type>(val),cNext(NULL){}
   _tForwardIteratorProxyBase(const Type &val,_tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,Type>(val),cNext(&next){}
   _tForwardIteratorProxyBase* Next() return cNext;
};

template<typename Type>
class _tForwardIteratorProxy:public _tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>{
public:
   _tForwardIteratorProxy():_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(){}
   _tForwardIteratorProxy(const Type &val):_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(val){}
};

#endif 