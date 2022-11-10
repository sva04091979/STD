#include "../Define/StdDefine.mqh"
#include "../Memory/SharedPtr.mqh"

#ifndef _STD_MQL5_TRADE_
#define _STD_MQL5_TRADE_

#include "ITrade.mqh"

#define _tTrade STD_MQL5Trade

class STD_MQL5Trade:public STD_ITrade{
   _tSharedPtr<STD_ITrade> cTrade;
public:
   STD_MQL5Trade():cTrade(new STD_ITrade){};
   bool  Control() override;
   bool Remove() override;
   bool Close() override;
   double Volume() const override {return _(cTrade).Volume();}
   double TP() const override {return _(cTrade).TP();}
   double SL() const override {return _(cTrade).SL();}
   bool HasPended() const override {return _(cTrade).HasPended();}
   bool HasOpened() const override {return _(cTrade).HasOpened();}
   bool HasActivated() const override {return _(cTrade).HasActivated();}
   bool HasClosed() const override {return _(cTrade).HasClosed();}
   _tTicket Ticket() const override {return _(cTrade).SL();}
private:
   double _Close(double volume) override;
   _tTicket _Start() override;
   bool CheckPrice() override {return _(cTrade).CheckPrice();}
   bool CheckStops() override {return _(cTrade).CheckStops();}
};
_tTrade test;

#endif