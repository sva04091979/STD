#ifndef _STD_CONTAINER_NODE_
#define _STD_CONTAINER_NODE_

#include <STD\Define\StdDefine.mqh>

NAMESPACE(STD)

template<typename T,typename Type>
class CContainerNode{
protected:
   T cObject;
   CContainerNode(const T &mObj):cObject((T)mObj){}
public:
   T Dereference() const {return cObject;}
   virtual Type* Free()=0;
};

template<typename T,typename Type>
class _CForwardNode:public CContainerNode<T,Type>{
protected:
   Type* cNext;
   _CForwardNode(const T &mObj,Type* mNext):CContainerNode<T,Type>(mObj),cNext(mNext){}
  ~_CForwardNode(){}
public:
   Type* Next() const {return cNext;}
   Type* Free() override;
};
//-------------------------------------------------
template<typename T,typename Type>
Type* _CForwardNode::Free(){
   Type* ret=cNext;
   delete &this;
   return ret;
}

END_SPACE

#endif