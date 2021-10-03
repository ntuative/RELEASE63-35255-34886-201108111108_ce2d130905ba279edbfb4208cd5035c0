package com.sulake.habbo.messenger.domain
{
   public class Message
   {
      
      public static const const_840:int = 1;
      
      public static const const_777:int = 2;
      
      public static const const_983:int = 3;
      
      public static const const_1369:int = 4;
      
      public static const const_875:int = 5;
      
      public static const const_1312:int = 6;
       
      
      private var _type:int;
      
      private var var_1280:int;
      
      private var var_2724:String;
      
      private var var_2879:String;
      
      public function Message(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         this._type = param1;
         this.var_1280 = param2;
         this.var_2724 = param3;
         this.var_2879 = param4;
      }
      
      public function get messageText() : String
      {
         return this.var_2724;
      }
      
      public function get time() : String
      {
         return this.var_2879;
      }
      
      public function get senderId() : int
      {
         return this.var_1280;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
