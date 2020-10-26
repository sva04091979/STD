#ifndef _STD_FORWARD_LIST_
#define _STD_FORWARD_LIST_

#include "Container.mqh"
#include "ContainerNode.mqh"
#include <STD\Iterator\IForwardIterator.mqh>

#define _tForwardList __std(CForwardList)
#define _tForwardIterator __std(SForwardIterator)

#define _tdeclForwardList __decl(CForwardList)
#define _tdeclForwardIterator __decl(SForwardIterator)
#define _tdeclForwardNode __decl(CForwardNode)

NAMESPACE(STD)

template<typename T>
class _tdeclForwardNode:public _tdecl_ForwardNode<T,_tdeclForwardNode<T>>{
public:
   _tdeclForwardNode(const T &mObj,_tdeclForwardNode<T>* mNext):_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(mObj,mNext){}
};

template<typename T>
struct _tdeclForwardIterator:public _tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>{
   _tdeclForwardIterator(_tdeclForwardNode<T>* mNode):_tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>(mNode){}
   _tdeclForwardIterator(const _tdeclForwardIterator<T> &mOther):
      _tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>((_tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>)other){}
};

template<typename T>
class _tdeclForwardList:public _tdeclContainer{
protected:
   _tdeclForwardNode<T>* cFront;
public:
  ~CForwardList() {DEL(cFront);}
   _tdeclForwardIterator<T> Begin() {return _tdeclForwardIterator<T>(cFront);}
   T Front() const {return _(cFront);}
   void Push(T &obj);
   T Pop();
};
//---------------------------------------------------------
template<typename T>
void CForwardList::Push(T &obj){
   ++cSize;
   cFront=new CForwardNode<T>(obj,cFront);}
//----------------------------------------------------------
template<typename T>
T CForwardList::Pop(){
   if (!cFront) return _(cFront);
   --cSize;
   T ret=_(cFront);
   cFront=cFront.Free();
   return ret;
}

END_SPACE

void Test(){
   class CTest{};
   struct STest{
      int a;
      STest(){}
      STest(int _a):a(_a){}
      STest(const STest &other){this=other;}};
   _tForwardList<int> x;
   _tForwardList<CTest*> y;
   _tForwardList<STest> z;
   x.Push(_rv(10)); y.Push(_rv(new CTest));z.Push(STest(88));
   x.Front(); y.Front();
   Print(x.Pop()); Print(z.Pop().a);delete y.Pop();
}

#endif