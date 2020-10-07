#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Memory\SharedPtr.mqh>

#ifdef USING_STD
   #define _eIteratorType __std(EIteratorType)
#endif

NAMESPACE(STD)

enum EIteratorType{FORWARD_ITERATOR,BI_DIRECT_ITERATOR};

template<typename TIterator,typename T>
struct IIterator:protected SSharedPtr<TIterator>{
   EIteratorType cType;
protected:
   IIterator(TIterator* mIterator,EIteratorType mType):
      SSharedPtr<TIterator>(mIterator),cType(mType){}
   IIterator(IIterator<TIterator,T> &other):
      SSharedPtr<TIterator>(other),cType(other.cType){}
public:
   T Dereference() const {return _(cObject);}
   EIteratorType Type() const {return cType;}
   TIterator* Iterator() const {return cObject;}
   bool operator ==(IIterator<TIterator,T> &other) {return cObject.Equaly(other.cObject)==EQUALLY;}
   bool operator !=(IIterator<TIterator,T> &other) {return cObject.Equaly(other.cObject)!=EQUALLY;}
};

END_SPACE

#endif