#include "../Define/StdDefine.mqh"

#ifndef _STD_F_SYMBOL_
#define _STD_F_SYMBOL_

#define _tEPriceType STD_EPriseType

#define _eAsk STD_eAsk
#define _eBid STD_eBid
#ifdef __MQL5__
   #define _eLast STD_eLast
#endif
enum STD_EPriseType{
   STD_eAsk=SYMBOL_ASK,
   STD_eBid=SYMBOL_BID
#ifdef __MQL5__
   ,STD_eLast=SYMBOL_LAST
#endif
};

double Price(string symbol,_tEPriceType priceType) {return SymbolInfoDouble(symbol,(ENUM_SYMBOL_INFO_DOUBLE)priceType);}
double Ask(string symbol) {return Price(symbol,_eAsk);}
double Bid(string symbol) {return Price(symbol,_eBid);}
double Last(string symbol) {return Price(symbol,_eLast);}
double OpenPrice(string symbol,_tEDirect direct) {return !direct?0.0:direct==_eBuy?Ask(symbol):Bid(symbol);}
double ClosePrice(string symbol,_tEDirect direct) {return !direct?0.0:direct==_eBuy?Bid(symbol):Ask(symbol);}

#endif