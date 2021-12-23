#include "..\Define\StdDefine.mqh"

#ifndef _STD_JSON_PARSER_
#define _STD_JSON_PARSER_

#include "JSONTypes.mqh"

class STD_JSONParser{
public:
   static STD_JSONObject* Parse(string text);
   static STD_JSONObject* ParseObject(ushort &json[],uint &i);
   static STD_JSONPair* ParsePair(ushort &json[],uint &i);
   static string ParseString(ushort &json[],uint &i);
   static bool CheckShield(ushort &json[],uint &i);
   static STD_JSONValue* ParseValue(ushort &json[],uint &i);
   static STD_JSONValue* ParseNumber(ushort &json[],uint &i);
   static STD_JSONValue* ParseNull(ushort &json[],uint &i);
   static STD_JSONValue* ParseBool(ushort &json[],uint &i);
private:
   static bool CheckNegative(ushort &json[],uint &i,bool &isError);
   static bool CheckFloatingPoint(ushort &json[],uint &i,bool &isError);
};
//----------------------------------------------------------------------
const STD_JSONObject* STD_JSONParser::Parse(string text){
   STD_JSONObject* ret=NULL;
   ushort json[];
   uint i=0;
   if (StringToShortArray(text,json)!=0)
      return ParseObject(json,i);
   else{
      Print("JSON parse error");
      return NULL;
   }
}
//-----------------------------------------------------------------------
STD_JSONObject* STD_JSONParser::ParseObject(ushort &json[],uint &i){
   if (json[i]!='{'){
      PrintFormat("JSON object parse error in %s, reason: wrong first character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
      return NULL;
   }
   STD_JSONObject* object=new STD_JSONObject;
   while(true){
      switch(json[++i]){
         case ' ':case '\r':case '\n':case '\t':
            break;
         case '}':
            return object;
         case '"':
            if(!(object+=ParsePair(json,i))){
               PrintFormat("JSON object parse error in %s, reason: wrong parse pair",__FUNCSIG__);
               delete object;
               return NULL;
            }
            if (json[i]=='}')
               return object;
            
            break;
         case '\0':
            PrintFormat("JSON object parse error in %s, reason: end of string",__FUNCSIG__);
            delete object;
            return NULL;
         default:
            PrintFormat("JSON object parse error in %s, reason: wrong character %s in position %u, expected \"",__FUNCSIG__,ShortToString(json[i]),i);
            delete object;
            return NULL;
      }
   }
}
//-----------------------------------------------------------------------
STD_JSONPair* STD_JSONParser::ParsePair(ushort &json[],uint &i){
   STD_JSONPair* pair=new STD_JSONPair;
   pair.key=ParseString(json,i);
   if (pair.key==NULL){
      PrintFormat("JSON pair parse error in %s, reason: wrong key parse",__FUNCSIG__);
      delete pair;
      return NULL;
   }
   while(true){
      switch(json[++i]){
         default:
            PrintFormat("JSON pair parse error in %s, reason: wrong character %s in position %u, expected :",__FUNCSIG__,ShortToString(json[i]),i);
            delete pair;
            return NULL;
         case '\0':
            PrintFormat("JSON pair parse error in %s, reason: end of string",__FUNCSIG__);
            delete pair;
            return NULL;
         case ' ':case '\r':case '\n':case '\t':
            break;
         case ':':
            pair.value=ParseValue(json,i);
            if (!pair.value){
               PrintFormat("JSON pair parse error in %s, reason: wrong value parse",__FUNCSIG__);
               delete pair;
               return NULL;
            }
            return pair;
      }
   }
}
//-----------------------------------------------------------------------------------
string STD_JSONParser::ParseString(ushort &json[],uint &i){
   if (json[i]!='"'){
      PrintFormat("JSON string parse error in %s, reason: wrong character %s in position %u, expected \"",__FUNCSIG__,ShortToString(json[i]),i);
      return NULL;
   }
   uint start=i+1;
   uint count=0;
   while(true){
      switch(json[++i]){
         default:
            ++count;
            break;
         case '\0':
            PrintFormat("JSON string parse error in %s, reason: end of string",__FUNCSIG__);
            return NULL;
         case '"':
            return ShortArrayToString(json,start,count);
         case '\\':
            if (!CheckShield(json,i)){
               PrintFormat("JSON strig parse error in %s, reason: wrong shield parse",__FUNCSIG__);
               return NULL;
            }
            break;
      }
   }
}
//-----------------------------------------------------------------------------------------
bool STD_JSONParser::CheckShield(ushort &json[],uint &i){
   if (json[i]!='\\'){
      PrintFormat("JSON shield parse error in %s, reason: wrong character %s in position %u, expected \\",__FUNCSIG__,ShortToString(json[i]),i);
      return false;
   }
   while(true){
      switch(json[++i]){
         default:
            PrintFormat("JSON shield parse error in %s, reason: unsupported escape sequence \\%s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            return false;
         case '\0':
            PrintFormat("JSON shield parse error in %s, reason: end of string",__FUNCSIG__);
            return false;
         case '"':case '\\':case 'n':case 'r':case 't':
            return true;
         case 'u':
            json[i]='x';
            switch(json[++i]){
               default:
                  PrintFormat("JSON shield parse error in %s, reason: wrong character %s in position %u, expected hex code",__FUNCSIG__,ShortToString(json[i]),i);
                  return false;
               case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                  return true;
            }
      }
   }
}
//----------------------------------------------------------------------------------------------------
STD_JSONValue* STD_JSONParser::ParseValue(ushort &json[],uint &i){
   bool isStop=false;
   STD_JSONValue* value=NULL;
   while(!isStop){
      switch(json[++i]){
         default:
            PrintFormat("JSON shield parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            return NULL;
         case '\0':
            PrintFormat("JSON value parse error in %s, reason: end of string",__FUNCSIG__);
            return NULL;
         case ' ':case '\r':case '\n':case '\t':
            break;
         case '"':{
            string text=ParseString(json,i);
            if (text==NULL){
               PrintFormat("JSON value parse error in %s, reason: wrong string parse",__FUNCSIG__);
               return NULL;
            }
            value=new STD_JSONTypeString(text);
            isStop=true;
            break;
         }
         case '-':case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':
            value=ParseNumber(json,i);
            if (!value){
               PrintFormat("JSON value parse error in %s, reason: wrong number parse",__FUNCSIG__);
               return NULL;
            }
            isStop=true;
            break;
         case '{':
            value=ParseObject(json,i);
            if (!value){
               PrintFormat("JSON value parse error in %s, reason: wrong object parse",__FUNCSIG__);
               return NULL;
            }
            isStop=true;
            break;
         case '[':
            value=ParseArray(json,i);
            if (!value){
               PrintFormat("JSON value parse error in %s, reason: wrong array parse",__FUNCSIG__);
               return NULL;
            }
            isStop=true;
            break;
         case 't':case 'f':
            value=ParseBool(json,i);
            if (!value){
               PrintFormat("JSON value parse error in %s, reason: wrong bool parse",__FUNCSIG__);
               return NULL;
            }
            isStop=true;
            break;
         case 'n':
            value=ParseNull(json,i);
            if (!value){
               PrintFormat("JSON value parse error in %s, reason: wrong null parse",__FUNCSIG__);
               return NULL;
            }
            isStop=true;
            break;
      }
   }
   while(true)
      switch(json[++i]){
         default:
            PrintFormat("JSON shield parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            return NULL;
         case ',':case '}':case ']':
            return value;
         case '\0':
            PrintFormat("JSON value parse error in %s, reason: end of string",__FUNCSIG__);
            delete value;
            return NULL;
         case ' ':case '\r':case '\n':case '\t':
            break;
      }
}
//---------------------------------------------------------------------------------------------------------
STD_JSONValue* STD_JSONParser::ParseNumber(ushort &json[],uint &i){
   string text=NULL;
   uint start=i;
   bool isError=false;
   bool isNegative=CheckNegative(json,i,isError);
   if (isNegative)
      ++i;
   if (!isError){
      bool isFloatingPoint=CheckFloatingPoint(json,i,isError);
      if(!isError){
         if (isFloatingPoint)
            return new STD_JSONDouble(StringToDouble(ShortArrayToString(json,start,i-start)));
         else if (isNegative)
            return new STD_JSONLong(StringToInteger(ShortArrayToString(json,start,i-start)));
         else
            return new STD_JSONULong(StringToInteger(ShortArrayToString(json,start,i-start)));
      }
   }
   PrintFormat("JSON number parse error in %s",__FUNCSIG__);
   return NULL;
};
//---------------------------------------------------------------------------------------------------------
bool STD_JSONParser::CheckNegative(ushort &json[],uint &i,bool &isError){
   isError=false;
   switch(json[i]){
      default:
         PrintFormat("JSON number parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
         isError=true;
         return false;
      case '\0':
         PrintFormat("JSON number parse error in %s, reason: end of string",__FUNCSIG__);
         isError=true;
         return false;
      case '-':
         return true;
      case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':
         return false;
   };
};
//-------------------------------------------------------------------------------------------------------------
bool STD_JSONParser::CheckFloatingPoint(ushort &json[],uint &i,bool &isError){
   bool isFloatingPoint=false;
   bool isExpotencial=false;
   while(true){
      switch(json[i]){
      default:
         PrintFormat("JSON number parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
         isError=true;
         return false;
      case '\0':
         PrintFormat("JSON number parse error in %s, reason: end of string",__FUNCSIG__);
         isError=true;
         return false;
      case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':
         break;
      case 'e':case'E':
         if (isExpotencial){
            PrintFormat("JSON number parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            isError=true;
            return false;
         }
         isExpotencial=true;
         isFloatingPoint=true;
         ++i;
         CheckNegative(json,i,isError);
         if (isError){
            PrintFormat("JSON number parse error in %s",__FUNCSIG__);
            return false;
         }
         break;
      case '.':
         if (isFloatingPoint){
            PrintFormat("JSON number parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            isError=true;
            return false;
         }
         isFloatingPoint=true;
         break;
      case ' ':case '\r':case '\n':case '\t':case ',':case ']':case '}':
         return isFloatingPoint;
      }
      ++i;
   }
};
//-----------------------------------------------------------------------------------------------------------
STD_JSONValue* STD_JSONParser::ParseNull(ushort &json[],uint &i){
   if (json[i]!='n'||
       json[++i]!='u'||
       json[++i]!='l'||
       json[++i]!='l'){
      PrintFormat("JSON null parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
      return NULL;
   }
   return new STD_JSONTypeNull();            
}
//-----------------------------------------------------------------------------------------------------------
STD_JSONValue* STD_JSONParser::ParseBool(ushort &json[],uint &i){
   bool res=false;
   bool isOk=false;
   if (json[i]=='t'){
      if (json[++i]=='r'&&
          json[++i]=='u'&&
          json[++i]=='e'){
      res=true;
      isOk=true;
      }
   }
   else if (json[++i]=='f'&&
            json[++i]=='a'&&
            json[++i]=='l'&&
            json[++i]=='s'&&
            json[++i]=='e'){
      res=false;
      isOk=true;
      }
   if (isOk){
      switch(json[++i]){
         default:
            PrintFormat("JSON number parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
            return NULL;
         case ' ':case '\r':case '\n':case '\t':case ',':case ']':case '}':
            --i;
            break;
      }
      return new STD_JSONTypeBool(res);
   }
   PrintFormat("JSON bool parse error in %s, reason: unsupported character %s in position %u",__FUNCSIG__,ShortToString(json[i]),i);
   return NULL;
}

#endif