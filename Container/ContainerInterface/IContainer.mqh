#ifndef _STD_I_CONTAINER_
#define _STD_I_CONTAINER_

#include <STD\Define\StdDefine.mqh>

#define _tContainer __std(CContainer)

NAMESPACE(STD)

class _tContainer{
public:
   virtual bool IsEmpty() const =0;
   virtual void Clear()=0;
};

END_SPACE

#endif