#ifndef _STD_C_CONTAINER_
#define _STD_C_CONTAINER_

#include <STD\Define\StdDefine.mqh>

NAMESPACE(STD)

class CContainer{
protected:
   _tSizeT cSize;
   CContainer():cSize(0){}
   CContainer(_tSizeT _size):cSize(_size){}
public:
   _tSizeT Size() const {return cSize;}
   bool IsEmpty() const {return !cSize;}
};

END_SPACE

#endif