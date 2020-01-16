#ifndef _STD_C_FLAG_
#define _STD_C_FLAG_

#include "Define\StdDefine.mqh"

#ifdef USING_STD
   #define _declFlag static _tFlagType
   #define _tFLAG __std(CFlag)
   #define _tFlag __std(CFlag<_tSizeT>)
#endif

NAMESPACE(STD)

template<typename Type>
class CFlag
  {
   Type              cFlag;
public:
                     CFlag(void):cFlag(0){}
                     CFlag(Type mFlag):cFlag(mFlag){}
                     CFlag(const CFlag &other) {this=other;}
   Type Dereference()                           const {return cFlag;}
   Type Get()                                   const {return cFlag;}
   void operator >>(Type &mFlag)                      {mFlag|=cFlag; cFlag=0;}
   void operator >>(CFlag &other)                     {other|=cFlag; cFlag=0;}
   bool Check(Type mFlag)                       const {return bool(cFlag&mFlag);}
   bool CheckStrong(Type mFlag)                 const {return (cFlag&mFlag)==mFlag;}
   bool CheckRemove(Type mFlag)                       {bool res=Check(mFlag); cFlag&=~mFlag; return res;}
   bool CheckStrongRemove(Type mFlag)                 {bool res=CheckStrong(mFlag); cFlag&=~mFlag; return res;}
   bool CheckAdd(Type mFlag)                          {bool res=Check(mFlag); cFlag|=mFlag; return res;}
   bool CheckStrongAdd(Type mFlag)                    {bool res=CheckStrong(mFlag); cFlag|=mFlag; return res;}
   bool CheckSwitch(Type mFlag)                       {bool res=Check(mFlag); cFlag^=mFlag; return res;}
   bool CheckStrongSwitch(Type mFlag)                 {bool res=CheckStrong(mFlag); cFlag^=mFlag; return res;}
   bool Check(const CFlag &other)               const {return Check(_(other));}
   bool CheckStrong(const CFlag &other)         const {return CheckStrong(_(other));}
   bool CheckRemove(const CFlag &other)               {return CheckRemove(_(other));}
   bool CheckStrongRemove(const CFlag &other)         {return CheckStrongRemove(_(other));}
   bool CheckAdd(const CFlag &other)                  {return CheckAdd(_(other));}
   bool CheckStrongAdd(const CFlag &other)            {return CheckStrongAdd(_(other));}
   bool CheckSwitch(const CFlag &other)               {return CheckSwitch(_(other));}
   bool CheckStrongSwitch(const CFlag &other)         {return CheckStrongSwitch(_(other));}
   bool operator !()                            const {return !cFlag;}
   bool operator ==(Type mFlag)                 const {return Check(mFlag);}
   bool operator ==(const CFlag &other)         const {return Check(other);}
   bool operator !=(Type mFlag)                 const {return !Check(mFlag);}
   bool operator !=(const CFlag &other)         const {return !Check(other);}
   bool operator *(Type mFlag)                  const {return CheckStrong(mFlag);}
   bool operator *(const CFlag &other)          const {return CheckStrong(other);}
   bool operator /(Type mFlag)                  const {return !CheckStrong(mFlag);}
   bool operator /(const CFlag &other)          const {return !CheckStrong(other);}
   bool operator <<=(Type mFlag)                      {return CheckAdd(mFlag);}
   bool operator <<=(const CFlag &other)              {return CheckAdd(other);}
   bool operator >>=(Type mFlag)                      {return CheckRemove(mFlag);}
   bool operator >>=(const CFlag &other)              {return CheckRemove(other);}
   bool operator *=(Type mFlag)                       {return CheckStrongAdd(mFlag);}
   bool operator *=(const CFlag &other)               {return CheckStrongAdd(other);}
   bool operator /=(Type mFlag)                       {return CheckStrongRemove(mFlag);}
   bool operator /=(const CFlag &other)               {return CheckStrongRemove(other);}   
   Type operator =(Type mFlag)                        {return cFlag=mFlag;}
   Type operator =(const CFlag &other)                {return cFlag=_(other);}
   Type operator <<(Type mFlag)                       {cFlag|=mFlag; mFlag=0; return cFlag;}
   Type operator <<(CFlag &other)                     {cFlag|=_(other); other=0; return cFlag;}
   Type operator |=(Type mFlag)                       {return cFlag|=mFlag;}
   Type operator |=(const CFlag &other)               {return cFlag|=_(other);}
   Type operator &=(Type mFlag)                       {return cFlag&=mFlag;}
   Type operator &=(const CFlag &other)               {return cFlag&=_(other);}
   Type operator ^=(Type mFlag)                       {return cFlag^=mFlag;}
   Type operator ^=(const CFlag &other)               {return cFlag^=_(other);}
   Type operator +=(Type mFlag)                       {return cFlag|=mFlag;}
   Type operator +=(const CFlag &other)               {return cFlag|=_(other);}
   Type operator -=(Type mFlag)                       {return cFlag&=~mFlag;}
   Type operator -=(const CFlag &other)               {return cFlag&=~_(other);}
   Type operator |(Type mFlag)                        {return cFlag|mFlag;}
   Type operator |(const CFlag &other)                {return cFlag|_(other);}
   Type operator &(Type mFlag)                        {return cFlag&mFlag;}
   Type operator &(const CFlag &other)                {return cFlag&_(other);}
   Type operator ^(Type mFlag)                        {return cFlag^mFlag;}
   Type operator ^(const CFlag &other)                {return cFlag^_(other);}
   Type operator ~()                            const {return ~cFlag;}
};
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
template<typename T>
void Swap(CFlag<T> &l,CFlag<T> &r){
   T tmp=_(l);
   l=r;
   r=tmp;}
//--------------------------------------------------------------
template<typename T>
void Swap(CFlag<T> &l,T &r){
   T tmp=_(l);
   l=r;
   r=tmp;}
//--------------------------------------------------------------
template<typename T>
void Swap(T &l,CFlag<T> &r){
   T tmp=l;
   l=_(r);
   r=tmp;}

END_SPACE

#endif