#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Memory\UniquePtr.mqh>

#define _tEIteratorType __std(EIteratorType)

#define _tdecl_Iterator __decl(_SIterator)
#define _tdeclEIteratorType __decl(EIteratorType)

NAMESPACE(STD)

enum _tdeclEIteratorType{FORWARD_ITERATOR,BI_DIRECT_ITERATOR};

template<typename Wrape,typename Node,typename T>
struct _tdecl_Iterator:protected _tdeclUniquePtr<Wrape>{
   _tdeclEIteratorType cType;
protected:
   _tdecl_Iterator(Wrape* &mWrape,EIteratorType mType):
      _tdeclUniquePtr<Wrape>(mWrape),cType(mType){}
public:
   T Dereference() const {return _(cPtr);}
   _tdeclEIteratorType Type() const {return cType;}
   Node* GetNode() {return cPtr.GetNode();}
   void operator =(_tdecl_Iterator<Wrape,Node,T> &mOther);
   bool operator ==(_tdecl_Iterator<Wrape,Node,T> &other) {return cPtr.GetNode().Equal(other.cPtr.GetNode());}
   bool operator !=(_tdecl_Iterator<Wrape,Node,T> &other) {return !cPtr.GetNode().Equal(other.cPtr.GetNode());}
};
//-----------------------------------------------------------------
template<typename Wrape,typename Node,typename T>
void _tdecl_Iterator::operator =(_tdecl_Iterator<Wrape,Node,T> &mOther){
   DEL(cPtr);
   cPtr=new Wrape(cPtr.GetNode());
}

END_SPACE

#endif