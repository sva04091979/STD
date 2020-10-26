#ifndef _STD_S_AUTO_PTR_
#define _STD_S_AUTO_PTR_

#include <STD\Define\StdDefine.mqh>

#define _tAutoPtr __std(SAutoPtr)

#define _tdeclAutoPtr __decl(SAutoPtr)

NAMESPACE(STD)

template<typename T>
struct _tdeclAutoPtr{
private:
   T* cObject;
public:
   _tdeclAutoPtr():cObject(NULL){}
   _tdeclAutoPtr(T* obj):cObject(obj){}
   _tdeclAutoPtr(_tdeclAutoPtr<T> &other):cObject(_(other)){}
  ~_tdeclAutoPtr() {delete cObject;}
   template<typename T1>
   _tdeclAutoPtr<T1> StaticCast() {return _tdeclAutoPtr<T1>(new T1(cObject));}
   template<typename T1>
   _tdeclAutoPtr<T1> DynamicCast() {return !dynamic_cast<T1*>(cObject))?_tdeclAutoPtr<T1>():_tdeclAutoPtr<T1>(new T1(cObject));}
   T* Dereference() const {return cObject;}
   T* Get()         const {return cObject;}
   void Free()      {DELETE(cObject);}
   T* Move()        {T* ret=cObject; cObject=NULL; return ret;}
   void operator =(const _tdeclAutoPtr<T> &other);
   void operator =(T* ptr);
   bool operator !() {return !cObject;}
};
//--------------------------------------------------------------------------
template<typename T>
void _tdeclAutoPtr::operator =(const _tdeclAutoPtr<T> &other){
   DEL(cObject);
   cObject=new T(_(other));
}
//--------------------------------------------------------------------------
template<typename T>
void _tdeclAutoPtr::operator =(T* ptr){
   DEL(cObject);
   cObject=_fdeclMove(ptr);
}

template<typename T>
T* _fdeclMove(_tdeclAutoPtr<T> &ptr) {return ptr.Move();}

END_SPACE

#endif