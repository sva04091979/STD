#ifndef _STD_FORWARD_ITERATOR_PROXY_
#define _STD_FORWARD_ITERATOR_PROXY_

#include "IteratorProxy.mqh"

#define _tForwardIteratorProxy __std(ForwardIteratorProxy)
#define _tForwardIteratorProxyBase __std(ForwardIteratorProxyBase)

template<typename ProxyType,typename ProxyBaseType,typename Type>
class _tForwardIteratorProxyBase:public _tIteratorProxyBase<ProxyType,ProxyBaseType,Type>{
protected:
   _tForwardIteratorProxyBase* cNext;
public:
   _tForwardIteratorProxyBase():_tIteratorProxyBase<ProxyType,ProxyBaseType,Type>(),cNext(NULL){}
   _tForwardIteratorProxyBase(const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,ProxyBaseType,Type>(),cNext((_tForwardIteratorProxyBase*)&next){}
   _tForwardIteratorProxyBase(const Type &val):_tIteratorProxyBase<ProxyType,ProxyBaseType,Type>(val),cNext(NULL){}
   _tForwardIteratorProxyBase(const Type &val,const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<ProxyType,ProxyBaseType,Type>(val),cNext((_tForwardIteratorProxyBase*)&next){}
   _tForwardIteratorProxyBase* Next() const {return cNext;}
};

template<typename Type>
class _tForwardIteratorProxy:public _tForwardIteratorProxyBase<_tForwardIteratorProxy,STD_IteratorProxyOnce<Type>,Type>{
public:
   _tForwardIteratorProxy():_tForwardIteratorProxyBase<_tForwardIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(){}
   _tForwardIteratorProxy(const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tForwardIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(next){}
   _tForwardIteratorProxy(const Type &val):_tForwardIteratorProxyBase<_tForwardIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(val){}
   _tForwardIteratorProxy(const Type &val,const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tForwardIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(val,next){}
   
};

#endif 