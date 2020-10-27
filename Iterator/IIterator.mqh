#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Memory\AutoPtr.mqh>

#define _tEIteratorType __std(EIteratorType)

#define _tdecl_Iterator __decl(_SIterator)
#define _tdeclEIteratorType __decl(EIteratorType)

NAMESPACE(STD)

enum _tdeclEIteratorType{FORWARD_ITERATOR,BI_DIRECT_ITERATOR};

template<typename Node,typename T>
struct _tdecl_Iterator:protected _tdeclAutoPtr<Node>{
   _tdeclEIteratorType cType;
protected:
   _tdecl_Iterator(Node* mIterator,EIteratorType mType):
      _tdeclAutoPtr<Node>(mIterator),cType(mType){}
public:
   T Dereference() const {return _(cPtr);}
   _tdeclEIteratorType Type() const {return cType;}
   Node* GetNode() const {return cPtr;}
   bool operator ==(_tdecl_Iterator<Node,T> &other) {return cPtr.Equal(other.cPtr);}
   bool operator !=(_tdecl_Iterator<Node,T> &other) {return !cPtr.Equal(other.cPtr);}
};

END_SPACE

#endif