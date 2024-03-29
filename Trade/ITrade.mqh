#include "../Define/StdDefine.mqh"

#ifndef _STD_I_TRADE_
#define _STD_I_TRADE_

#include "FTrade.mqh"
#include "../Common/Flag.mqh"

class STD_ITrade:public STD_FTrade{
protected:
   _tFlag cState;
   _tTradeConst cConst;
   datetime cOrderInitTime;
   _tTicket cIdent; //Тиккет ордера, который открыл торговлю
   ECloseReason cCloseReason; //Причина закрытия
   _tTradeError cTradeError;
   STD_ITrade():cIdent(0),cCloseReason(eCloseReasonNull),cTradeError(0){}
public:
//Virtual methods
   virtual bool Control()=0;
   virtual bool Remove()=0;
   virtual bool Close()=0;
   virtual double Volume() const=0;
   virtual double TP() const=0;
   virtual double SL() const=0;
private:
   ///return volume for close (may be hasn't closed at the moment)
   virtual double _Close(double volume)=0;
protected:
   virtual _tTicket _Start() =0;
//TradeConst return methods
public:
   string Symbol() const {return cConst.symbol;}
   const _tTradeConst* Const() {return &cConst;}
   int LotDigits() const {return cConst.lotDigits;}
   int Digits() const {return cConst.digits;}
   double MinLot() const {return cConst.lotMin;}
   double MaxLot() const {return cConst.lotMax;}
   double LotStep() const {return cConst.lotStep;}
   double TickSize() const {return cConst.tickSize;}
   double Point() const {return cConst.point;}
   double StopLevel() const {return cConst.stopLevel;}
   double FreezeLevel() const {return cConst.freezeLevel;}
   double TradePrice() const {return TradePrice(Symbol());}
   _tEDirect Direct() const {return cDirect;}
//TradeStateInfo
   ECloseReason CloseReason() const {return cCloseReason;}
   bool IsInit() const {return cOrderInitTime!=0;}
   virtual bool IsPending() const =0;
   virtual bool IsOpen() const =0;
   virtual bool IsActivate() const =0;
   virtual bool IsClose() const =0;
   bool IsFinish() const {return IsError()||IsClose();}
   bool IsError() const {return cTradeError!=0;}
   _tTicket Ident() const {return cIdent;}
   virtual _tTicket Ticket() const =0;
   const _tFlag* State() const {return &cState;}
   bool IsSLChangeInProcess() const;
   bool IsTPChangeInProcess() const;
   bool IsStopsChangeInProcess() const;
   _tTradeError TradeError() const {return cTradeError;}
//Trade methods
   bool Symbol(string symbol);
   bool Symbol(const _tTradeConst& _const);
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
bool STD_ITrade::Symbol(string symbol){
   return cConst.Init(symbol);
}
//----------------------------------------------------------
bool STD_ITrade::Symbol(const _tTradeConst& _const){
   cConst=_const;
   return cConst.IsInit();
}

#endif 