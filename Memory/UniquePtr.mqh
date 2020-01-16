#ifndef _STD_S_UNIQUE_PTR_
#define _STD_S_UNIQUE_PTR_

#include <STD\Define\StdDefine.mqh>

#ifdef USING_STD
   #define _tUniquePtr __std(SUniquePtr)
#endif

NAMESPACE(STD)

template<typename T>
struct SUniquePtr{
private:
   T* cObject;
public:
   SUniquePtr():cObject(NULL){}
   SUniquePtr(T* obj):cObject(obj){}
   SUniquePtr(SUniquePtr<T> &other):cObject(Move(other)){}
  ~SUniquePtr() {delete cObject;}
   template<typename T1>
   SUniquePtr<T1> StaticCast() {SUniquePtr<T1> ret((T1*)cObject); cObject=NULL; return ret;}
   template<typename T1>
   SUniquePtr<T1> DynamicCast() {SUniquePtr<T1> ret(dynamic_cast<T1*>(cObject)); cObject=NULL; return ret;}
   T* Dereference() {return cObject;}
   T* Get()         {return cObject;}
   void Free()      {DELETE(cObject);}
   T* Move()        {T* ret=cObject; cObject=NULL; return ret;}
   void operator =(SUniquePtr<T> &other);
   void operator =(T* ptr);
   bool operator !() {return !cObject;}
};
//--------------------------------------------------------------------------
template<typename T>
void SUniquePtr::operator =(SUniquePtr<T> &other){
   DEL(cObject);
   cObject=Move(other);
}
//--------------------------------------------------------------------------
template<typename T>
void SUniquePtr::operator =(T* ptr){
   DEL(cObject);
   cObject=Move(ptr);
}

template<typename T>
T* Move(SUniquePtr<T> &ptr) {return ptr.Move();}

END_SPACE

#endif