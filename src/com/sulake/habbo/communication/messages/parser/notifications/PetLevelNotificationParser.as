package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetLevelNotificationParser implements IMessageParser
   {
       
      
      private var var_2051:int;
      
      private var var_2954:String;
      
      private var var_1354:int;
      
      private var var_1307:int;
      
      private var var_2027:int;
      
      private var _color:String;
      
      public function PetLevelNotificationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2051 = param1.readInteger();
         this.var_2954 = param1.readString();
         this.var_1354 = param1.readInteger();
         this.var_1307 = param1.readInteger();
         this.var_2027 = param1.readInteger();
         this._color = param1.readString();
         return true;
      }
      
      public function get petId() : int
      {
         return this.var_2051;
      }
      
      public function get petName() : String
      {
         return this.var_2954;
      }
      
      public function get level() : int
      {
         return this.var_1354;
      }
      
      public function get petType() : int
      {
         return this.var_1307;
      }
      
      public function get breed() : int
      {
         return this.var_2027;
      }
      
      public function get color() : String
      {
         return this._color;
      }
   }
}
