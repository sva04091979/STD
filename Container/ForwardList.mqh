#ifndef _STD_FORWARD_LIST_
#define _STD_FORWARD_LIST_

#include "ContainerInterface\IForwardList.mqh"
#include "ContainerNode\ForwardNode.mqh"
#include <STD\Iterator\IForwardIterator.mqh>

#define _tForwardList __std(CForwardList)
#define _tForwardIterator __std(SForwardIterator)

#define _tdeclForwardList __decl(CForwardList)
#define _tdeclForwardIterator __decl(SForwardIterator)
#define _tdeclForwardNode __decl(CForwardNode)
#define _tdeclForwardNodeEnd __decl(CForwardNodeEnd)

NAMESPACE(STD)

template<typename Type>
class _tdeclForwardNode;

template<typename Type>
class _tdeclForwardNode:public _tdeclIForwardNode<_tdeclForwardNode<Type>,Type>{
protected:
  ~_tdeclForwardNode(){}
public:
   _tdeclForwardNode():_tdeclIForwardNode<_tdeclForwardNode<Type>,Type>(){}
   _tdeclForwardNode(const Type &mObj,_tdeclForwardNode<Type>* mNext):_tdeclIForwardNode<_tdeclForwardNode<Type>,Type>(mObj,mNext){}
   _tdeclForwardNode(const _tdeclForwardNode<Type> &mOther):_tdeclIForwardNode<_tdeclForwardNode<Type>,Type>(mOther){}
};

template<typename Type>
class _tdeclForwardNodeEnd:public _tdeclForwardNode<Type>{
public:
   _tdeclForwardNodeEnd():_tdeclForwardNode<Type>(){}
   bool IsEnd() override const {return true;}
   bool Equal(const _tdeclForwardNode<Type> &mOther) override {return mOther.IsEnd();}
};

template<typename Type>
struct _tdeclForwardIterator:public _tdeclIForwardIterator<_tdeclForwardList<Type>,_tdeclForwardIterator<Type>,_tdeclForwardNode<Type>,Type>{
   _tdeclForwardIterator(_tdeclForwardNode<Type>* mNode,_tdeclForwardList<Type>* mContainer):
      _tdeclIForwardIterator<_tdeclForwardList<Type>,_tdeclForwardIterator<Type>,_tdeclForwardNode<Type>,Type>(mNode,mContainer){}
   _tdeclForwardIterator(const _tdeclForwardIterator<Type> &mOther):
      _tdeclIForwardIterator<_tdeclForwardList<Type>,_tdeclForwardIterator<Type>,_tdeclForwardNode<Type>,Type>(mOther){}
};

#define __Proxy _tdeclForwardProxy<_tdeclForwardList<Type>,_tdeclForwardNode<Type>,Type>
#define __IForwardList _tdeclIForwardList<_tdeclForwardList<Type>,_tdeclForwardIterator<Type>,__Proxy,_tdeclForwardNode<Type>,_tdeclForwardNodeEnd<Type>,Type>

template<typename Type>
class _tdeclForwardList:public __IForwardList{
public:
   _tdeclForwardList():__IForwardList(){}
   _tdeclForwardList(Type &mArr[]):__IForwardList(mArr){}
   _tdeclForwardList(_tdeclForwardList<Type> &mOther):__IForwardList(mOther){}
  ~_tdeclForwardList() {Clear();}
};
//--------------------------------------------------------------
template<typename T>
void _fdeclSwap(_tdeclForwardList<T> &fFirst,_tdeclForwardList<T> &fSecond){
   fFirst.Swap(fSecond);
}
//--------------------------------------------------------------
template<typename T>
void Free(_tdeclForwardList<T> &fList){
   while(!fList.IsEmpty()) delete fList.PopFront();
}

#undef __Proxy
#undef __IForwardList

END_SPACE

struct SUnitTestForwardList{
   int a;
   SUnitTestForwardList(){}
   SUnitTestForwardList(int _a):a(_a){}
   SUnitTestForwardList(SUnitTestForwardList &mOther){this=mOther;}
   bool operator ==(SUnitTestForwardList &mOther) {return a==mOther.a;}
};
   
void UnitTestForwardList(void){
   int x[]={0,1,2,3,4,5,6,7,8,9};
   _tForwardList<int> _test(x);
   _tForwardList<int> test(_test);
   _tForwardIterator<int> it=test.Begin();
   ++it;
   it=test.InsertAfter(++it,_rv(777));
   PrintFormat("Size=%u",test.Size());
   PrintFormat("It=%i",_(it));
   for (it=test.Begin();!it.IsEnd();++it)
      Print(_(it));
   _tForwardList<SUnitTestForwardList> test1();
   for (int i=0;i<ArraySize(x);++i){
      test1.PushFront(SUnitTestForwardList(i));
   }
   _tForwardIterator<SUnitTestForwardList> _it=test1.Begin();
   ++_it;
   _it=test1.InsertAfter(++_it,SUnitTestForwardList(777));
   PrintFormat("Size=%u",test1.Size());
   PrintFormat("It=%i",_(_it).a);
   test1.EraceAfter(_it);
   for (_it=test1.Begin();!_it.IsEnd();++_it)
      Print(_(_it).a);
}

#endif