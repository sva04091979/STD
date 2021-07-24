#ifndef _STD_ITERATOR_
#define _STD_ITERATOR_

#include "Iterator\Iterator.mqh"
#include "Iterator\ForwardIterator.mqh"

#ifdef _UNIT_TEST_


bool IteratorLibraryUnitTest(){
   if (!IteratorUnitTest()) return false;
   if (!ForwardIteratorUnitTest()) return false;
   return true;
}
//----------------------------------------------------
bool IteratorUnitTest(){
   _tIteratorProxy<int> a(_rv(19));
   _tIteratorProxy<int> b(_rv(22));
   _tIterator<int> test(a);
   _tIterator<int> x(a);
   _tIterator<int> y(b);
   _tIteratorProxy<double> xxx(_rv(0.32));
   const _tIterator<double> constTest(xxx);
   if (x==y) return false;
   y=x;
   if (test!=y) return false;
   if (_i(test)!=19) return false;
   _i(test)=99;
   if (_i(test)!=99) return false;
   if (_i(constTest)!=0.32) return false; 
   return true;
}
//----------------------------------------------------
bool ForwardIteratorUnitTest(){
   _tForwardIteratorProxy<int> a(_rv(1));
   _tForwardIteratorProxy<int> b(_rv(2),a);
   _tForwardIterator<int> test(b);
   Print(_i(test));
   Print(_i(++test));
   Print(_i(test));
   _i(test)=55;
   _tForwardIterator<int> x(b);
   Print(_i(x));
   Print(_i(++x));
   Print(_i(x));
   return true;
}

#endif

#endif