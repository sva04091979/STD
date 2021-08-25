#ifndef _STD_ITERATOR_PROXY_
#define _STD_ITERATOR_PROXY_

#include "..\..\Define\StdDefine.mqh"

#define _tIteratorProxyBase __std(IteratorProxyBase)
#define _tIteratorProxy __std(IteratorProxy)
#define _tIteratorAccess __std(IteratorAccess)

template<typename Type>
class _tIteratorAccess{
public:
   Type value;
   _tIteratorAccess(){}
   _tIteratorAccess(const _tIteratorAccess<Type>& other) {this=other;}
   _tIteratorAccess(const Type& val):value(val){}
   _tIteratorAccess<Type>* operator=(const _tIteratorAccess<Type>& other){
      this=other;
      return &this;
   }
   _tIteratorAccess<Type>* operator=(const Type& val){
      value=val;
      return &this;
   }
   bool operator ==(const _tIteratorAccess<Type>& other) {return &this==&other;}
   bool operator !=(const _tIteratorAccess<Type>& other) {return !(operator ==(other));}
};

template<typename AccessType,typename Type>
class _tIteratorProxyBase{
   AccessType* cAccess;
public:
   _tIteratorProxyBase():cAccess(NULL){}
   _tIteratorProxyBase(_tIteratorAccess<Type> &val):cAccess(&val) {}
   AccessType* __GetAccess() const {return cAccess;}
};



#endif
