#ifndef _STD_ITERATOR_PROXY_
#define _STD_ITERATOR_PROXY_

#include "..\..\Define\StdDefine.mqh"
#include "..\Iterator\Iterator.mqh"


#define _tIteratorProxy __std(IteratorProxy)
#define _tdeclIteratorProxy __decl(IteratorProxy)

NAMESPACE(STD)

template<typename Type>
class _tdeclIteratorProxy{
public:
   Type cIteratorValue;
   _tdeclIteratorProxy(){}
   _tdeclIteratorProxy(const Type &val):cIteratorValue(val){}
   _tdeclIteratorAccess<_tdeclIteratorProxy> __GetAccess() {_tdeclIteratorAccess<_tdeclIteratorProxy> ret(&this); return ret;}
};

END_SPACE

#endif