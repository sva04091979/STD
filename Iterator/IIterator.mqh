#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Define\StdDefine.mqh>

#define _tEIteratorType __std(EIteratorType)

#define _tdecl_Iterator __decl(_SIterator)
#define _tdeclEIteratorType __decl(EIteratorType)

NAMESPACE(STD)

template<typename ContainerType,typename WrapeType,typename Node,typename T>
struct _tdecl_Iterator{
   WrapeType cWrape;
   ContainerType* cContainer;
protected:
   _tdecl_Iterator(Node* mNode,ContainerType* mContainer):
   cWrape(mNode),cContainer(mContainer){}
public:
   WrapeType* Wrape() {return &cWrape;}
public:
   T Dereference() const {return _(cWrape);}
   ContainerType* Container() const {return cContainer;}
   void operator =(_tdecl_Iterator<ContainerType,WrapeType,Node,T> &mOther);
   bool operator ==(_tdecl_Iterator<ContainerType,WrapeType,Node,T> &other) {return cWrape==other.cWrape;}
   bool operator !=(_tdecl_Iterator<ContainerType,WrapeType,Node,T> &other) {return cWrape!=other.cWrape;}
   bool operator ==(const WrapeType &mWrape) {return cWrape==mWrape;}
   bool operator !=(const WrapeType &mWrape) {return cWrape!=mWrape;}
   bool IsEnd() {return cWrape.IsEnd();}
};
//-----------------------------------------------------------------
template<typename ContainerType,typename WrapeType,typename Node,typename T>
void _tdecl_Iterator::operator =(_tdecl_Iterator<ContainerType,WrapeType,Node,T> &mOther){
   cWrape=mOther.Wrape();
}

END_SPACE

#endif