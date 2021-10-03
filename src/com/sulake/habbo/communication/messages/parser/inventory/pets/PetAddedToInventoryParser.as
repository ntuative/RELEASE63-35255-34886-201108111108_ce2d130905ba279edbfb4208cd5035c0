package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetAddedToInventoryParser implements IMessageParser
   {
       
      
      private var var_1006:PetData;
      
      private var var_2792:Boolean;
      
      public function PetAddedToInventoryParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1006 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1006 = new PetData(param1);
         this.var_2792 = param1.readBoolean();
         return true;
      }
      
      public function get pet() : PetData
      {
         return this.var_1006;
      }
      
      public function get purchased() : Boolean
      {
         return this.var_2792;
      }
   }
}
