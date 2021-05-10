#ifndef _STD_ITERATOR_
#define _STD_ITERATOR_

#include "Iterator\Iterator.mqh"

#ifdef _UNIT_TEST_


bool IteratorLibraryUnitTest(){
   if (!IteratorUnitTest()) return false;
   return true;
}

bool IteratorUnitTest(){
   _tIteratorProxy<int> a(_rv(19));
   _tIteratorProxy<int> b(_rv(22));
   _tIterator<int> test(a);
   _tIterator<int> x(a);
   _tIterator<int> y(b);
   if (x==y) return false;
   y=x;
   if (test!=y) return false;
   if (_i(test)!=19) return false;
   _i(test)=99;
   if (_i(test)!=99) return false;
   return true;
}

#endif

#endif