package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class HabboActivityPointNotificationMessageParser implements IMessageParser
   {
       
      
      private var var_3070:int = 0;
      
      private var var_3069:int = 0;
      
      private var _type:int;
      
      public function HabboActivityPointNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_3070 = param1.readInteger();
         this.var_3069 = param1.readInteger();
         this._type = param1.readInteger();
         return true;
      }
      
      public function get amount() : int
      {
         return this.var_3070;
      }
      
      public function get change() : int
      {
         return this.var_3069;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
