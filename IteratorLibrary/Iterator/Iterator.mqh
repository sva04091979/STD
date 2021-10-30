#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

//#define _UNIT_TEST_

#include "..\Proxy\IteratorProxy.mqh"

#define _tIterator __std(Iterator)
#define _tConstIterator __std(ConstIterator)
#define _tIteratorBase __std(BaseIterator)

#define _i(dIt) ((dIt).__GetAccess()).value

template<typename ProxyType,typename AccessType>
struct _tIteratorBase{
protected:
   ProxyType* cProxy;
public:
   _tIteratorBase(const ProxyType &mProxy):cProxy((ProxyType*)&mProxy){}
   _tIteratorBase(const _tIteratorBase<ProxyType,AccessType>& other):cProxy(other.cProxy){}
   AccessType* __GetAccess() const {return cProxy.__GetAccess();}
   void operator =(const _tIteratorBase<ProxyType,AccessType> &it) {cProxy=it.cProxy;}
   bool operator ==(const _tIteratorBase<ProxyType,AccessType> &it) const {return cProxy.__GetAccess()==it.__GetAccess();}
   bool operator !=(const _tIteratorBase<ProxyType,AccessType> &it) const {return !(operator ==(it));}
   void operator =(ProxyType &proxy) {cProxy=proxy;}
   bool operator ==(ProxyType &proxy) const {return cProxy.__GetAccess()==proxy.__GetAccess();}
   bool operator !=(ProxyType &proxy) const {return !(operator ==(proxy));}
};

template<typename Type>
struct _tIterator:public _tIteratorBase<_tIteratorProxy<Type>,_tIteratorAccess<Type>>{
   _tIterator(_tIterator<Type>& other):_tIteratorBase<_tIteratorProxy<Type>,_tIteratorAccess<Type>>(other){}
   _tIterator(_tIteratorProxy<Type> &proxy):_tIteratorBase<_tIteratorProxy<Type>,_tIteratorAccess<Type>>(proxy){}
};

template<typename Type>
struct _tConstIterator:public _tIteratorBase<_tConstIteratorProxy<Type>,const _tIteratorAccess<Type>>{
   _tConstIterator(_tConstIterator<Type>& other):_tIteratorBase<_tConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(other){}
   _tConstIterator(_tConstIteratorProxy<Type> &proxy):_tIteratorBase<_tConstIteratorProxy<Type>,const _tIteratorAccess<Type>>(proxy){}
};

#ifdef _UNIT_TEST_

bool __STD__Test__Iterator(){
   _tIteratorAccess<int> __a(_rv(5));
   _tIteratorAccess<int> __ax(_rv(15));
   _tIteratorAccess<STD_UnitTestStruct> __b;
   __b.value.i=5;
   __b.value.d=6.4;
   _tIteratorProxy<int> _a(__a);
   _tIteratorProxy<int> _ax(__ax);
   _tIteratorProxy<STD_UnitTestStruct> _b(__b);
   _tIterator<int> a(_a);
   _tIterator<int> ax(_ax);
   _tIterator<STD_UnitTestStruct> b(_b);
   _i(a)=26;
   _i(b).i=87;
   _i(b).d=7.9;
   _tIterator<int> c(a); 
   ASSERT(_i(a)==26,"");
   ASSERT(_i(b).i==87,"");
   ASSERT(a==c,"");
   c=ax;
   ASSERT(a!=c,"");
   ASSERT(ax==c,"");
   return true;
}

bool __STD__Test__ConstIterator(){
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

bool __STD__UnitTest__Iterator(){
   return __STD__UnitTest__IteratorProxy()&&
      __STD__Test__Iterator()&&
      __STD__Test__ConstIterator();
}

#endif

#endif