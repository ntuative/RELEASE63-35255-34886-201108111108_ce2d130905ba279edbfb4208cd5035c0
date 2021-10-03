package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChatlineData
   {
       
      
      private var var_2975:int;
      
      private var var_2977:int;
      
      private var var_2976:int;
      
      private var var_2978:String;
      
      private var var_1864:String;
      
      public function ChatlineData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2975 = param1.readInteger();
         this.var_2977 = param1.readInteger();
         this.var_2976 = param1.readInteger();
         this.var_2978 = param1.readString();
         this.var_1864 = param1.readString();
      }
      
      public function get hour() : int
      {
         return this.var_2975;
      }
      
      public function get minute() : int
      {
         return this.var_2977;
      }
      
      public function get chatterId() : int
      {
         return this.var_2976;
      }
      
      public function get chatterName() : String
      {
         return this.var_2978;
      }
      
      public function get msg() : String
      {
         return this.var_1864;
      }
   }
}
