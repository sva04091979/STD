#ifndef _STD_ITERATOR_PROXY_
#define _STD_ITERATOR_PROXY_

#include "..\..\Define\StdDefine.mqh"

#define _tIteratorProxyBase __std(IteratorProxyBase)
#define _tIteratorProxy __std(IteratorProxy)
#define _tConstIteratorProxy __std(ConstIteratorProxy)
#define _tIteratorAccess __std(IteratorAccess)

template<typename Type>
class _tIteratorAccess{
public:
   Type value;
   _tIteratorAccess(){}
   _tIteratorAccess(const _tIteratorAccess<Type>& other) {this=other;}
   _tIteratorAccess(const Type& val){value=val;}
   const _tIteratorAccess<Type>* operator=(const _tIteratorAccess<Type>& other){
      this=other;
      return &this;
   }
   const _tIteratorAccess<Type>* operator=(const Type& val){
      value=val;
      return &this;
   }
   bool operator ==(const _tIteratorAccess<Type>& other) {return &this==&other;}
   bool operator !=(const _tIteratorAccess<Type>& other) {return !(operator ==(other));}
};

template<typename AccessType>
class _tIteratorProxyBase{
   AccessType* cAccess;
public:
   _tIteratorProxyBase():cAccess(NULL){}
   _tIteratorProxyBase(AccessType& val):cAccess(&val) {}
   AccessType* __GetAccess() {return cAccess;}
   template<typename IteratorType>
   bool operator ==(const IteratorType& iterator) const {return cAccess==iterator.__GetAccess();}
   template<typename IteratorType>
   bool operator !=(const IteratorType& iterator) const {return !(operator==(iterator));}
};

template<typename Type>
class _tIteratorProxy:public _tIteratorProxyBase<_tIteratorAccess<Type>>{
public:
   _tIteratorProxy():_tIteratorProxyBase<_tIteratorAccess<Type>>(){}
   _tIteratorProxy(_tIteratorAccess<Type>& val):_tIteratorProxyBase<_tIteratorAccess<Type>>(val) {}
};

template<typename Type>
class _tConstIteratorProxy:public _tIteratorProxyBase<const _tIteratorAccess<Type>>{
public:
   _tConstIteratorProxy():_tIteratorProxyBase<const _tIteratorAccess<Type>>(){}
   _tConstIteratorProxy(const _tIteratorAccess<Type>& val):_tIteratorProxyBase<const _tIteratorAccess<Type>>(val) {}
};

#ifdef _UNIT_TEST_

bool __STD__Test__IteratorAccess(){
   _tIteratorAccess<int> a;
   _tIteratorAccess<STD_UnitTestStruct> b;
   _tIteratorAccess<int>* c=&a;
   _tIteratorAccess<int> d;
   a.value=8;
   d.value=a.value;
   b.value.i=5;
   b.value.d=6.4;
   ASSERT(a.value==8,"");
   ASSERT(a==c,"");
   ASSERT(a!=d,"");
   ASSERT(b.value.i==5,"");
   return true;
}

bool __STD__Test__IteratorProxy(){
   _tIteratorAccess<int> _a(_rv(5));
   _tIteratorProxy<int> a(_a);
   a.__GetAccess().value=10;
   ASSERT(a.__GetAccess().value==10,"");
   return true;
}

bool __STD__Test__ConstIteratorProxy(){
   _tIteratorAccess<int> _a(_rv(5));
   _tConstIteratorProxy<int> a(_a);
   ASSERT(a.__GetAccess().value==5,"");
   return true;
}

bool __STD__UnitTest__IteratorProxy(){
   return __STD__Test__IteratorAccess()&&
      __STD__Test__IteratorProxy()&&
      __STD__Test__ConstIteratorProxy();
}

#endif

#endif
