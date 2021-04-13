#ifndef _STD_ITERATOR_
#define _STD_ITERATOR_

#include "Proxy\IteratorProxy.mqh"

#ifdef _UNIT_TEST_

NAMESPACE(STD)

class ILUT_Test:public _tdeclIteratorProxy<int>{
public:
   ILUT_Test():_tdeclIteratorProxy<int>(){}
   ILUT_Test(const int &val):_tdeclIteratorProxy<int>(val){}
};

END_SPACE

bool IteratorLibraryUnitTest(){
   
}

#endif

#endif