#include "../Define/StdDefine.mqh"

#ifndef _STD_I_TRADE_
#define _STD_I_TRADE_

#include "FTrade.mqh"

#define _tITrade STD_ITrade

class STD_ITrade{
protected:
   TradeState cState;
   TradeInitState cInitState;
   _tSymbol cSymbol;
   datetime cTradeStartTime;
   _tTicket cIdent; //Orders ticket, wich started trade
   ECloseReason cCloseReason; //Trade close reason
   _tTradeError cTradeError; //Last trade error
   _tEDirect cDirect;
   STD_ITrade():cIdent(0),cCloseReason(eCloseReasonNull),cTradeStartTime(0),cTradeError(0),cDirect(_eNoDirect){}
public:
//Virtual methods
   virtual bool Control()=0;
   virtual bool Remove()=0;
   virtual bool Close()=0;
   virtual double Volume() const=0;
   virtual double TP() const=0;
   virtual double SL() const=0;
protected:
   ///return volume for close (may be hasn't closed at the moment)
   virtual double _Close(double volume)=0;
   virtual _tTicket _Start() =0;
   virtual bool CheckPrice()=0;
   virtual bool CheckStops()=0;
//TradeConst return methods
public:
   const _tSymbol* SymbolInfo() const {return &cSymbol;}
   string Symbol() const {return cSymbol.Symbol();}
   int LotDigits() const {return cSymbol.LotDigits();}
   int Digits() const {return cSymbol.Digits();}
   double MinLot() const {return cSymbol.LotMin();}
   double MaxLot() const {return cSymbol.LotMax();}
   double LotStep() const {return cSymbol.LotStep();}
   double TickSize() const {return cSymbol.TickSize();}
   double Point() const {return cSymbol.Point();}
   double StopLevel() const {return cSymbol.StopLevel();}
   double FreezeLevel() const {return cSymbol.FreezeLevel();}
   _tEDirect Direct() const {return cDirect;}
//TradeStateInfo
   ECloseReason CloseReason() const {return cCloseReason;}
   bool CheckForStart();
   bool IsStart() const {return cTradeStartTime!=0;}
   virtual bool HasPended() const =0;
   virtual bool HasOpened() const =0;
   virtual bool HasActivated() const =0;
   virtual bool HasClosed() const =0;
   bool HasFinished() const {return IsError()||HasClosed();}
   bool IsError() const {return cTradeError!=0;}
   _tTicket Ident() const {return cIdent;}
   virtual _tTicket Ticket() const =0;
   const TradeState* State() const {return &cState;}
   const TradeInitState* InitState() const {return &cInitState;}
   _tTradeError TradeError() const {return cTradeError;}
//Init methods
   STD_ITrade* Symbol(string symbol);
   bool Start(); //TODO
//Trade Methods
   double Close(double volume);
};
//----------------------------------------------------------
double STD_ITrade::Close(double volume){
   if (Compare(volume,Volume(),LotDigits())!=_eLess){
      Close();
      return Volume();
   }
   else
      return _Close(volume);
}
//----------------------------------------------------------
STD_ITrade* STD_ITrade::Symbol(string symbol){
   if (!cSymbol.Init(symbol))
      cInitState+=TradeInitState::wrongSymbol;
   return &this;
}
//-----------------------------------------------------------
bool STD_ITrade::Start(void){
   bool ret=CheckForStart();
   if (ret){
      cTradeStartTime=TimeCurrent();
   }
   return ret;
}
//-----------------------------------------------------------
bool STD_ITrade::CheckForStart(void){
   if (!cSymbol.IsInit()){
      cInitState+=TradeInitState::wrongSymbol;
      return false;
   }
   bool price=CheckPrice();
   bool stops=CheckStops();
   return price&&stops;
}

#endif 