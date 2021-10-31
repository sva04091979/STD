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
/*
bool __STD__Test__ForwardConstIterator(){
   const _tIteratorAccess<int> __a(_rv(5));
   const _tIteratorAccess<int> __ax(_rv(15));
   const _tIteratorAccess<STD_UnitTestStruct> __b;
   ((_tIteratorAccess<STD_UnitTestStruct>)__b).value.i=5;
   ((_tIteratorAccess<STD_UnitTestStruct>)__b).value.d=6.4;
   _tConstIteratorProxy<int> _a(__a);
   _tConstIteratorProxy<int> _ax(__ax);
   _tConstIteratorProxy<STD_UnitTestStruct> _b(__b);
   _tConstIterator<int> a(_a);
   _tConstIterator<int> ax(_ax);
   _tConstIterator<STD_UnitTestStruct> b(_b);
   _tConstIterator<int> c(a); 
   ASSERT(_i(a)==5,"");
   ASSERT(_i(b).i==5,"");
   ASSERT(a==c,"");
   c=ax;
   ASSERT(a!=c,"");
   ASSERT(ax==c,"");
   return true;
}
*/
bool __STD__UnitTest__ForwardIterator(){
   return __STD__Test__ForwardIterator();
//   return __STD__UnitTest__IteratorProxy()&&
//      __STD__Test__Iterator()&&
//      __STD__Test__ConstIterator();
}

#endif


#endif