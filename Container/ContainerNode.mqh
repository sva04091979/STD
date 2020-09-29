#ifndef _STD_CONTAINER_NODE_
#define _STD_CONTAINER_NODE_

#include <STD\Define\StdDefine.mqh>

NAMESPACE(STD)

template<typename T,typename Type>
class CForwardNode{
protected:
   T cObj;
   Type* cNext;
   CForwardNode(T &obj,Type* next):cObj(obj),cNext(next){}
  ~CForwardNode() {if (cNext!=NULL) DEL(cNext);}
public:
   T Dereference() const {return cObj;}
   Type* Next() const {return cNext;}
   Type* Free();
};
//-------------------------------------------------
template<typename T,typename Type>
Type* CForwardNode::Free(){
   void* ret=cNext;
   cNext=NULL;
   delete &this;
   return ret;
}

END_SPACE

#endif