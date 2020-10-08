#ifndef _STD_CONTAINER_NODE_
#define _STD_CONTAINER_NODE_

#include <STD\Define\StdDefine.mqh>

NAMESPACE(STD)

template<typename T,typename Type>
class CContainerNode{
protected:
   T cObject;
   CContainerNode(T &mObj):cObject(mObj){}
public:
   T Dereference() const {return cObject;}
   virtual Type* Free()=0;
};

template<typename T,typename Type>
class CForwardNode:public CContainerNode<T,Type>{
protected:
   Type* cNext;
   CForwardNode(T &mObj,Type* mNext):CContainerNode<T,Type>(mObj),cNext(mNext){}
  ~CForwardNode() {if (cNext!=NULL) DEL(cNext);}
public:
   Type* Next() const {return cNext;}
   Type* Free() override;
};
//-------------------------------------------------
template<typename T,typename Type>
Type* CForwardNode::Free(){
   Type* ret=cNext;
   cNext=NULL;
   delete &this;
   return ret;
}

END_SPACE

#endif