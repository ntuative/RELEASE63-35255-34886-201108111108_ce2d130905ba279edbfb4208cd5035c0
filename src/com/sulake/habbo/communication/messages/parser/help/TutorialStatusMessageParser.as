package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TutorialStatusMessageParser implements IMessageParser
   {
       
      
      private var var_1239:Boolean;
      
      private var var_1240:Boolean;
      
      private var var_1519:Boolean;
      
      public function TutorialStatusMessageParser()
      {
         super();
      }
      
      public function get hasChangedLooks() : Boolean
      {
         return this.var_1239;
      }
      
      public function get hasChangedName() : Boolean
      {
         return this.var_1240;
      }
      
      public function get hasCalledGuideBot() : Boolean
      {
         return this.var_1519;
      }
      
      public function flush() : Boolean
      {
         this.var_1239 = false;
         this.var_1240 = false;
         this.var_1519 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1239 = param1.readBoolean();
         this.var_1240 = param1.readBoolean();
         this.var_1519 = param1.readBoolean();
         return true;
      }
   }
}
