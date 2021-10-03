package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FlatCategory
   {
       
      
      private var var_1744:int;
      
      private var var_2366:String;
      
      private var var_323:Boolean;
      
      public function FlatCategory(param1:IMessageDataWrapper)
      {
         super();
         this.var_1744 = param1.readInteger();
         this.var_2366 = param1.readString();
         this.var_323 = param1.readBoolean();
      }
      
      public function get nodeId() : int
      {
         return this.var_1744;
      }
      
      public function get nodeName() : String
      {
         return this.var_2366;
      }
      
      public function get visible() : Boolean
      {
         return this.var_323;
      }
   }
}
