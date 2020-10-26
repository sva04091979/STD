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
   _tdecl_Iterator(_tdecl_Iterator<Node,T> &other):
      _tdeclAutoPtr<Node>(other),cType(other.cType){}
public:
   T Dereference() const {return _(cObject);}
   _tdeclEIteratorType Type() const {return cType;}
   Node* Iterator() const {return cObject;}
   bool operator ==(_tdecl_Iterator<Node,T> &other) {return cObject.Equal(other.cObject)==_eEqual;}
   bool operator !=(_tdecl_Iterator<Node,T> &other) {return cObject.Equal(other.cObject)!=_eEqual;}
};

END_SPACE

#endif