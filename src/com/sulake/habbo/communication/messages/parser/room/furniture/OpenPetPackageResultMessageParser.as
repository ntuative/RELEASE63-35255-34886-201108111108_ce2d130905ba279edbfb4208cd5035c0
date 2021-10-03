package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class OpenPetPackageResultMessageParser implements IMessageParser
   {
       
      
      private var var_236:int = 0;
      
      private var var_2032:int = 0;
      
      private var var_2033:String = null;
      
      public function OpenPetPackageResultMessageParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
      
      public function get nameValidationStatus() : int
      {
         return this.var_2032;
      }
      
      public function get nameValidationInfo() : String
      {
         return this.var_2033;
      }
      
      public function flush() : Boolean
      {
         this.var_236 = 0;
         this.var_2032 = 0;
         this.var_2033 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.var_236 = param1.readInteger();
         this.var_2032 = param1.readInteger();
         this.var_2033 = param1.readString();
         return true;
      }
   }
}
