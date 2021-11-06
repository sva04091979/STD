#ifndef _STD_LIST_ITERATOR_PROXY_
#define _STD_LIST_ITERATOR_PROXY_

//#define _UNIT_TEST_

#include "ForwardProxy.mqh"

#define _tListIteratorProxy __std(ListIteratorProxy)
#define _tConstListIteratorProxy __std(ConstListIteratorProxy)
#define _tListIteratorProxyBase __std(ListIteratorProxyBase)


template<typename ProxyType,typename AccessType>
class _tListIteratorProxyBase:public _tForwardIteratorProxyBase<ProxyType,AccessType>{
protected:
   void* cPrev;
   _tListIteratorProxyBase():_tForwardIteratorProxyBase<ProxyType,AccessType>(),cPrev(NULL){}
   _tListIteratorProxyBase(AccessType &val):_tForwardIteratorProxyBase<ProxyType,AccessType>(val),cPrev(NULL){}
   _tListIteratorProxyBase(ProxyType* prev, ProxyType* next):
      _tForwardIteratorProxyBase<ProxyType,AccessType>(next),cPrev(prev){
      if (prev!=NULL)
         ((_tListIteratorProxyBase<ProxyType,AccessType>*)prev).Next(&this);
      if (next!=NULL)
         next.Prev(&this);
   }
   _tListIteratorProxyBase(AccessType &val,ProxyType* prev,ProxyType* next):
      _tForwardIteratorProxyBase<ProxyType,AccessType>(val,next),cPrev(prev){
      if (prev!=NULL)
         ((_tListIteratorProxyBase<ProxyType,AccessType>*)prev).Next(&this);
      if (next!=NULL)
         next.Prev(&this);
   }
public:
   ProxyType* Prev() const {return cPrev;}
protected:
   void Prev(void* prev) {cPrev=prev;}
};

template<typename Type>
class _tListIteratorProxy:public _tListIteratorProxyBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>{
public:
   _tListIteratorProxy():_tListIteratorProxyBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(){}
   _tListIteratorProxy(_tIteratorAccess<Type> &val):_tListIteratorProxyBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(val){}
   _tListIteratorProxy(_tListIteratorProxy* prev,_tListIteratorProxy* next):
      _tListIteratorProxyBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(prev,next){}
   _tListIteratorProxy(_tIteratorAccess<Type> &val, _tListIteratorProxy* prev, _tListIteratorProxy* next):
      _tListIteratorProxyBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(val,prev,next){}
};

template<typename Type>
class _tConstListIteratorProxy:public _tListIteratorProxyBase<_tConstListIteratorProxy<Type>,const _tIteratorAccess<Type>>{
public:
   _tConstListIteratorProxy():_tListIteratorProxyBase<_tConstListIteratorProxy<Type>,const _tIteratorAccess<Type>>(){}
   _tConstListIteratorProxy(const _tIteratorAccess<Type> &val):_tListIteratorProxyBase<_tConstListIteratorProxy<Type>,const _tIteratorAccess<Type>>(val){}
   _tConstListIteratorProxy(_tConstListIteratorProxy* prev,_tConstListIteratorProxy* next):
      _tListIteratorProxyBase<_tConstListIteratorProxy<Type>,const _tIteratorAccess<Type>>(prev,next){}
   _tConstListIteratorProxy(const _tIteratorAccess<Type> &val,_tConstListIteratorProxy* prev,_tConstListIteratorProxy* next):
      _tListIteratorProxyBase<_tConstListIteratorProxy<Type>,const _tIteratorAccess<Type>>(val,prev,next){}
};

#ifdef _UNIT_TEST_

bool __STD__Test__ListIteratorProxy(){
   _tIteratorAccess<int> _a0(_rv(0));
   _tIteratorAccess<int> _a1(_rv(1));
   _tIteratorAccess<int> _a2(_rv(2));
   _tListIteratorProxy<int> a0(_a0);
   _tListIteratorProxy<int> a1(_a1,&a0,NULL);
   _tListIteratorProxy<int> a2(_a2,&a1,NULL);
   _tListIteratorProxy<int> b;
   b=a0;
   ASSERT(b==a0,"");
   b=b.Next();
   ASSERT(b==a1,"");
   b=b.Next();
   ASSERT(b==a2,"");
   b=b.Prev();
   ASSERT(b==a1,"");
   return true;
}

bool __STD__UnitTest__ListProxy(){
   return __STD__UnitTest__ForwardProxy()&&
      __STD__Test__ListIteratorProxy();
}

#endif

#endif 