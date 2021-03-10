#ifndef _STD_TICK_EVENT_
#define _STD_TICK_EVENT_

#define TickEvent CTickEvent::Ptr()

class CTickEvent{
   class _TickEventBase{
   public:
      virtual void Call()=0;
      virtual bool Equal(void* ptr)=0;
   };
   ///////////////////////////////////////////////////////////////
   template<typename Type>
   class _TickEventWrape:public _TickEventBase{
      Type* cPtr;
   public:
      _TickEventWrape(Type* ptr):cPtr(ptr){}
      void Call() {cPtr.OnTick();}
      bool Equal(void* ptr) {return cPtr==ptr;}
   };
   ///////////////////////////////////////////////////////////////
   class _TickEventNode{
      _TickEventBase* cPtr;
      _TickEventNode* cNext;
   public:
      _TickEventNode(_TickEventBase* ptr):cPtr(ptr){}
     ~_TickEventNode() {delete cPtr;}
      void Call(){
         if (cNext!=NULL) cNext.Call();
         cPtr.Call();
      }
   //----------------------------------------------------------------
      void Next(_TickEventNode* ptr) {cNext=ptr;}
      void Delete(){
         if (cNext!=NULL) cNext.Delete();
         delete &this;
      }
   //----------------------------------------------------------------
      _TickEventNode* Next() {return cNext;}
      bool Equal(void* ptr) {return cPtr.Equal(ptr);}
   };
   ///////////////////////////////////////////////////////////////
   _TickEventNode* cNode;
   CTickEvent():cNode(NULL){}
  ~CTickEvent(){if (cNode!=NULL) cNode.Delete();}
public:
   static CTickEvent* Ptr(){
      static CTickEvent instance;
      return &instance;
   }
//----------------------------------------------------------------
   void Call() {if (cNode!=NULL) cNode.Call();}
//----------------------------------------------------------------
   template<typename Type>
   void AddFast(Type &ptr){
      _TickEventNode* node=new _TickEventNode(new _TickEventWrape<Type>(&ptr));
      node.Next(cNode);
      cNode=node;
   }
//----------------------------------------------------------------
   template<typename Type>
   bool Add(Type &ptr){
      if (Find(&ptr)) return false;
      AddFast(ptr);
      return true;
   }
//----------------------------------------------------------------
   template<typename Type>
   void Remove(Type &ptr){
      if (!cNode) return;
      if (cNode.Equal(&ptr)){
         _TickEventNode* it=cNode;
         cNode=cNode.Next();
         delete it;
      }
      else{
         _TickEventNode* it=cNode;
         _TickEventNode* next=cNode.Next();
         while(next!=NULL)
            if (next.Equal(&ptr)){
               it.Next(next.Next());
               delete next;
               break;
            }
            else{
               it=next;
               next=next.Next();
            }
      }
   }
//----------------------------------------------------------------
   template<typename Type>
   void operator +=(Type &ptr) {AddFast(ptr);}
//----------------------------------------------------------------
   template<typename Type>
   void operator -=(Type &ptr) {Remove(ptr);}
//----------------------------------------------------------------
private:
   bool Find(void* ptr){
   _TickEventNode* it=cNode;
   while(it!=NULL)
      if (it==ptr) return true;
      else it=it.Next();
   return false;
   }
};

#endif