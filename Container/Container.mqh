#ifndef _STD_C_CONTAINER_
#define _STD_C_CONTAINER_

#include <STD\Define\StdDefine.mqh>

#define _tContainer __std(CContainer)
#define _tdeclContainer __decl(CContainer)
#define _tdeclIForwardList __decl(IForwardList)

NAMESPACE(STD)

class _tdeclContainer{
protected:
   _tSizeT cSize;
   _tdeclContainer():cSize(0){}
   _tdeclContainer(_tSizeT _size):cSize(_size){}
public:
   _tSizeT Size() const {return cSize;}
   bool IsEmpty() const {return !cSize;}
};
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
template<typename ContainerType,typename IteratorType,typename ProxyType,typename NodeType,typename NodeTypeEnd,typename Type>
class _tdeclIForwardList:public _tdeclContainer{
protected:
   ProxyType cEnd;
   NodeType* cFront;
protected:
   _tdeclIForwardList()::cEnd(this,EndNode()),cFront(EndNode()){}
   _tdeclForwardList(Type &mArr[]);
   _tdeclForwardList(ContainerType &mOther);
  ~_tdeclForwardList() {Clear();}
   static NodeTypeEnd* EndNode();
public:
   IteratorType Begin() {IteratorType ret(cFront,&this); return ret;}
   const ProxyType* End() const {return &cEnd;}
   ProxyType EraceAfter(const IteratorType &mIt) {return EraceAfter(mIt.Wrape());}
   ProxyType EraceAfter(const ProxyType &mWrape);
   ProxyType InsertAfter(const IteratorType &mIt,const T &mVal) {return Insert(mIt.Wrape(),mVal);}
   ProxyType InsertAfter(const ProxyType &mWrape,const T &mVal);
   Type Front() const {return _(cFront);}
   void PushFront(Type &obj);
   Type PopFront();
   void Swap(ContainerType &mOther);
   void Clear();
   void ClearAfter(const IteratorType &mIt) {ClearAfter(mIt.Wrape());}
   void ClearAfter(const ProxyType &mWrape);

};
//----------------------------------------------------------
template<typename ContainerType,typename IteratorType,typename ProxyType,typename NodeType,typename NodeTypeEnd,typename Type>
static NodeTypeEnd* _tdeclIForwardList::EndNode(){
   static NodeTypeEnd instance;
   return &instance;}
//---------------------------------------------------------
template<typename ContainerType,typename IteratorType,typename ProxyType,typename NodeType,typename NodeTypeEnd,typename Type>
_tdeclForwardList::_tdeclForwardList(Type &mArr[]):
   cEnd(&this,EndNode()),cFront(EndNode()){
   int count=ArraySize(mArr);
   if (!count) return;
   NodeType* first=new NodeType(mArr[0],NULL);
   NodeType* node=first;
   for (int i=1;i<count;++i){
      node.Next(new NodeType(mArr[i],NULL));
      node=node.Next();}
   node.Next(cFront);
   cFront=first;
   cSize=count;
}
//---------------------------------------------------------
template<typename ContainerType,typename IteratorType,typename ProxyType,typename NodeType,typename NodeTypeEnd,typename Type>
_tdeclForwardList::_tdeclForwardList(ContainerType &mOther):
   cEnd(&this,EndNode()),cFront(EndNode()){
   if (mOther.IsEmpty()) return;
   cSize=mOther.Size();
   IteratorType it=mOther.Begin();
   NodeType* first=ProxyType::NewNode(it.Wrape(),NULL);
   NodeType* node=first;
   ++it;
   while(!it.IsEnd()){
      node.Next(ProxyType::NewNode(it.Wrape(),NULL));
      node=node.Next();
      ++it;}
   node.Next(cFront);
   cFront=first;
}
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
//--------------------------------------------------------------
template<typename T>
_tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> _tdeclForwardList::EraceAfter(const _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> &mWrape){
   if (!mWrape.CheckContainer(this)) {ABORT("Wrong container");}
   if (mWrape.IsEnd()||mWrape.IsLast()) return mWrape;
   else{
      --cSize;
      return mWrape.EraceNext();}
}
//--------------------------------------------------------------
template<typename T>
_tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T>
_tdeclForwardList::Insert(const _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> &mWrape,const T &mVal){
   if (!mWrape.CheckContainer(this)) {ABORT("Wrong container");}
   if (mWrape.IsEnd()) ABORT("This operation is not alloed whith end iterator");
   else{
      ++cSize;
      return mWrape.Insert(mVal);}
   return mWrape;
}
//-------------------------------------------------------------------------------
template<typename T>
void _tdeclForwardList::Clear(){
   cSize=0;
   while (!cFront.IsEnd()) cFront=cFront.Free();
}
//--------------------------------------------------------------
template<typename T>
void _tdeclForwardList::ClearAfter(const _tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> &mWrape){
   if (!mWrape.CheckContainer(this)) {ABORT("Wrong container");}
   if (mWrape.IsEnd()||mWrape.IsLast()) return;
   else{
      --cSize;
      for(_tdecl_ForwardProxy<_tdeclForwardList<T>,_tdeclForwardNode<T>,T> wrape=mWrape.EraceNext();
          !wrape.IsEnd();
          wrape=mWrape.EraceNext()) --cSize;}
}

END_SPACE

#endif