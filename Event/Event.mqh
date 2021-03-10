#ifndef _STD_EVENT_
#define _STD_EVENT_

template<typename TList>
void __CheckPointer(TList *list){
   while (list!=NULL&&!list.Check()){
      TList* it=list;
      list=list.Next();
      delete it;}
}

#define _DEventBase(dSign) \
   class _TickEventBase{   \
   public:  \
      virtual void Call dSign=0;   \
      virtual bool Check()=0; \
      virtual bool Equal(void* ptr)=0;};

#define _DEventWrape(dSign,dCall,dFunc)  \
   template<typename Type> \
   class _TickEventWrape:public _TickEventBase{ \
      Type* cPtr; \
   public:  \
      _TickEventWrape(Type* ptr):cPtr(ptr){} \
      void Call dSign {cPtr.dFunc dCall;}   \
      bool Check() {return CheckPointer(cPtr)!=POINTER_INVALID;}  \
      bool Equal(void* ptr) {return cPtr==ptr;}};

#define _DEventNode(dSign,dCall) \
   class _TickEventNode{   \
      _TickEventBase* cPtr;   \
      _TickEventNode* cNext;  \
   public:  \
      _TickEventNode(_TickEventBase* ptr):cPtr(ptr){} \
     ~_TickEventNode() {delete cPtr;}  \
      void FastCall dSign{ \
         if (cNext!=NULL) cNext.FastCall dCall; \
         cPtr.Call dCall;} \
      void Call dSign{ \
         __CheckPointer(cNext);  \
         if (cNext!=NULL) cNext.Call dCall; \
         cPtr.Call dCall;} \
      bool Check() {return cPtr.Check();} \
      void Next(_TickEventNode* ptr) {cNext=ptr;}  \
      void Delete(){ \
         if (cNext!=NULL) cNext.Delete(); \
         delete &this;}  \
      _TickEventNode* Next() {return cNext;} \
      bool Equal(void* ptr) {return cPtr.Equal(ptr);}};

#define _DEvent(dName,dSign,dCall,dFunc)  \
class dName{   \
   _DEventBase(dSign); \
   _DEventWrape(dSign,dCall,dFunc);   \
   _DEventNode(dSign,dCall); \
   _TickEventNode* cNode;  \
   dName():cNode(NULL){} \
  ~dName(){if (cNode!=NULL) cNode.Delete();}  \
public:  \
   static dName* Ptr(){  \
      static dName instance;  \
      return &instance;} \
   void FastCall dSign {if (cNode!=NULL) cNode.FastCall dCall;}   \
   void Call dSign { \
      __CheckPointer(cNode);  \
      if (cNode!=NULL) cNode.Call dCall;}   \
   template<typename Type> \
   void AddFast(Type &ptr){   \
      _TickEventNode* node=new _TickEventNode(new _TickEventWrape<Type>(&ptr));  \
      node.Next(cNode); \
      cNode=node;} \
   template<typename Type> \
   bool Add(Type &ptr){ \
      if (Find(&ptr)) return false; \
      AddFast(ptr);  \
      return true;}   \
   template<typename Type> \
   void Remove(Type &ptr){ \
      if (!cNode) return;  \
      if (cNode.Equal(&ptr)){ \
         _TickEventNode* it=cNode;  \
         cNode=cNode.Next();  \
         delete it;}  \
      else{ \
         _TickEventNode* it=cNode;  \
         _TickEventNode* next=cNode.Next();  \
         while(next!=NULL) \
            if (next.Equal(&ptr)){  \
               it.Next(next.Next());   \
               delete next;   \
               break;}   \
            else{ \
               it=next; \
               next=next.Next();}}} \
   template<typename Type> \
   void operator +=(Type &ptr) {AddFast(ptr);}  \
   template<typename Type> \
   void operator -=(Type &ptr) {Remove(ptr);}   \
private: \
   bool Find(void* ptr){   \
   _TickEventNode* it=cNode;  \
   while(it!=NULL)   \
      if (it==ptr) return true;  \
      else it=it.Next();   \
   return false;}}

#define DefineEvent(dEvent,dSign,dCall,dFunc)   \
   _DEvent(CEvent##dEvent,dSign,dCall,dFunc)

#define Event(dEvent) CEvent##dEvent::Ptr()

#endif