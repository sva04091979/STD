#ifndef _STD_ITERATOR_PROXY_
#define _STD_ITERATOR_PROXY_

#include "..\..\Define\StdDefine.mqh"

#define _tIteratorProxyBase __std(IteratorProxyBase)
#define _tIteratorProxy __std(IteratorProxy)
#define _tIteratorAccess __std(SIteratorAccess)

template<typename ProxyType>
struct _tIteratorAccess{
   ProxyType* cIteratorProxy;
   int cIndex;
   _tIteratorAccess(ProxyType* proxy,int index):cIteratorProxy(proxy),cIndex(index){}
   _tIteratorAccess(_tIteratorAccess<ProxyType> &other){this=other;}
};

template<typename Type>
class STD_IteratorProxyOnce{
public:
   Type cValue[1];
   STD_IteratorProxyOnce(){}
   STD_IteratorProxyOnce(const Type &val){
      cValue[0]=val;
   }
};

template<typename ProxyType,typename ProxyBaseType,typename Type>
class _tIteratorProxyBase:public ProxyBaseType{
public:
   _tIteratorProxyBase():ProxyBaseType(){}
   _tIteratorProxyBase(const Type &val):ProxyBaseType(val){}
   _tIteratorAccess<ProxyType> __GetAccess(int index) {_tIteratorAccess<ProxyType> ret(&this,index); return ret;}
};

template<typename Type>
class _tIteratorProxy:public _tIteratorProxyBase<_tIteratorProxy,STD_IteratorProxyOnce<Type>,Type>{
public:
   _tIteratorProxy():_tIteratorProxyBase<_tIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(){}
   _tIteratorProxy(const Type &val):_tIteratorProxyBase<_tIteratorProxy,STD_IteratorProxyOnce<Type>,Type>(val){}
};

#endif