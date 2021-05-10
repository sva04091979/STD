#ifndef _STD_ITERATOR_PROXY_
#define _STD_ITERATOR_PROXY_

#include "..\..\Define\StdDefine.mqh"

#define _tIteratorProxyBase __std(IteratorProxyBase)
#define _tIteratorProxy __std(IteratorProxy)
#define _tIteratorAccess __std(SIteratorAccess)

template<typename ProxyType>
struct _tIteratorAccess{
   ProxyType* cIteratorProxy;
   _tIteratorAccess(ProxyType* proxy):cIteratorProxy(proxy){}
   _tIteratorAccess(_tIteratorAccess<ProxyType> &other){this=other;}
};

template<typename ProxyType,typename Type>
class _tIteratorProxyBase{
public:
   Type cValue;
   _tIteratorProxyBase(){}
   _tIteratorProxyBase(const Type &val):cValue(val){}
   _tIteratorAccess<ProxyType> __GetAccess() {_tIteratorAccess<ProxyType> ret(&this); return ret;}
};

template<typename Type>
class _tIteratorProxy:public _tIteratorProxyBase<_tIteratorProxy,Type>{
public:
   _tIteratorProxy():_tIteratorProxyBase<_tIteratorProxy,Type>(){}
   _tIteratorProxy(const Type &val):_tIteratorProxyBase<_tIteratorProxy,Type>(val){}
};

#endif