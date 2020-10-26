#ifndef _STD_FORWARD_LIST_
#define _STD_FORWARD_LIST_

#include "Container.mqh"
#include "ContainerNode.mqh"
#include <STD\Iterator\IForwardIterator.mqh>

#ifdef USING_STD
   #define _tForwardList __std(CForwardList)
   #define _tForwardIterator __std(CForwardList::iterator)
#endif

NAMESPACE(STD)

template<typename T>
class CForwardNode:public _CForwardNode<T,CForwardNode>{
public:
   CForwardNode(const T &mObj,CForwardNode<T>* mNext):_CForwardNode<T,CForwardNode>(mObj,mNext){}
};

template<typename T>
struct SForwardIterator:public <SForwardIterator<T>,CForwardNode<T>,T>{

};

template<typename T>
class CForwardList:public CContainer{
protected:
   CForwardNode<T>* cFront;
public:
  ~CForwardList() {DEL(cFront);}
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
   STD::CForwardList<int> x;
   STD::CForwardList<CTest*> y;
   STD::CForwardList<STest> z;
   x.Push(_rv(10)); y.Push(_rv(new CTest));z.Push(STest(88));
   x.Front(); y.Front();
   Print(x.Pop()); Print(z.Pop().a);delete y.Pop();
}

#endif