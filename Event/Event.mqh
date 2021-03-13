#ifndef _STD_EVENT_
#define _STD_EVENT_

template<typename TList>
void __CheckPointer(TList *list){
   while (list!=NULL&&!list.Check()){
      TList* it=list;
      list=list.Next();
      delete it;}
}

#define EventBaseWrapeName(dName) _EventWrapeBase##dName
#define EventWrapeName(dName) _EventWrape##dName
#define EventNodeName(dName) _EventNode##dName

#define _DEventBase(dName,dSign)    \
   class EventBaseWrapeName(dName){ \
   public:                          \
      virtual void Call dSign=0;    \
      virtual bool Check()=0;       \
      virtual bool Equal(void* ptr)=0;}

#define _DEventWrape(dName,dSign,dCall,dFunc)                     \
   template<typename Type>                                        \
   class EventWrapeName(dName):public EventBaseWrapeName(dName){  \
      Type* cPtr;                                                 \
   public:                                                        \
      EventWrapeName(dName)(Type* ptr):cPtr(ptr){}                \
      void Call dSign {cPtr.dFunc dCall;}                         \
      bool Check() {return CheckPointer(cPtr)!=POINTER_INVALID;}  \
      bool Equal(void* ptr) {return cPtr==ptr;}}

#define _DEventNode(dName,dSign,dCall)                                  \
   class EventNodeName(dName){                                          \
      EventBaseWrapeName(dName)* cPtr;                                  \
      EventNodeName(dName)* cNext;                                      \
   public:                                                              \
      EventNodeName(dName)(EventBaseWrapeName(dName)* ptr):cPtr(ptr){}  \
     ~EventNodeName(dName)() {delete cPtr;}                             \
      void Call dSign{                                                  \
         __CheckPointer(cNext);                                         \
         if (cNext!=NULL) cNext.Call dCall;                             \
         cPtr.Call dCall;}                                              \
      bool Check() {return cPtr.Check();}                               \
      void Next(EventNodeName(dName)* ptr) {cNext=ptr;}                 \
      void Delete(){                                                    \
         if (cNext!=NULL) cNext.Delete();                               \
         delete &this;}                                                 \
      EventNodeName(dName)* Next() {return cNext;}                      \
      bool Equal(void* ptr) {return cPtr.Equal(ptr);}}

#define _DEvent(dName,dSign,dCall,dFunc)                                                           \
class dName{                                                                                       \
   EventNodeName(dName)* cNode;                                                                    \
   dName():cNode(NULL){}                                                                           \
  ~dName(){if (cNode!=NULL) cNode.Delete();}                                                       \
public:                                                                                            \
   static dName* Ptr(){                                                                            \
      static dName instance;                                                                       \
      return &instance;}                                                                           \
   void Call dSign {                                                                               \
      __CheckPointer(cNode);                                                                       \
      if (cNode!=NULL) cNode.Call dCall;}                                                          \
   template<typename Type>                                                                         \
   void operator+=(Type &ptr){                                                                     \
      if (Find(&ptr)) return;                                                                      \
      EventNodeName(dName)* node=new EventNodeName(dName)(new EventWrapeName(dName)<Type>(&ptr));  \
      node.Next(cNode);                                                                            \
      cNode=node;}                                                                                 \
   template<typename Type>                                                                         \
   void operator -=(Type &ptr){                                                                    \
      if (!cNode) return;                                                                          \
      if (cNode.Equal(&ptr)){                                                                      \
         EventNodeName(dName)* it=cNode;                                                           \
         cNode=cNode.Next();                                                                       \
         delete it;}                                                                               \
      else{                                                                                        \
         EventNodeName(dName)* it=cNode;                                                           \
         EventNodeName(dName)* next=cNode.Next();                                                  \
         while(next!=NULL)                                                                         \
            if (next.Equal(&ptr)){                                                                 \
               it.Next(next.Next());                                                               \
               delete next;                                                                        \
               break;}                                                                             \
            else{                                                                                  \
               it=next;                                                                            \
               next=next.Next();}}}                                                                \
private:                                                                                           \
   bool Find(void* ptr){                                                                           \
      EventNodeName(dName)* it=cNode;                                                              \
      while(it!=NULL)                                                                              \
         if (it==ptr) return true;                                                                 \
         else it=it.Next();                                                                        \
      return false;}}

#define DefineEvent(dEvent,dSign,dCall,dFunc)      \
   _DEventBase(CEvent##dEvent,dSign);              \
   _DEventWrape(CEvent##dEvent,dSign,dCall,dFunc); \
   _DEventNode(CEvent##dEvent,dSign,dCall);        \
   _DEvent(CEvent##dEvent,dSign,dCall,dFunc)

DefineEvent(Tick,(),(),OnTick);
DefineEvent(Init,(),(),OnInit);
DefineEvent(Deinit,(const int reason),(reason),OnDeinit);
DefineEvent(Timer,(),(),OnTimer);
DefineEvent(Trade,(),(),OnTrade);
DefineEvent(TradeTransaction,(const MqlTradeTransaction& trans,const MqlTradeRequest& request,const MqlTradeResult& result),(trans,request,result),OnTradeTransaction);


#define Event(dEvent) CEvent##dEvent::Ptr()


#endif