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
class CForwardList:public CContainer{
public:
   class _CNode:public CForwardNode<T,_CNode>{
   public:
      _CNode(T &obj,_CNode* next):CForwardNode<T,_CNode>(obj,next){}
   };
   class _CIterator{
      _CNode* cObj;
   public:
      T Dereference() const {return _(cObj);}
      ECompare Equaly(_CIterator &other) {return _(cObj)==_(other)?EQUALLY:MORE;}
      _CNode* operator ++() {return cObj=cObj.Next();}
   };
   struct iterator:public IForwardIterator<iterator,_CIterator,T>{
      static iterator Clone(_CIterator* other) {return iterator(other);}
   };
protected:
   _CNode* cFront;
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
   cFront=new _CNode(obj,cFront);}
//----------------------------------------------------------
template<typename T>
T CForwardList::Pop(){
   if (!cFront) return NULL;
   --cSize;
   T ret=_(cFront);
   cFront=cFront.Free();
   return ret;
}

END_SPACE

void Test(){
   class CTest{};
   STD::CForwardList<int> x;
   STD::CForwardList<CTest*> y;
   x.Front(); y.Front();
   x.IsEmpty(); y.IsEmpty();
   x.Push(_rv(10)); y.Push(_rv(new CTest));
   x.Pop(); y.Pop();
}

#endif