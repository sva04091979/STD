#include <STD\Define\StdDefine.mqh>

#ifndef _STD_INIT_DEINIT_
#define _STD_INIT_DEINIT_

class STD_CInit{
   string cSymbol;
   ENUM_TIMEFRAMES cTimeframe;
public:
   STD_CInit();
   ENUM_INIT_RETCODE Init();
} std_globalInit;
//-----------------------------------------------
STD_CInit::STD_CInit()
//-----------------------------------------------
ENUM_INIT_RETCODE STD_CInit::Init(void){
}

//-----------------------------------------------
ENUM_INIT_RETCODE Init(){
   return std_globalInit.Init();
}

void Deinit(int retcode){
   std_globalInit.Deinit(retcode);
}

#endif