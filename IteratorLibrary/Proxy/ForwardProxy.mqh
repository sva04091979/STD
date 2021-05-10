#ifndef _STD_FORWARD_ITERATOR_PROXY_
#define _STD_FORWARD_ITERATOR_PROXY_

#include "IteratorProxy.mqh"

#define _tForwardIteratorProxy __std(ForwardIteratorProxy)
#define _tForwardIteratorProxyBase __std(ForwardIteratorProxyBase)

template<typename ProxyType,typename Type>
class _tForwardIteratorProxyBase:public _tIteratorProxyBase<ProxyType,Type>{
protected:
   _tForwardIteratorProxyBase* cNext;
public:
   _tForwardIteratorProxyBase():_tIteratorProxyBase<ProxyType,Type>(),cNext(NULL){}
   _tForwardIteratorProxyBase(const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,Type>(),cNext((_tForwardIteratorProxyBase*)&next){}
   _tForwardIteratorProxyBase(const Type &val):_tIteratorProxyBase<ProxyType,Type>(val),cNext(NULL){}
   _tForwardIteratorProxyBase(const Type &val,const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,Type>(val),cNext((_tForwardIteratorProxyBase*)&next){}
   _tForwardIteratorProxyBase* Next() const {return cNext;}
};

template<typename Type>
class _tForwardIteratorProxy:public _tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>{
public:
   _tForwardIteratorProxy():_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(){}
   _tForwardIteratorProxy(const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(next){}
   _tForwardIteratorProxy(const Type &val):_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(val){}
   _tForwardIteratorProxy(const Type &val,const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tForwardIteratorProxy,Type>(val,next){}
   
};

#endif 