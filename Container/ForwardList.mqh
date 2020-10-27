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
#define _tdeclForwardNodeEnd __decl(CForwardNodeEnd)

NAMESPACE(STD)

template<typename T>
class _tdeclForwardNode:public _tdecl_ForwardNode<T,_tdeclForwardNode<T>>{
public:
   _tdeclForwardNode():_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(){}
   _tdeclForwardNode(const T &mObj,_tdeclForwardNode<T>* mNext):_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(mObj,mNext){}
   _tdeclForwardNode(const _tdeclForwardNode<T> &mOther):_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(mOther){}
};

template<typename T>
class _tdeclForwardNodeEnd:public _tdeclForwardNode<T>{
public:
   _tdeclForwardNodeEnd():_tdeclForwardNode<T>(){}
   bool IsEnd() override {return true;}
   bool Equal(_tdeclForwardNode<T> &mOther) override {return mOther.IsEnd();}
};

template<typename T>
struct _tdeclForwardIterator:public _tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>{
   _tdeclForwardIterator(_tdeclForwardNode<T>* mNode):_tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>(mNode){}
   _tdeclForwardIterator(const _tdeclForwardIterator<T> &mOther):
      _tdecl_ForwardIterator<_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>(mOther){}
};

template<typename T>
class _tdeclForwardList:public _tdeclContainer{
protected:
   _tdeclForwardNode<T>* cFront;
public:
  ~CForwardList() {if (!cSize) DEL(cFront);}
   _tdeclForwardIterator<T> Begin() {return _tdeclForwardIterator<T>(cFront);}
   _tdeclForwardIterator<T> End();
   T Front() const {return _(cFront);}
   void Push(T &obj);
   T Pop();
};
//---------------------------------------------------------
template<typename T>
_tdeclForwardIterator<T> _tdeclForwardList::End(){
   static _tdeclForwardIterator<T> instance(new _tdeclForwardNodeEnd<T>);
   return instance;
}
//---------------------------------------------------------
template<typename T>
void CForwardList::Push(T &obj){
   ++cSize;
   cFront=new CForwardNode<T>(obj,cFront);}
//----------------------------------------------------------
template<typename T>
T CForwardList::Pop(){
   if (cFront.IsEnd()) return _(cFront.Next());
   else{
      --cSize;
      T ret=_(cFront);
      cFront=cFront.Free();
      return ret;}
}

END_SPACE

void Test(){
   class CTest{};
   struct STest{
      int a;
      STest(){}
      STest(int _a):a(_a){}
      STest(const STest &other){this=other;}
      bool operator ==(STest &other){return a==other.a;}};
   _tForwardList<int> x;
   _tForwardList<CTest*> y;
   _tForwardList<STest> z;
   x.Push(_rv(10)); y.Push(_rv(new CTest));z.Push(STest(88));
   x.Front(); y.Front();
   Print(x.Pop()); Print(z.Pop().a);delete y.Pop();
}

#endif