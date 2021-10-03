package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   public class QuestsMessageParser implements IMessageParser
   {
       
      
      private var var_1469:Array;
      
      private var var_2916:Boolean;
      
      public function QuestsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1469 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1469.push(new QuestMessageData(param1));
            _loc3_++;
         }
         this.var_2916 = param1.readBoolean();
         return true;
      }
      
      public function get quests() : Array
      {
         return this.var_1469;
      }
      
      public function get openWindow() : Boolean
      {
         return this.var_2916;
      }
   }
}
