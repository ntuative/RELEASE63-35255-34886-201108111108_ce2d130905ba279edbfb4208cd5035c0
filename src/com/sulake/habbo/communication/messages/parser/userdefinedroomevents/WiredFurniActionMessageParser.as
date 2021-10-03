package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
   
   public class WiredFurniActionMessageParser implements IMessageParser
   {
       
      
      private var var_2022:ActionDefinition;
      
      public function WiredFurniActionMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_2022 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2022 = new ActionDefinition(param1);
         return true;
      }
      
      public function get def() : ActionDefinition
      {
         return this.var_2022;
      }
   }
}
