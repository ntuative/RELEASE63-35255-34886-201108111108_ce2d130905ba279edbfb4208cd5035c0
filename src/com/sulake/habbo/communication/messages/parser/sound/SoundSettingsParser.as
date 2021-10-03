package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class SoundSettingsParser implements IMessageParser
   {
       
      
      private var var_992:int;
      
      public function SoundSettingsParser()
      {
         super();
      }
      
      public function get volume() : int
      {
         return this.var_992;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_992 = param1.readInteger();
         return true;
      }
   }
}
