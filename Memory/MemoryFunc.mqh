#ifndef _STD_MEMORY_FUNCTIONS_
#define _STD_MEMORY_FUNCTIONS_

#ifndef USING_STD
   namespace STD{
#endif

template<typename T>
T* Move(T* &mPtr){
   T* ptr=mPtr;
   mPtr=NULL;
   return ptr;}

#ifndef USING_STD
   }
#endif 

#endif