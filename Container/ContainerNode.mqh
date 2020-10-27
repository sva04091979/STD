#ifndef _STD_CONTAINER_NODE_
#define _STD_CONTAINER_NODE_

#include <STD\Define\StdDefine.mqh>

#define _tdecl_ContainerNode __decl(CContainerNode)
#define _tdecl_ForwardNode __decl(_CForwardNode)

NAMESPACE(STD)

template<typename T,typename Type>
class _tdecl_ContainerNode{
protected:
   T cObject;
   _tdecl_ContainerNode(){}
   _tdecl_ContainerNode(const T &mObj):cObject((T)mObj){}
   _tdecl_ContainerNode(const Type &mOther):cObject(_(mOther)){}
public:
   T Dereference() const {return cObject;}
   virtual bool Equal(Type &mOther){return !mOther.IsEnd()&&cObject==_(mOther);}
   virtual Type* Free()=0;
   virtual bool IsEnd() {return false;}
};
////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
template<typename T,typename Type>
class _tdecl_ForwardNode:public _tdecl_ContainerNode<T,Type>{
protected:
   Type* cNext;
   _tdecl_ForwardNode():_tdecl_ContainerNode<T,Type>(){}
   _tdecl_ForwardNode(const T &mObj,Type* mNext):_tdecl_ContainerNode<T,Type>(mObj),cNext(mNext){}
   _tdecl_ForwardNode(const Type &mOther):_tdecl_ContainerNode<T,Type>(mOther),cNext(mOther.Next()){}
  ~_tdecl_ForwardNode(){}
public:
   Type* Next() const {return cNext;}
   Type* Free() override;
   Type* operator ++();
   Type* operator ++(int);
};
//-------------------------------------------------
template<typename T,typename Type>
Type* _tdecl_ForwardNode::Free(){
   Type* ret=cNext;
   delete &this;
   return ret;
}
//-------------------------------------------------
template<typename T,typename Type>
Type* _tdecl_ForwardNode::operator ++(){
   cObject=_(cNext);
   cNext=cNext.Next();
   return new Type((Type*)&this);
}
//-------------------------------------------------
template<typename T,typename Type>
Type* _tdecl_ForwardNode::operator ++(int){
   Type* ret=new Type((Type*)&this);
   cObject=_(cNext);
   cNext=cNext.Next();
   return ret;
}

END_SPACE

#endif