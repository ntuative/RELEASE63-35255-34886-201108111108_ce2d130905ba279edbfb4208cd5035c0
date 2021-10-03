package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PresentOpenedMessageParser implements IMessageParser
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1488:String;
      
      private var var_1794:int;
      
      private var var_1795:String;
      
      public function PresentOpenedMessageParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get itemType() : String
      {
         return this.var_1488;
      }
      
      public function get classId() : int
      {
         return this.var_1794;
      }
      
      public function get productCode() : String
      {
         return this.var_1795;
      }
      
      public function flush() : Boolean
      {
         this.var_1488 = "";
         this.var_1794 = 0;
         this.var_1795 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.var_1488 = param1.readString();
         this.var_1794 = param1.readInteger();
         this.var_1795 = param1.readString();
         return true;
      }
   }
}
