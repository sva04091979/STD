#ifndef _STD_S_AUTO_PTR_
#define _STD_S_AUTO_PTR_

#include <STD\Define\StdDefine.mqh>

#define _tAutoPtr __std(SAutoPtr)

#define _tdeclAutoPtr __decl(SAutoPtr)

NAMESPACE(STD)

template<typename T>
struct _tdeclAutoPtr{
protected:
   T* cPtr;
public:
   _tdeclAutoPtr():cPtr(NULL){}
   _tdeclAutoPtr(T* obj):cPtr(obj){}
   _tdeclAutoPtr(_tdeclAutoPtr<T> &other):cPtr(_(other)){}
  ~_tdeclAutoPtr() {delete cPtr;}
   template<typename T1>
   _tdeclAutoPtr<T1> StaticCast() {return _tdeclAutoPtr<T1>(new T1(cObject));}
   template<typename T1>
   _tdeclAutoPtr<T1> DynamicCast() {return !dynamic_cast<T1*>(cObject))?_tdeclAutoPtr<T1>():_tdeclAutoPtr<T1>(new T1(cObject));}
   T* Dereference() const {return cPtr;}
   T* Get()         const {return cPtr;}
   void Free()      {DELETE(cPtr);}
   T* Move()        {T* ret=cPtr; cPtr=NULL; return ret;}
   void operator =(const _tdeclAutoPtr<T> &other);
   void operator =(T* ptr);
   bool operator !() {return !cPtr;}
};
//--------------------------------------------------------------------------
template<typename T>
void _tdeclAutoPtr::operator =(const _tdeclAutoPtr<T> &other){
   DEL(cPtr);
   cPtr=new T(_(other));
}
//--------------------------------------------------------------------------
template<typename T>
void _tdeclAutoPtr::operator =(T* ptr){
   DEL(cPtr);
   cPtr=new T(ptr);
}

template<typename T>
T* _fdeclMove(_tdeclAutoPtr<T> &ptr) {return ptr.Move();}

END_SPACE

#endif