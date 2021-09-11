#ifndef _STD_FORWARD_ITERATOR_PROXY_
#define _STD_FORWARD_ITERATOR_PROXY_

#include "IteratorProxy.mqh"

#define _tForwardIteratorProxy __std(ForwardIteratorProxy)
#define _tConstForwardIteratorProxy __std(ConstForwardIteratorProxy)
#define _tForwardIteratorProxyBase __std(ForwardIteratorProxyBase)


template<typename AccessType>
class _tForwardIteratorProxyBase:public _tIteratorProxyBase<AccessType>{
protected:
   _tForwardIteratorProxyBase* cNext;
   _tForwardIteratorProxyBase():_tIteratorProxyBase<AccessType>(),cNext(NULL){}
   _tForwardIteratorProxyBase(const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<AccessType>(),cNext((_tForwardIteratorProxyBase*)&next){}
   _tForwardIteratorProxyBase(AccessType &val):_tIteratorProxyBase<AccessType>(val),cNext(NULL){}
   _tForwardIteratorProxyBase(AccessType &val,const _tForwardIteratorProxyBase &next):_tIteratorProxyBase<AccessType>(val),cNext((_tForwardIteratorProxyBase*)&next){}
public:
   _tForwardIteratorProxyBase* Next() const {return cNext;}
};

template<typename Type>
class _tForwardIteratorProxy:public _tForwardIteratorProxyBase<_tIteratorAccess<Type>>{
public:
   _tForwardIteratorProxy():_tForwardIteratorProxyBase<_tIteratorAccess<Type>>(){}
   _tForwardIteratorProxy(const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tIteratorAccess<Type>>(next){}
   _tForwardIteratorProxy(_tIteratorAccess<Type> &val):_tForwardIteratorProxyBase<_tIteratorAccess<Type>>(val){}
   _tForwardIteratorProxy(_tIteratorAccess<Type> &val,const _tForwardIteratorProxy &next):_tForwardIteratorProxyBase<_tIteratorAccess<Type>>(val,next){}
   
};

template<typename Type>
class _tConstForwardIteratorProxy:public _tForwardIteratorProxyBase<const _tIteratorAccess<Type>>{
public:
   _tConstForwardIteratorProxy():_tForwardIteratorProxyBase<const _tIteratorAccess<Type>>(){}
   _tConstForwardIteratorProxy(const _tConstForwardIteratorProxy &next):_tForwardIteratorProxyBase<const _tIteratorAccess<Type>>(next){}
   _tConstForwardIteratorProxy(const _tIteratorAccess<Type> &val):_tForwardIteratorProxyBase<const _tIteratorAccess<Type>>(val){}
   _tConstForwardIteratorProxy(const _tIteratorAccess<Type> &val,const _tConstForwardIteratorProxy &next):_tForwardIteratorProxyBase<const _tIteratorAccess<Type>>(val,next){}
   
};

#ifdef _UNIT_TEST_

bool __STD__Test__ForwardIteratorProxy(){
   _tIteratorAccess<int> _a(_rv(5));
   _tIteratorAccess<int> _b(_rv(7));
   _tForwardIteratorProxy<int> a(_a);
   _tForwardIteratorProxy<int> b(_b,a);
   _tForwardIteratorProxy<int> c;
   c=b;
   ASSERT(c.__GetAccess()==b.__GetAccess(),"");
   c=b.Next();
   ASSERT(c.__GetAccess()==a.__GetAccess(),"");
   return true;
}

bool __STD__Test__ConstForwardIteratorProxy(){
   const _tIteratorAccess<int> _a(_rv(5));
   const _tIteratorAccess<int> _b(_rv(7));
   _tConstForwardIteratorProxy<int> a(_a);
   _tConstForwardIteratorProxy<int> b(_b,a);
   _tConstForwardIteratorProxy<int> c;
   c=b;
   ASSERT(c.__GetAccess()==b.__GetAccess(),"");
   c=b.Next();
   ASSERT(c.__GetAccess()==a.__GetAccess(),"");
   return true;
}

bool __STD__UnitTest__ForwardProxy(){
   return __STD__UnitTest__IteratorProxy()&&
      __STD__Test__ForwardIteratorProxy()&&
      __STD__Test__ConstForwardIteratorProxy();
}

#endif

#endif 