package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
   
   public class HabboGroupsWhereMemberMessageParser implements IMessageParser
   {
       
      
      private var var_213:Array;
      
      public function HabboGroupsWhereMemberMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_213 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_213 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_213.push(new HabboGroupEntryData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get groups() : Array
      {
         return this.var_213;
      }
   }
}
