#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "IIterator.mqh"

#define _tdecl_ForwardIterator __decl(_SForwardIterator)

NAMESPACE(STD)

template<typename Iterator, typename Node,typename T>
struct _tdecl_ForwardIterator:public _tdecl_Iterator<Node,T>{
protected:
   _tdecl_ForwardIterator(Node* mNode):_tdecl_Iterator<Node,T>(mNode,FORWARD_ITERATOR){}
   _tdecl_ForwardIterator(Node* mNode,_tdeclEIteratorType mType):_tdecl_Iterator<Node,T>(mNode,mType){}
   _tdecl_ForwardIterator(const Iterator &other):_tdecl_Iterator<Node,T>(other.GetNode(),FORWARD_ITERATOR){}
public:
   Iterator operator ++() {return Iterator(++cPtr);}
   Iterator operator ++(int) {return Iterator(cPtr++);}
};

END_SPACE

#endif