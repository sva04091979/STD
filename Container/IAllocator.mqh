#ifndef _STD_I_ALLOCATOR_
#define _STD_I_ALLOCATOR_

#ifndef USING_STD
   namespace STD{
#endif

#include "CIterator.mqh"

class IAllocator
  {
public:
                     IAllocator(void);
                    ~IAllocator(void);
  };

#ifndef USING_STD
   }
#endif 

#endif