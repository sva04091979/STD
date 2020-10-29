#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "IIterator.mqh"

#define _tForwardNode __std(_CForwardWrape)

#define _tdecl_ForwardIterator __decl(_SForwardIterator)
#define _tdecl_ForwardProxy __decl(_CForwardWrape)

#define _Typenames ContainerType,_tdecl_ForwardProxy<Node,T>,Node,T

NAMESPACE(STD)

template<typename Node,typename T>
class _tdecl_ForwardProxy{
   Node* cNode;
public:
   _tdecl_ForwardProxy(Node* mNode):cNode(mNode){}
   T Dereference() const {return _(cNode);}
   Node* GetNode() const {return cNode;}
   void operator ++() {cNode=cNode.Next();}
   bool IsEnd() {return cNode.IsEnd();}
   void operator =(Node* mNode) {cNode=mNode;}
};

template<typename ContainerType,typename Iterator, typename Node,typename T>
struct _tdecl_ForwardIterator:public _tdecl_Iterator<_Typenames>{
protected:
   _tdecl_ForwardIterator(Node* mNode,ContainerType* mContainer):_tdecl_Iterator<_Typenames>(mNode,mContainer){}
   _tdecl_ForwardIterator(const Iterator &other):_tdecl_Iterator<_Typenames>(other.GetNode(),other.Container()){}
public:
   T Next() {return _(cWrape.GetNode().Next());}
   _tdecl_ForwardProxy<Node,T>* operator ++() {++cWrape; return &cWrape;}
   Iterator operator ++(int) {Iterator ret(cWrape.GetNode(),cContainer); ++cWrape; return ret;}
};

END_SPACE

#undef _Typenames

#endif