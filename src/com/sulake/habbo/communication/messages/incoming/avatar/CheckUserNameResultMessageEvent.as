package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   
   public class CheckUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static var var_513:int = 0;
      
      public static var var_947:int = 1;
      
      public static var var_946:int = 2;
      
      public static var var_943:int = 3;
      
      public static var var_944:int = 4;
      
      public static var var_945:int = 5;
       
      
      public function CheckUserNameResultMessageEvent(param1:Function)
      {
         super(param1,CheckUserNameResultMessageParser);
      }
      
      public function getParser() : CheckUserNameResultMessageParser
      {
         return var_9 as CheckUserNameResultMessageParser;
      }
   }
}
