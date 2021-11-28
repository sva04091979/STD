#ifndef _STD_I_LIST_ITERATOR_
#define _STD_I_LIST_ITERATOR_

//#define _UNIT_TEST_

#include "ForwardIterator.mqh"
#include "..\Proxy\ListProxy.mqh"

#define _tListIterator __std(ListIterator)
#define _tListConstIterator __std(ListConstIterator)
#define _tListIteratorBase __std(ListIteratorBase)

template<typename ProxyType,typename AccessType>
struct _tListIteratorBase:public _tForwardIteratorBase<ProxyType,AccessType>{
public:
   _tListIteratorBase(const ProxyType &mProxy):_tForwardIteratorBase<ProxyType,AccessType>(mProxy){}
   _tListIteratorBase(const _tListIteratorBase<ProxyType,AccessType> &mOther):_tForwardIteratorBase<ProxyType,AccessType>(mOther){}
   ProxyType* operator --() {cProxy=cProxy.Prev(); return cProxy;}
   _tListIteratorBase<ProxyType,AccessType> operator --(int){
      _tListIteratorBase<ProxyType,AccessType> ret(this);
      cProxy=cProxy.Prev();
      return ret;
   }
};

template<typename Type>
struct _tListIterator:public _tListIteratorBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>{
   _tListIterator(const _tListIteratorProxy<Type> &proxy):
      _tForwardIteratorBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(proxy){}
   _tListIterator(const _tListIterator<Type> &other):
      _tForwardIteratorBase<_tListIteratorProxy<Type>,_tIteratorAccess<Type>>(other){}
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
   _tForwardIteratorProxy<int> _a1(__a1,&_a0);
   _tForwardIteratorProxy<int> _a2(__a2,&_a1);
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