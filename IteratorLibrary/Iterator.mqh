#ifndef _STD_ITERATOR_
#define _STD_ITERATOR_

#include "Iterator\Iterator.mqh"

#ifdef _UNIT_TEST_

class ILUT_Test:public _tIteratorProxy<int>{
public:
   ILUT_Test(int val):_tIteratorProxy<int>(val){}
};

bool IteratorLibraryUnitTest(){
   ILUT_Test a(19);
   _tIterator<int> test(a);
   Print(_i(test));
   _i(test)=99;
   Print(_i(test));
   return true;
}

#endif

#endif