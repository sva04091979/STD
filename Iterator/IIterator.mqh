#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Define\StdDefine.mqh>

#ifdef USING_STD
   #define _eIteratorType __std(EIteratorType)
#endif

NAMESPACE(STD)

enum EIteratorType{FORWARD_ITERATOR,BI_DIRECT_ITERATOR};

template<typename IteratorType,typename T>
class IIterator{
protected:
   IteratorType* cIterator;
   IIterator(IteratorType* mIterator):cIterator(mIterator){}
public:
   T Dereference()   const {return _(cIterator);}
   virtual EIteratorType Type() const=0;
   bool operator ==(IIterator<IteratorType> &other) {return cIterator.IsEqualy(other);}
   bool operator !=(IIterator<IteratorType> &other) {return !cIterator.IsEqualy(other);}
};

END_SPACE

#endif