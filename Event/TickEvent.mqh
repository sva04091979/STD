#ifndef _STD_TICK_EVENT_
#define _STD_TICK_EVENT_

#define TickEvent CTickEvent::Ptr()

class CTickEvent{
   class _TickEventBase{
   public:
      virtual void OnTick()=0;
      virtual bool operator==(void* ptr)=0;
   };
   template<typename Type>
   class _TickEventWrape:public _TickEventBase{
      Type* cPtr;
   public:
      void OnTick() {cPtr.OnTick();}
   };
   class _TickEventNode{
      _TickEventBase* cPtr;
      _TickEventNode* cNext;
   public:
      void OnTick(){
         if (cNext!=NULL) cNext.OnTick();
         cPtr.OnTick();
      }
      void Next(_TickEventNode* ptr) {cNext=ptr;}
      _TickEventNode* Next() {return cNext;}
   } *cNode;
   CTickEvent(){}
public:
   static CTickEvent* Ptr(){
      static CTickEvent instance;
      return &instance;
   }
   void OnTick() {if (cNode!=NULL) cNode.OnTick();}
   template<typename Type>
   void Add(Type* ptr){
      _TickEventNode node=new _TickEventNode(new _TickEventWrape<Type>(ptr));
      node.Next(cNode);
      cNode=node;
   }
   template<typename Type>
   void Remove(Type* ptr){
      if (!cNode) return;
      if (cNode==ptr){
         _TickEventNode* it=cNode;
         cNode=cNode.Next();
         delete it;
      }
      else{
         _TickEventNode* it=cNode;
         _TickEventNode* next=cNode.Next();
         while(next!=NULL)
            if (next==ptr){
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
};

#endif