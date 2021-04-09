#ifndef _STD_I_ITERATOR_
#define _STD_I_ITERATOR_

#include <STD\Define\StdDefine.mqh>

#define _tIterator __std(IIterator)
#define _tIteratorAccess __std(SIteratorAccess)
#define _tdeclIterator __decl(IIterator)
#define _tdeclIteratorAccess __decl(SIteratorAccess)

#define _i(dIt) dIt.__GetAccess().cIteratorProxy.cIteratorValue

NAMESPACE(STD)

template<typename ProxyType>
struct _tdeclIteratorAccess{
   ProxyType* cIteratorProxy;
   _tdeclIteratorAccess(ProxyType* proxy):cIteratorProxy(proxy){}
   _tdeclIteratorAccess(_tdeclIteratorAccess<ProxyType> &other){this=other;}
};

template<typename ProxyType,typename Type>
struct _tdeclIterator{
   ProxyType* cProxy;
public:
   _tdeclIterator(ProxyType &mProxy):cProxy(&mProxy){}
   _tdeclIteratorAccess<ProxyType> __GetAccess() const {return cProxy.GetAccess();}
   Type Dereference() const {return _(cProxy);}
   void operator =(const _tdeclIterator &mOther) {cProxy=mOther.Proxy();}
   void operator =(ProxyType &mProxy) {cProxy=&mProxy;}
   bool operator ==(const _tdeclIterator &other) const {return cProxy==other.Proxy();}
   bool operator !=(const _tdeclIterator &other) const {return cProxy!=other.Proxy();}
   bool operator ==(const ProxyType &mProxy) const {return cProxy==&mProxy;}
   bool operator !=(const ProxyType &mProxy) {return cProxy!=&mProxy;}
protected:
   ProxyType* Proxy() const {return cProxy;}
};

END_SPACE

#endif