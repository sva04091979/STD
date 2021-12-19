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
   static STD_JSONValue* ParseValue(ushort &json[],uint &i){}
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
         case ' ':
         case '\r':
         case '\n':
         case '\t':
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
         case ' ':
         case '\r':
         case '\n':
         case '\t':
            break;
         case ':':
            ++i;
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

/*
            while(true){
               switch(json[++i]){
                  default:
                     PrintFormat("JSON object parse error in %s, reason: wrong character %s in position %u, expected string, number, object,array, true, false or null",__FUNCSIG__,ShortToString(json[i]),i);
                     delete pair;
                     return NULL;
                  case "\0':
                     PrintFormat("JSON pair parse error in %s, reason: end of string",__FUNCSIG__);
                     delete pair;
                     return NULL;
                  case ' ':
                  case '\r':
                  case '\n':
                  case '\t':
                     break;
                  case '-':
                     pair.value=ParseSigned(json,i);
                     if(!pair.value){
                        PrintFormat("JSON pair parse error in %s, reason: wrong signed value parse",__FUNCSIG__);
                        delete pair;
                        return NULL;
                     }
                  case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':
                     pair.value=ParseUnsigned(json,i);
                     if(!pair.value){
                        PrintFormat("JSON pair parse error in %s, reason: wrong unsigned value parse",__FUNCSIG__);
                        delete pair;
                        return NULL;
                     }
                  case '"':
                     pair.value=ParseString(json,i);
                     if (!pair.key){
                        PrintFormat("JSON pair parse error in %s, reason: wrong key parse",__FUNCSIG__);
                        delete pair;
                        return NULL;
                     }
               }
            }
      }
   }
}
*/

#endif