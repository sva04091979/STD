#ifndef _STD_I_CONTAINER_
#define _STD_I_CONTAINER_

#ifndef USING_STD
   namespace STD{
#endif

#include "IAllocator.mqh"

class IContainer
  {
   STD::IAllocator*  cAllocator;
   STD::CWrape<uint> cSize;
public:
                     IContainer():cAllocator(NULL),cIt(NULL),cBegine(NULL),cFirst(NULL),cLast(NULL),cEnd(NULL),cSize(0){}
                     IContainer(uint mSize,STD::IAllocator* mAllocator):cAllocator(mAllocator),cSize(mSize){}
   uint              GetSize();
   uint              GetMemSize()   {return !cAllocator?cSize.Get():cAllocator.GetSize();}
  };

#ifndef USING_STD
   }
#endif 

#endif