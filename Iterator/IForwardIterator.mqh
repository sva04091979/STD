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
   _tdecl_ForwardIterator(const _tdecl_ForwardIterator<Iterator,Node,T> &other):_tdecl_Iterator<Node,T>((_tdecl_Iterator<Node,T>)other){}
public:
   Iterator operator ++() const {return Iterator(++cObject);}
   Iterator operator ++(int) const {return Iterator(cObject++);}
};

END_SPACE

#endif