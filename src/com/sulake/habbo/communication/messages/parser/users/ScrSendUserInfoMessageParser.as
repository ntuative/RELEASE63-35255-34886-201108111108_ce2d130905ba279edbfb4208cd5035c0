package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ScrSendUserInfoMessageParser implements IMessageParser
   {
      
      public static const const_2282:int = 1;
      
      public static const RESPONSE_TYPE_PURCHASE:int = 2;
      
      public static const const_1278:int = 3;
       
      
      private var var_962:String;
      
      private var var_2370:int;
      
      private var var_2373:int;
      
      private var var_2377:int;
      
      private var var_2376:int;
      
      private var var_2375:Boolean;
      
      private var var_2371:Boolean;
      
      private var var_2369:int;
      
      private var var_2368:int;
      
      private var var_2378:Boolean;
      
      private var var_2372:int;
      
      private var var_2374:int;
      
      public function ScrSendUserInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_962 = param1.readString();
         this.var_2370 = param1.readInteger();
         this.var_2373 = param1.readInteger();
         this.var_2377 = param1.readInteger();
         this.var_2376 = param1.readInteger();
         this.var_2375 = param1.readBoolean();
         this.var_2371 = param1.readBoolean();
         this.var_2369 = param1.readInteger();
         this.var_2368 = param1.readInteger();
         this.var_2378 = param1.readBoolean();
         this.var_2372 = param1.readInteger();
         this.var_2374 = param1.readInteger();
         return true;
      }
      
      public function get productName() : String
      {
         return this.var_962;
      }
      
      public function get daysToPeriodEnd() : int
      {
         return this.var_2370;
      }
      
      public function get memberPeriods() : int
      {
         return this.var_2373;
      }
      
      public function get periodsSubscribedAhead() : int
      {
         return this.var_2377;
      }
      
      public function get responseType() : int
      {
         return this.var_2376;
      }
      
      public function get hasEverBeenMember() : Boolean
      {
         return this.var_2375;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2371;
      }
      
      public function get pastClubDays() : int
      {
         return this.var_2369;
      }
      
      public function get pastVipDays() : int
      {
         return this.var_2368;
      }
      
      public function get isShowBasicPromo() : Boolean
      {
         return this.var_2378;
      }
      
      public function get basicNormalPrice() : int
      {
         return this.var_2372;
      }
      
      public function get basicPromoPrice() : int
      {
         return this.var_2374;
      }
   }
}
