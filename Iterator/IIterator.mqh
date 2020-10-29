#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Define\StdDefine.mqh>

#define _tEIteratorType __std(EIteratorType)

#define _tdecl_Iterator __decl(_SIterator)
#define _tdeclEIteratorType __decl(EIteratorType)

NAMESPACE(STD)

template<typename ContainerType,typename Wrape,typename Node,typename T>
struct _tdecl_Iterator{
   Wrape cWrape;
   ContainerType* cContainer;
protected:
   _tdecl_Iterator(Node* mNode,ContainerType* mContainer):
   cWrape(mNode),cContainer(mContainer){}
protected:
   Node* GetNode() const {return cWrape.GetNode();}
public:
   T Dereference() const {return _(cWrape);}
   ContainerType* Container() const {return cContainer;}
   void operator =(_tdecl_Iterator<ContainerType,Wrape,Node,T> &mOther);
   bool operator ==(_tdecl_Iterator<ContainerType,Wrape,Node,T> &other) {return cWrape.GetNode().Equal(other.cWrape.GetNode());}
   bool operator !=(_tdecl_Iterator<ContainerType,Wrape,Node,T> &other) {return !cWrape.GetNode().Equal(other.cWrape.GetNode());}
   bool operator ==(const Node* mNode) {return cWrape.GetNode().Equal(mNode);}
   bool operator !=(const Node* mNode) {return !cWrape.GetNode().Equal(mNode);}
   bool IsEnd() {return cWrape.GetNode().IsEnd();}
};
//-----------------------------------------------------------------
template<typename ContainerType,typename Wrape,typename Node,typename T>
void _tdecl_Iterator::operator =(_tdecl_Iterator<ContainerType,Wrape,Node,T> &mOther){
   cWrape=mOther.GetNode();
}

END_SPACE

#endif