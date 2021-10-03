package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   public class ItemDataStructure
   {
       
      
      private var var_2388:int;
      
      private var var_1488:String;
      
      private var var_3060:int;
      
      private var var_3064:int;
      
      private var _category:int;
      
      private var var_2276:String;
      
      private var var_2225:int;
      
      private var var_3063:int;
      
      private var var_3065:int;
      
      private var var_3066:int;
      
      private var var_3062:int;
      
      private var var_3061:Boolean;
      
      private var var_3159:int;
      
      public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int, param12:Boolean)
      {
         super();
         this.var_2388 = param1;
         this.var_1488 = param2;
         this.var_3060 = param3;
         this.var_3064 = param4;
         this._category = param5;
         this.var_2276 = param6;
         this.var_2225 = param7;
         this.var_3063 = param8;
         this.var_3065 = param9;
         this.var_3066 = param10;
         this.var_3062 = param11;
         this.var_3061 = param12;
      }
      
      public function get itemID() : int
      {
         return this.var_2388;
      }
      
      public function get itemType() : String
      {
         return this.var_1488;
      }
      
      public function get roomItemID() : int
      {
         return this.var_3060;
      }
      
      public function get itemTypeID() : int
      {
         return this.var_3064;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get stuffData() : String
      {
         return this.var_2276;
      }
      
      public function get extra() : int
      {
         return this.var_2225;
      }
      
      public function get timeToExpiration() : int
      {
         return this.var_3063;
      }
      
      public function get creationDay() : int
      {
         return this.var_3065;
      }
      
      public function get creationMonth() : int
      {
         return this.var_3066;
      }
      
      public function get creationYear() : int
      {
         return this.var_3062;
      }
      
      public function get groupable() : Boolean
      {
         return this.var_3061;
      }
      
      public function get songID() : int
      {
         return this.var_2225;
      }
   }
}
