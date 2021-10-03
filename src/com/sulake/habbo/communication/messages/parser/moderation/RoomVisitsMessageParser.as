package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
   
   public class RoomVisitsMessageParser implements IMessageParser
   {
       
      
      private var _data:RoomVisitsData;
      
      public function RoomVisitsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._data = new RoomVisitsData(param1);
         return true;
      }
      
      public function get data() : RoomVisitsData
      {
         return this._data;
      }
   }
}
