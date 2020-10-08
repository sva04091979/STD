#ifndef _STD_I_FORWARD_ITERATOR_
#define _STD_I_FORWARD_ITERATOR_

#include "IIterator.mqh"

NAMESPACE(STD)

template<typename IteratorType, typename Iterator,typename T>
struct IForwardIterator:public IIterator<Iterator,T>{
protected:
   IForwardIterator(Iterator* mIterator):IIterator<Iterator,T>(mIterator,FORWARD_ITERATOR){}
   IForwardIterator(Iterator* mIterator,EIteratorType mType):IIterator<Iterator,T>(mIterator,mType){}
   IForwardIterator(const IForwardIterator<IteratorType,Iterator,T> &other):IIterator<Iterator,T>((IIterator<Iterator,T>)other){}
public:
   IteratorType operator ++() const {++cObject; return this;}
   IteratorType operator ++(int) const {IteratorType ret=IteratorType::Clone(cObject++); return ret;}
};

END_SPACE

#endif