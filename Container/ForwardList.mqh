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
protected:
  ~_tdeclForwardNode(){}
public:
   _tdeclForwardNode():_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(){}
   _tdeclForwardNode(const T &mObj,_tdeclForwardNode<T>* mNext):_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(mObj,mNext){}
   _tdeclForwardNode(const _tdeclForwardNode<T> &mOther):_tdecl_ForwardNode<T,_tdeclForwardNode<T>>(mOther){}
};

template<typename T>
class _tdeclForwardNodeEnd:public _tdeclForwardNode<T>{
public:
   _tdeclForwardNodeEnd():_tdeclForwardNode<T>(){}
   bool IsEnd() override const {return true;}
   bool Equal(const _tdeclForwardNode<T> &mOther) override {return mOther.IsEnd();}
};

template<typename T>
struct _tdeclForwardIterator:public _tdecl_ForwardIterator<_tdeclForwardList<T>,_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>{
   _tdeclForwardIterator(_tdeclForwardNode<T>* mNode,_tdeclForwardList<T>* mContainer):
      _tdecl_ForwardIterator<_tdeclForwardList<T>,_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>(mNode,mContainer){}
   _tdeclForwardIterator(const _tdeclForwardIterator<T> &mOther):
      _tdecl_ForwardIterator<_tdeclForwardList<T>,_tdeclForwardIterator<T>,_tdeclForwardNode<T>,T>(mOther){}
};

template<typename T>
class _tdeclForwardList:public _tdeclContainer{
protected:
   _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> cEnd;
   _tdeclForwardNode<T>* cFront;
public:
   _tdeclForwardList():cEnd(&this,EndNode()),cFront(EndNode()){}
  ~_tdeclForwardList() {while (!cFront.IsEnd()!=NULL) cFront=cFront.Free();}
   _tdeclForwardIterator<T> Begin() {_tdeclForwardIterator<T> ret(cFront,&this); return ret;}
   const _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T>* End() const {return &cEnd;}
   _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> EraceNext(_tdeclForwardIterator<T> &mIt);
   T Front() const {return _(cFront);}
   void PushFront(T &obj);
   T PopFront();
   void Swap(_tdeclForwardList<T> &mOther);
protected:
   static _tdeclForwardNodeEnd<T>* EndNode(){
      static _tdeclForwardNodeEnd<T> instance;
      return &instance;
   }
};
//---------------------------------------------------------
template<typename T>
void _tdeclForwardList::PushFront(T &obj){
   ++cSize;
   cFront=new _tdeclForwardNode<T>(obj,cFront);}
//----------------------------------------------------------
template<typename T>
T _tdeclForwardList::PopFront(){
   if (cFront.IsEnd()) return _(cFront.Next());
   else{
      --cSize;
      T ret=_(cFront);
      cFront=cFront.Free();
      return ret;}
}
//----------------------------------------------------------
template<typename T>
void _tdeclForwardList::Swap(_tdeclForwardList<T> &mOther){
   _tSizeT size=cSize;
   _tdeclForwardNode<T>* front=cFront;
   cSize=mOther.cSize;
   cFront=mOther.cFront;
   mOther.cSize=size;
   mOther.cFront=front;
}
//------------------------------------------------------------
template<typename T>
_tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> _tdeclForwardList::EraceNext(_tdeclForwardIterator<T> &mIt){
   if (!mIt.CheckContainer(this)) {int _tmp=0,tmp=1/_tmp;}
   if (mIt.IsEnd()) return mIt.Wrape();
   else{
      --cSize;
      return mIt.Wrape().EraceNext();}
}

template<typename T>
void _fdeclSwap(_tdeclForwardList<T> &fFirst,_tdeclForwardList<T> &fSecond){
   fFirst.Swap(fSecond);
}

END_SPACE

#endif