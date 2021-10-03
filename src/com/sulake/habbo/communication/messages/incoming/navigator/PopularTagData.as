package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PopularTagData
   {
       
      
      private var var_2434:String;
      
      private var var_2435:int;
      
      public function PopularTagData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2434 = param1.readString();
         this.var_2435 = param1.readInteger();
      }
      
      public function get tagName() : String
      {
         return this.var_2434;
      }
      
      public function get userCount() : int
      {
         return this.var_2435;
      }
   }
}
