package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class OutfitData
   {
       
      
      private var var_2139:int;
      
      private var var_2819:String;
      
      private var var_1123:String;
      
      public function OutfitData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2139 = param1.readInteger();
         this.var_2819 = param1.readString();
         this.var_1123 = param1.readString();
      }
      
      public function get slotId() : int
      {
         return this.var_2139;
      }
      
      public function get figureString() : String
      {
         return this.var_2819;
      }
      
      public function get gender() : String
      {
         return this.var_1123;
      }
   }
}
