#include "..\Define\StdDefine.mqh"

#ifndef _STD_JSON_TYPES_
#define _STD_JSON_TYPES_

enum STD_EJSONValueType{_eJSON_Object,_eJSON_Array,_eJSON_Number,_eJSON_String,_eJSON_Bool,_eJSON_Null};

class STD_JSONValue{
public:
   virtual STD_EJSONValueType ValueType() const=0;
   virtual bool IsSigned() const {return false;}
   virtual bool IsIntegral() const {return false;}
   virtual bool IsFloatingPoint() const {return false;}
   virtual bool IsArray() const {return false;}
   template<typename JSONType>
   const JSONType* Cast() const {return dynamic_cast<JSONType*>(&this);}
   
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
template<typename Type>
class STD_JSONValueStore:public STD_JSONValue{
   Type cValue;
public:
   STD_JSONValueStore(Type value):cValue(value){}
   Type Value() const {return cValue;}
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class STD_JSONArray:public STD_JSONValue{
   STD_JSONValue* cArray[];
   uint cSize;
   uint cReserv;
public:
   STD_JSONArray():cSize(0),cReserv(0){}
   STD_JSONArray(uint reserv):cSize(0){cReserv=ArrayResize(cArray,reserv);}
  ~STD_JSONArray(){
      for (uint i=0;i<cSize;delete cArray[i++]);
   }
   STD_EJSONValueType ValueType() const override final {return _eJSON_Array;}
   bool IsArray() const override {return true;}
   bool operator +=(STD_JSONValue* ptr){
      if (cSize>=cReserv){
         uint newReserv=MathMin(MathMax(cReserv+1,cReserv*3/2),SHORT_MAX);
         if (ArrayResize(cArray,newReserv)==-1)
            return false;
         cReserv=newReserv;
      }
      cArray[cSize++]=ptr;
      return true;
   }
   uint Size() const {return cSize;}
   const STD_JSONValue* operator [](uint pos) const {return pos<cSize?cArray[pos]:NULL;}
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class STD_JSONTypeNull:STD_JSONValueStore<void*>{
public:
   STD_JSONTypeNull():STD_JSONValueStore(NULL){}
   STD_EJSONValueType ValueType() const override final {return _eJSON_Null;}
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class STD_JSONTypeBool:STD_JSONValueStore<bool>{
public:
   STD_JSONTypeBool(bool value):STD_JSONValueStore(value){}
   STD_EJSONValueType ValueType() const override final {return _eJSON_Bool;}
   bool IsIntegral() const override {return true;}
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class STD_JSONTypeString:STD_JSONValueStore<string>{
public:
   STD_JSONTypeString(string value):STD_JSONValueStore(value){}
   STD_EJSONValueType ValueType() const override final {return _eJSON_String;}
};
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
template<typename Type>
class STD_JSONTypeNumber:STD_JSONValueStore<Type>{
public:
   STD_JSONTypeNumber(Type value):STD_JSONValueStore(value){}
   STD_EJSONValueType ValueType() const override final {return _eJSON_Number;}
};
//////////////////////////////////////////////////////////////////////////////
class STD_JSONDouble:public STD_JSONTypeNumber<double>{
public:
   STD_JSONDouble(double value):STD_JSONTypeNumber(value){}
   bool IsSigned() const override {return true;}
   bool IsFloatingPoint() const override {return true;}
};
//////////////////////////////////////////////////////////////////////////////
template<typename Type>
class STD_JSONIntegral:public STD_JSONTypeNumber<Type>{
public:
   STD_JSONIntegral(Type value):STD_JSONTypeNumber(value){}
   bool IsIntegral() const override {return true;}
};
//////////////////////////////////////////////////////////////////////////////
class STD_JSONLong:public STD_JSONIntegral<long>{
public:
   STD_JSONLong(long value):STD_JSONIntegral(value){}
   bool IsSigned() const override {return true;}
};
//////////////////////////////////////////////////////////////////////////////
class STD_JSONULong:public STD_JSONIntegral<ulong>{
public:
   STD_JSONULong(ulong value):STD_JSONIntegral(value){}
};


#endif 