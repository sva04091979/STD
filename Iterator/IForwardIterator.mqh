#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "IIterator.mqh"

NAMESPACE(STD)

template<typename IteratorType,typename T>
class IForwardIterator:public IIterator<IteratorType,T>{
protected:
public:
   IForwardIterator(IteratorType* mIterator):IIterator<IteratorType,T>(mIterator){}
public:
   EIteratorType Type() override const {return FORWARD_ITERATOR;}
   IteratorType* operator ++() const {return ++cIterator;}
   T* operator ++(int) const {return cIterator++;}
};

END_SPACE

#endif