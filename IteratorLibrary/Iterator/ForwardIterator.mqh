#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

//#define _UNIT_TEST_

#include "Iterator.mqh"
#include "..\Proxy\ForwardProxy.mqh"

#define _tForwardIterator __std(ForwardIterator)
#define _tForwardConstIterator __std(ForwardConstIterator)
#define _tForwardIteratorBase __std(ForwardIteratorBase)

template<typename ProxyType,typename AccessType>
struct _tForwardIteratorBase:public _tIteratorBase<ProxyType,AccessType>{
public:
   _tForwardIteratorBase(const ProxyType &mProxy):_tIteratorBase<ProxyType,AccessType>(mProxy){}
   _tForwardIteratorBase(const _tForwardIteratorBase<ProxyType,AccessType> &mOther):_tIteratorBase<ProxyType,AccessType>(mOther){}
   ProxyType* operator ++() {cProxy=cProxy.Next(); return cProxy;}
   _tForwardIteratorBase<ProxyType,AccessType> operator ++(int){
      _tForwardIteratorBase<ProxyType,AccessType> ret(this);
      cProxy=cProxy.Next();
      return ret;
   }
};

template<typename Type>
struct _tForwardIterator:public _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>{
   _tForwardIterator(const _tForwardIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>(proxy){}
   _tForwardIterator(const _tForwardIterator<Type> &other):
      _tForwardIteratorBase<_tForwardIteratorProxy<Type>,_tIteratorAccess<Type>>(other){}
};

template<typename Type>
struct _tForwardConstIterator:public _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>{
   _tForwardConstIterator(const _tForwardConstIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(proxy){}
   _tForwardConstIterator(const _tForwardConstIterator<Type> &other):
      _tForwardIteratorBase<_tForwardConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(other){}
};

#ifdef _UNIT_TEST_

bool __STD__Test__ForwardIterator(){
   _tIteratorAccess<int> __a0(_rv(0));
   _tIteratorAccess<int> __a1(_rv(1));
   _tIteratorAccess<int> __a2(_rv(2));
   _tForwardIteratorProxy<int> _a0(__a0);
   _tForwardIteratorProxy<int> _a1(__a1,_a0);
   _tForwardIteratorProxy<int> _a2(__a2,_a1);
   _tForwardIterator<int> a0(_a0);
   _tForwardIterator<int> a1(_a1);
   _tForwardIterator<int> a2(_a2);
   ASSERT(_i(a2)==2,"");
   ASSERT(++a2==a1,"");
   ASSERT(a2==a1,"");
   ASSERT(a2++==a1,"");
   ASSERT(a2==a0,"");
   return true;
}
bool __STD__UnitTest__ForwardIterator(){
   return __STD__UnitTest__Iterator()&&
      __STD__UnitTest__ForwardProxy()&&
      __STD__Test__ForwardIterator();
}

#endif


#endif