package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
   
   public class AcceptBuddyResultMessageParser implements IMessageParser
   {
       
      
      private var var_2011:Array;
      
      public function AcceptBuddyResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_2011 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_2011.push(new AcceptBuddyFailureData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get failures() : Array
      {
         return this.var_2011;
      }
   }
}
