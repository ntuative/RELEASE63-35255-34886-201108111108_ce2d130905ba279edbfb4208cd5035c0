package com.sulake.habbo.inventory.items
{
   public class FloorItem implements IItem
   {
       
      
      protected var _id:int;
      
      protected var _ref:int;
      
      protected var _category:int;
      
      protected var _type:int;
      
      protected var var_2276:String;
      
      protected var var_2225:Number;
      
      protected var var_3077:Boolean;
      
      protected var var_3078:Boolean;
      
      protected var var_3061:Boolean;
      
      protected var var_2862:Boolean;
      
      protected var var_3093:int;
      
      protected var var_3065:int;
      
      protected var var_3066:int;
      
      protected var var_3062:int;
      
      protected var var_2139:String;
      
      protected var var_1543:int;
      
      protected var var_995:Boolean;
      
      public function FloorItem(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:String, param10:Number, param11:int, param12:int, param13:int, param14:int, param15:String, param16:int)
      {
         super();
         this._id = param1;
         this._type = param2;
         this._ref = param3;
         this._category = param4;
         this.var_3061 = param5;
         this.var_3078 = param6;
         this.var_3077 = param7;
         this.var_2862 = param8;
         this.var_2276 = param9;
         this.var_2225 = param10;
         this.var_3093 = param11;
         this.var_3065 = param12;
         this.var_3066 = param13;
         this.var_3062 = param14;
         this.var_2139 = param15;
         this.var_1543 = param16;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get ref() : int
      {
         return this._ref;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get stuffData() : String
      {
         return this.var_2276;
      }
      
      public function get extra() : Number
      {
         return this.var_2225;
      }
      
      public function get recyclable() : Boolean
      {
         return this.var_3077;
      }
      
      public function get tradeable() : Boolean
      {
         return this.var_3078;
      }
      
      public function get groupable() : Boolean
      {
         return this.var_3061;
      }
      
      public function get sellable() : Boolean
      {
         return this.var_2862;
      }
      
      public function get expires() : int
      {
         return this.var_3093;
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
      
      public function get slotId() : String
      {
         return this.var_2139;
      }
      
      public function get songId() : int
      {
         return this.var_1543;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this.var_995 = param1;
      }
      
      public function get locked() : Boolean
      {
         return this.var_995;
      }
   }
}
