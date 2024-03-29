#ifndef _ND_TEXT_LABEL_
#define _ND_TEXT_LABEL_

#include "RectangleReadOnly.mqh"
#include "BaseObject.mqh"
#include "TextObject.mqh"
#include "XYObject.mqh"
#include "AnchorPoint.mqh"

#define __tBase TRectangleReadOnlyObject<TXYObject<TAnchorPoint<TTextObject<TColor<TBaseObject>>>>>

class TTextLabel:public __tBase{
public:
   bool Create(long chartId,int subWindow,string name,bool isDeletable=true);
   bool Create(string name);
   bool Show(int subW=0) override;
protected:
   void Init() override;
};
//----------------------------------------------------------
bool TTextLabel::Create(string name){
   return Create(0,0,name);
}
//----------------------------------------------------------
bool TTextLabel::Create(long chartId,int subWindow,string name,bool isDeletable=true){
   bool ret=TBaseObject::Create(chartId,subWindow,name,OBJ_LABEL,isDeletable);
   return ret;
}
//----------------------------------------------------------
void TTextLabel::Init(){
   __tBase::Init();
}
//------------------------------------------------------
bool TTextLabel::Show(int subW){
   bool ret=__tBase::Show(subW);
   if(ret){
   }
   return ret;
}

#undef __tBase

#endif 