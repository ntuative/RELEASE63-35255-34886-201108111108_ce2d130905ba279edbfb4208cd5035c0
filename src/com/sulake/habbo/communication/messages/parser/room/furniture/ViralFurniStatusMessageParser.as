package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ViralFurniStatusMessageParser implements IMessageParser
   {
       
      
      private var var_206:String;
      
      private var var_236:int;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1615:int = 0;
      
      private var var_438:int;
      
      private var _shareId:String;
      
      private var var_2316:String;
      
      public function ViralFurniStatusMessageParser()
      {
         super();
      }
      
      public function get campaignID() : String
      {
         return this.var_206;
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get itemCategory() : int
      {
         return this.var_1615;
      }
      
      public function get shareId() : String
      {
         return this._shareId;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      public function get firstClickUserName() : String
      {
         return this.var_2316;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_206 = param1.readString();
         this.var_236 = param1.readInteger();
         this.var_438 = param1.readInteger();
         this._shareId = param1.readString();
         this.var_2316 = param1.readString();
         this.var_1615 = param1.readInteger();
         return true;
      }
   }
}
