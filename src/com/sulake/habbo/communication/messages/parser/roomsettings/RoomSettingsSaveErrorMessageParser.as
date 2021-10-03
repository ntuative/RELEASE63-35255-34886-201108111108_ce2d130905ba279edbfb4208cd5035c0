package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomSettingsSaveErrorMessageParser implements IMessageParser
   {
      
      public static const const_2342:int = 1;
      
      public static const const_2246:int = 2;
      
      public static const const_2318:int = 3;
      
      public static const const_2308:int = 4;
      
      public static const const_1818:int = 5;
      
      public static const const_2206:int = 6;
      
      public static const const_1948:int = 7;
      
      public static const const_2066:int = 8;
      
      public static const const_2272:int = 9;
      
      public static const const_1874:int = 10;
      
      public static const const_1961:int = 11;
      
      public static const const_2054:int = 12;
       
      
      private var _roomId:int;
      
      private var var_1849:int;
      
      private var var_673:String;
      
      public function RoomSettingsSaveErrorMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._roomId = param1.readInteger();
         this.var_1849 = param1.readInteger();
         this.var_673 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get errorCode() : int
      {
         return this.var_1849;
      }
      
      public function get info() : String
      {
         return this.var_673;
      }
   }
}
