#ifndef _STD_S_UNIQUE_PTR_
#define _STD_S_UNIQUE_PTR_

#include <STD\Define\StdDefine.mqh>

#define _tUniquePtr __std(SUniquePtr)

#define _tdeclUniquePtr __decl(SUniquePtr)

NAMESPACE(STD)

template<typename T>
struct _tdeclUniquePtr{
private:
   T* cObject;
public:
   _tdeclUniquePtr():cObject(NULL){}
   _tdeclUniquePtr(T* &obj):cObject(_fdeclMove(obj)){}
   _tdeclUniquePtr(_tdeclUniquePtr<T> &other):cObject(_fdeclMove(other)){}
  ~_tdeclUniquePtr() {delete cObject;}
   template<typename T1>
   _tdeclUniquePtr<T1> StaticCast() {_tdeclUniquePtr<T1> ret((T1*)cObject); cObject=NULL; return ret;}
   template<typename T1>
   _tdeclUniquePtr<T1> DynamicCast() {_tdeclUniquePtr<T1> ret(dynamic_cast<T1*>(cObject)); cObject=NULL; return ret;}
   T* Dereference() {return cObject;}
   T* Get()         {return cObject;}
   void Free()      {DELETE(cObject);}
   T* Move()        {T* ret=cObject; cObject=NULL; return ret;}
   void operator =(_tdeclUniquePtr<T> &other);
   void operator =(T* &ptr);
   bool operator !() {return !cObject;}
};
//--------------------------------------------------------------------------
template<typename T>
void _tdeclUniquePtr::operator =(_tdeclUniquePtr<T> &other){
   DEL(cObject);
   cObject=_fdeclMove(other);
}
//--------------------------------------------------------------------------
template<typename T>
void _tdeclUniquePtr::operator =(T* &ptr){
   DEL(cObject);
   cObject=_fdeclMove(ptr);
}

template<typename T>
T* _fdeclMove(_tdeclUniquePtr<T> &ptr) {return ptr.Move();}

template<typename T>
_tdeclUniquePtr<T> Copy(_tdeclUniquePtr<T> &fPtr){
   return _tdeclUniquePtr<T>(new T(_(fPtr)));
}

END_SPACE

#endif