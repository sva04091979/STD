#ifndef _STD_I_FORWARD_NODE_
#define _STD_I_FORWARD_NODE_

#include "ContainerNode.mqh"

#define _tdeclIForwardNode __decl(IForwardNode)

NAMESPACE(STD)

template<typename NodeType,typename Type>
class _tdeclIForwardNode:public _tdeclIContainerNode<NodeType,Type>{
protected:
   NodeType* cNext;
   _tdeclIForwardNode():_tdeclIContainerNode<NodeType,Type>(){}
   _tdeclIForwardNode(const Type &mObj,NodeType* mNext):_tdeclIContainerNode<NodeType,Type>(mObj),cNext(mNext){}
   _tdeclIForwardNode(const NodeType &mOther):_tdeclIContainerNode<NodeType,Type>(mOther),cNext(mOther.Next()){}
public:
   static NodeType* NewNode(_tdeclIForwardNode<NodeType,Type> &mNode,NodeType* mNext) {return new NodeType(mNode.cObject,mNext);}
   NodeType* Free() override;
   NodeType* Next() const {return cNext;}
   NodeType* EraceAfter();
   NodeType* InsertAfter(const Type &mVal);
   void Next(NodeType* mNext) {cNext=mNext;}
   bool IsLast() {return cNext!=NULL&&cNext.IsEnd();}
};
//-------------------------------------------------
template<typename NodeType,typename Type>
NodeType* _tdeclIForwardNode::Free(){
   NodeType* ret=cNext;
   delete &this;
   return ret;
}
//-------------------------------------------------
template<typename NodeType,typename Type>
NodeType* _tdeclIForwardNode::EraceAfter(){
   cNext=cNext.Free();
   return cNext;
}
//-------------------------------------------------
template<typename NodeType,typename Type>
NodeType* _tdeclIForwardNode::InsertAfter(const Type &mVal){
   cNext=new NodeType(mVal,cNext);
   return cNext;
}


END_SPACE

#endif