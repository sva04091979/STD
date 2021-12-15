#include "..\Define\StdDefine.mqh"

#ifndef _STD_JSON_TYPES_
#define _STD_JSON_TYPES_

enum STD_EJSONValueType{_eJSON_Object,_eJSON_Array,_eJSON_Number,_eJSON_String,_eJSON_Bool,_eJSON_Null};

class STD_JSONValue{
public:
   virtual STD_EJSONValueType ValueType() const=0;
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
enum STD_EJSONNumberType{_eJSON_Long,_eJSON_Double};

template<typename Type>
class STD_JSONTypeNumber:STD_JSONValueStore<Type>{
public:
   STD_JSONTypeNumber(Type value):STD_JSONValueStore(value){}
   virtual STD_EJSONNumberType NumberType() const=0;
   STD_EJSONValueType ValueType() const override final {return _eJSON_Number;}
};
//////////////////////////////////////////////////////////////////////////////
class STD_JSONLong:public STD_JSONTypeNumber<long>{
public:
   STD_JSONLong(long value):STD_JSONTypeNumber(value){}
   STD_EJSONNumberType NumberType() const override final {return _eJSON_Long;}
};
//////////////////////////////////////////////////////////////////////////////
class STD_JSONDouble:public STD_JSONTypeNumber<double>{
public:
   STD_JSONDouble(double value):STD_JSONTypeNumber(value){}
   STD_EJSONNumberType NumberType() const override final {return _eJSON_Double;}
};

#endif 