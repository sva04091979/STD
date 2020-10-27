#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "IIterator.mqh"

#define _tdecl_ForwardIterator __decl(_SForwardIterator)
#define _tdecl_ForwardProxy __decl(_CForwardWrape)

#define _Typenames _tdecl_ForwardProxy<Node,T>,Node,T

NAMESPACE(STD)

template<typename Node,typename T>
class _tdecl_ForwardProxy{
   Node* cNode;
public:
   _tdecl_ForwardProxy(Node* mNode):cNode(mNode){}
   T Dereference() {return _(cNode);}
   Node* GetNode() {return cNode;}
   void operator ++() {cNode=cNode.Next();}
   bool IsEnd() {return cNode.IsEnd();}
};

template<typename Iterator, typename Node,typename T>
struct _tdecl_ForwardIterator:public _tdecl_Iterator<_Typenames>{
protected:
   _tdecl_ForwardIterator(Node* mNode):_tdecl_Iterator<_Typenames>(new _tdecl_ForwardProxy<Node,T>(mNode),FORWARD_ITERATOR){}
   _tdecl_ForwardIterator(Node* mNode,_tdeclEIteratorType mType):_tdecl_Iterator<_Typenames>(new _tdecl_ForwardProxy<Node,T>(mNode),mType){}
   _tdecl_ForwardIterator(const Iterator &other):_tdecl_Iterator<_Typenames>(new _tdecl_ForwardProxy<Node,T>(other.GetNode()),other.Type()){}
public:
   Iterator operator ++() {++cPtr; return Iterator(cPtr.GetNode());}
   Iterator operator ++(int) {Iterator ret(cPtr.GetNode()); ++cPtr; return ret;}
};

END_SPACE

#undef _Typenames

#endif