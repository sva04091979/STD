#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Memory\UniquePtr.mqh>

#define _tEIteratorType __std(EIteratorType)

#define _tdecl_Iterator __decl(_SIterator)
#define _tdeclEIteratorType __decl(EIteratorType)

NAMESPACE(STD)

template<typename ContainerType,typename Wrape,typename Node,typename T>
struct _tdecl_Iterator:protected _tdeclUniquePtr<Wrape>{
   ContainerType* cContainer;
protected:
   _tdecl_Iterator(Wrape* &mWrape,ContainerType* mContainer):
      _tdeclUniquePtr<Wrape>(mWrape),cContainer(mContainer){}
public:
   T Dereference() const {return _(cPtr);}
   Node* GetNode() const {return cPtr.GetNode();}
   ContainerType* Container() const {return cContainer;}
   void operator =(_tdecl_Iterator<ContainerType,Wrape,Node,T> &mOther);
   bool operator ==(_tdecl_Iterator<ContainerType,Wrape,Node,T> &other) {return cPtr.GetNode().Equal(other.cPtr.GetNode());}
   bool operator !=(_tdecl_Iterator<ContainerType,Wrape,Node,T> &other) {return !cPtr.GetNode().Equal(other.cPtr.GetNode());}
};
//-----------------------------------------------------------------
template<typename ContainerType,typename Wrape,typename Node,typename T>
void _tdecl_Iterator::operator =(_tdecl_Iterator<ContainerType,Wrape,Node,T> &mOther){
   DEL(cPtr);
   cPtr=new Wrape(mOther.GetNode());
}

END_SPACE

#endif