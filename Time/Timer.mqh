#ifndef _STD_C_TIMER_
#define _STD_C_TIMER_

#include <STD\Define\StdDefine.mqh>

#ifdef USING_STD
   #define _tTimer __std(CTimer)
   #define _tTimerInfo __std(STimerInfo)
#endif

NAMESPACE(STD)

struct STimerInfo{
   ulong   lastTimer;
   ulong   delta;
   ulong   step;
   _tSizeT count;
   STimerInfo(){Free();}
   STimerInfo(ulong _timer):lastTimer(_timer),delta(0),count(0){}
   STimerInfo(STimerInfo &other) {this=other;}
   void Reset(ulong mTimer,ulong mStep){
      lastTimer=mTimer;
      delta=0;
      step=mStep;
      count=0;}
   void Reset() {Reset(GetMicrosecondCount(),step);}
   void Free() {ZeroMemory(this);}
   bool operator !() {return !count;}
   _tSizeT Control(ulong mTimer){
      delta=mTimer-lastTimer;
      count=delta/step;
      if (count>0){
         lastTimer+=count*step;
         delta=mTimer-lastTimer;}
      return count;}
};

class CTimer{
protected:
   typedef void (*TimerFunc)(STimerInfo& info);
   STimerInfo cInfo;
   TimerFunc cFunc;
   _tSizeT cCount;
public:
   CTimer():cCount(0){}
   void Free() {cInfo.Free(); cFunc=NULL; cCount=0;}
   CTimer* Reset(ulong mTimer,ulong mStep) {cInfo.Reset(mTimer,mStep); cCount=0; return &this;}
   CTimer* SetTimer() {return SetTimer(GetMicrosecondCount());}
   CTimer* SetTimer(ulong mTimer) {cInfo.lastTimer=mTimer; return &this;}
   CTimer* Step(ulong mStep) {cInfo.step=mStep; return &this;}
   CTimer* Function(TimerFunc mFunc) {cFunc=mFunc; return &this;}
   ulong LastTimer() {return cInfo.lastTimer;}
   ulong LastCheckTimer() {return cInfo.lastTimer+cInfo.delta;}
   ulong Step() {return cInfo.step;}
   STimerInfo LastInfo() {return cInfo;}
   _tSizeT Control() {return Control(GetMicrosecondCount());}
   _tSizeT Control(ulong mTimer);
   _tSizeT GetLastCount();
   bool operator !() {return !cInfo.lastTimer||!cInfo.step;}
};
//------------------------------------------------------------------------------
_tSizeT CTimer::Control(ulong mTimer){
   _tSizeT ret=cInfo.Control(mTimer);
   if (ret>0){
      cCount+=ret;
      if (cFunc!=NULL) cFunc(cInfo);}
   return ret;}
//-------------------------------------------------------------------------------
_tSizeT CTimer::GetLastCount(){
   if (!cCount) return 0;
   _tSizeT ret=cCount;
   cCount=0;
   return ret;}

END_SPACE

#endif