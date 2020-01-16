#ifndef _STD_S_SHARED_PTR_
#define _STD_S_SHARED_PTR_

#include <STD\Define\StdDefine.mqh>
#include "Wrape.mqh"

#ifdef USING_STD
   #define _tSharedPtr __std(SSharedPtr)
#endif

NAMESPACE(STD)

template<typename T>
struct SSharedPtr{
private:
   T* cObject;
   CWrapeNumeric<_tSizeT>* cCount;
public:
<<<<<<< HEAD
<<<<<<< HEAD
   SSharedPtr():cObject(NULL),cCount(NULL){}
   SSharedPtr(T* obj):cObject(obj),cCount(!obj?NULL:new CWrapeNumeric<_tSizeT>(1)){}
   SSharedPtr(T* obj,CWrapeNumeric<_tSizeT>* _count):cObject(obj),cCount(!obj?NULL:_count){if (cCount!=NULL) ++cCount;}
   SSharedPtr(SSharedPtr<T> &other);
  ~SSharedPtr() {if (cCount!=NULL&&!--cCount) {delete cObject; delete cCount;}}
   template<typename T1>
   SSharedPtr<T1> StaticCast() {SSharedPtr<T1> ret((T1*)cObject,cCount); return ret;}
   template<typename T1>
   SSharedPtr<T1> DynamicCast() {SSharedPtr<T1> ret(dynamic_cast<T1*>(cObject),cCount); return ret;}
=======
   SSharedPtr():cObject(NULL),count(NULL){}
   SSharedPtr(T* obj):cObject(obj),count(!obj?NULL:new CWrapeNumeric<_tSizeT>(1)){}
   SSharedPtr(T* obj,CWrapeNumeric<_tSizeT>* _count):cObject(obj),count(!obj?NULL:_count){if (count!=NULL) ++count;}
=======
   SSharedPtr():cObject(NULL),cCount(NULL){}
   SSharedPtr(T* obj):cObject(obj),cCount(!obj?NULL:new CWrapeNumeric<_tSizeT>(1)){}
   SSharedPtr(T* obj,CWrapeNumeric<_tSizeT>* _count):cObject(obj),cCount(!obj?NULL:_count){if (cCount!=NULL) ++cCount;}
>>>>>>> 34f88e2... Update SharedPtr.mqh
   SSharedPtr(SSharedPtr<T> &other);
  ~SSharedPtr() {if (cCount!=NULL&&!--cCount) {delete cObject; delete cCount;}}
   template<typename T1>
<<<<<<< HEAD
<<<<<<< HEAD
   SSharedPtr<T1> CastTo() {SSharedPtr<T1> ret((T1*)cObject,count); return ret;}
>>>>>>> 1d3c4a8... Update SharedPtr.mqh
=======
   SSharedPtr<T1> StaticCast() {SSharedPtr<T1> ret((T1*)cObject,count); return ret;}
   template<typename T1>
   SSharedPtr<T1> DynamicCast() {SSharedPtr<T1> ret(dynamic_cast<T1*>(cObject),count); return ret;}
>>>>>>> 19e1fbb... Update SharedPtr.mqh
=======
   SSharedPtr<T1> StaticCast() {SSharedPtr<T1> ret((T1*)cObject,cCount); return ret;}
   template<typename T1>
   SSharedPtr<T1> DynamicCast() {SSharedPtr<T1> ret(dynamic_cast<T1*>(cObject),cCount); return ret;}
>>>>>>> 34f88e2... Update SharedPtr.mqh
   T* Dereference() {return cObject;}
   T* Get()         {return cObject;}
   void Free();
   void operator =(SSharedPtr<T> &other);
   void operator =(T* ptr);
<<<<<<< HEAD
<<<<<<< HEAD
   _tSizeT Count() {return !cCount?0:_(cCount);}
=======
   _tSizeT cCount() {return !cCount?0:_(cCount);}
>>>>>>> 34f88e2... Update SharedPtr.mqh
=======
   _tSizeT Count() {return !cCount?0:_(cCount);}
>>>>>>> e03c20b... Update SharedPtr.mqh
   bool operator !() {return !cObject;}
};
//--------------------------------------------------------------------------
template<typename T>
SSharedPtr::SSharedPtr(SSharedPtr<T> &other){
   cObject=other.cObject;
   cCount=other.cCount;
   if (cCount!=NULL) ++cCount;}
//--------------------------------------------------------------------------
template<typename T>
void SSharedPtr::Free(){
   if (!cCount) return;
   if (!--cCount){delete cObject; delete cCount;}
   cObject=NULL;
   cCount=NULL;}
//--------------------------------------------------------------------------
template<typename T>
void SSharedPtr::operator =(SSharedPtr<T> &other){
   if (cObject==_(other)) return;
   if (cCount!=NULL&&!--cCount) {delete cObject; delete cCount;}
   cObject=other.cObject;
   cCount=other.cCount;
   if (cCount!=NULL) ++cCount;
}
//--------------------------------------------------------------------------
template<typename T>
void SSharedPtr::operator =(T* ptr){
   if (cObject==ptr) return;
   if (cCount!=NULL&&!--cCount) {delete cObject; delete cCount;}
   cObject=ptr;
   cCount=!ptr?NULL:new CWrapeNumeric<_tSizeT>(1);
}

END_SPACE

#endif