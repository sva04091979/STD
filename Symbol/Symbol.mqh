#ifndef _STD_SYMBOL_
#define _STD_SYMBOL_

#include "..\Define\StdDefine.mqh"
#include "FSymbol.mqh"

#define _tSymbol __std(Symbol)

class _tSymbol{
   string cSymbol;
   double cLotStep;
   double cLotMax;
   double cLotMin;
   double cTickSize;
   double cPoint;
   double cStopLevel;
   double cFreezeLevel;
   int cStopLevelPips;
   int cFreezeLevelPips;
   int cDigits;
   int cLotDigits;
   ENUM_SYMBOL_TRADE_EXECUTION cExecutionMode;
#ifdef __MQL5__
   int cExpirationMode;
   int cFillingMode;
   int cOrderMode;
#endif
public:
   _tSymbol():cSymbol(NULL){}
   _tSymbol(string _symbol):cSymbol(NULL){Init(_symbol);}
   _tSymbol(const _tSymbol& other) {this=other;}
   bool Init(string _symbol);
   bool IsInit() const {return cSymbol!=NULL;}
   double Ask() const {return ::Ask(cSymbol);}
   double Bid() const {return ::Bid(cSymbol);}
   string Symbol() const {return cSymbol;}
   double LotStep() const {return cLotStep;}
   double LotMax() const {return cLotMax;}
   double LotMin() const {return cLotMin;}
   double TickSize() const {return cTickSize;}
   double Point() const {return cPoint;}
   double StopLevel() const {return cStopLevel;}
   double FreezeLevel() const {return cFreezeLevel;}
   int StopLevelInt() const {return cStopLevelPips;}
   int FreezeLevelInt() const {return cFreezeLevelPips;}
   int Digits() const {return cDigits;}
   int LotDigits() const {return cLotDigits;}
   ENUM_SYMBOL_TRADE_EXECUTION ExecutionMode() const {return cExecutionMode;}
#ifdef __MQL5__
   int ExpirationMode() const {return cExpirationMode;}
   int FillingMode() const {return cFillingMode;}
   int OrderMode() const {return cOrderMode;}
   bool CanFill(ENUM_ORDER_TYPE_FILLING) const;
   bool IsOrderExpirationUnlimit() const {return !(cExecutionMode&SYMBOL_EXPIRATION_GTC);}
#endif

#ifdef __MQL5__
   double Last() const {return ::Last(cSymbol);}
#endif
};

bool _tSymbol::Init(string _symbol){
   if (!MQLInfoInteger(MQL_TESTER)&&!MQLInfoInteger(MQL_OPTIMIZATION)&&!SymbolSelect(_symbol,true))
      return false;
   cSymbol=_symbol;
   cLotStep=SymbolInfoDouble(_symbol,SYMBOL_VOLUME_STEP);
   cLotDigits=MathMax(-(int)MathFloor(MathLog10(cLotStep)),0);
   cLotMax=SymbolInfoDouble(_symbol,SYMBOL_VOLUME_MAX);
   cLotMin=SymbolInfoDouble(_symbol,SYMBOL_VOLUME_MIN);
   cPoint=SymbolInfoDouble(_symbol,SYMBOL_POINT);
   cTickSize=SymbolInfoDouble(_symbol,SYMBOL_TRADE_TICK_SIZE);
   cStopLevelPips=(int)SymbolInfoInteger(_symbol,SYMBOL_TRADE_STOPS_LEVEL);
   cFreezeLevelPips=(int)SymbolInfoInteger(_symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   cStopLevel=cStopLevelPips*cPoint;
   cFreezeLevel=cFreezeLevelPips*cPoint;
   cDigits=(int)SymbolInfoInteger(_symbol,SYMBOL_DIGITS);
   cExecutionMode=(ENUM_SYMBOL_TRADE_EXECUTION)SymbolInfoInteger(_symbol,SYMBOL_TRADE_EXEMODE);
#ifdef __MQL5__
   cFillingMode=(int)SymbolInfoInteger(_symbol,SYMBOL_FILLING_MODE);
   cExpirationMode=(int)SymbolInfoInteger(_symbol,SYMBOL_EXPIRATION_MODE);
   cOrderMode=(int)SymbolInfoInteger(_symbol,SYMBOL_ORDER_MODE);
#endif
   return true;
}
//------------------------------------------------------------
bool _tSymbol::CanFill(ENUM_ORDER_TYPE_FILLING fillingType) const{
   switch (fillingType){
      case ORDER_FILLING_FOK:
         return bool(cFillingMode&SYMBOL_FILLING_FOK);
      case ORDER_FILLING_IOC:
         return bool(cFillingMode&SYMBOL_FILLING_IOC);
      case ORDER_FILLING_RETURN:
         return !cFillingMode;
   }
   return false;
}
#endif