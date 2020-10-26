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
   _tdecl_ContainerNode(const T &mObj):cObject((T)mObj){}
public:
   T Dereference() const {return cObject;}
   virtual Type* Free()=0;
};
////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
template<typename T,typename Type>
class _tdecl_ForwardNode:public _tdecl_ContainerNode<T,Type>{
protected:
   Type* cNext;
   _tdecl_ForwardNode(const T &mObj,Type* mNext):_tdecl_ContainerNode<T,Type>(mObj),cNext(mNext){}
  ~_tdecl_ForwardNode(){}
public:
   Type* Next() const {return cNext;}
   Type* Free() override;
};
//-------------------------------------------------
template<typename T,typename Type>
Type* _tdecl_ForwardNode::Free(){
   Type* ret=cNext;
   delete &this;
   return ret;
}

END_SPACE

#endif