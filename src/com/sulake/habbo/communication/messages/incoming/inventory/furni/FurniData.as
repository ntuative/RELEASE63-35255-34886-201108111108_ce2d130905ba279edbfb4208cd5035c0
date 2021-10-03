package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   public class FurniData
   {
       
      
      private var var_2793:int;
      
      private var var_1488:String;
      
      private var _objId:int;
      
      private var var_1794:int;
      
      private var _category:int;
      
      private var var_2276:String;
      
      private var var_2892:Boolean;
      
      private var var_2893:Boolean;
      
      private var var_2891:Boolean;
      
      private var var_2815:Boolean;
      
      private var var_2462:int;
      
      private var var_2225:int;
      
      private var var_2139:String = "";
      
      private var var_1543:int = -1;
      
      public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:int)
      {
         super();
         this.var_2793 = param1;
         this.var_1488 = param2;
         this._objId = param3;
         this.var_1794 = param4;
         this._category = param5;
         this.var_2276 = param6;
         this.var_2892 = param7;
         this.var_2893 = param8;
         this.var_2891 = param9;
         this.var_2815 = param10;
         this.var_2462 = param11;
      }
      
      public function setExtraData(param1:String, param2:int) : void
      {
         this.var_2139 = param1;
         this.var_2225 = param2;
      }
      
      public function get stripId() : int
      {
         return this.var_2793;
      }
      
      public function get itemType() : String
      {
         return this.var_1488;
      }
      
      public function get objId() : int
      {
         return this._objId;
      }
      
      public function get classId() : int
      {
         return this.var_1794;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get stuffData() : String
      {
         return this.var_2276;
      }
      
      public function get isGroupable() : Boolean
      {
         return this.var_2892;
      }
      
      public function get isRecyclable() : Boolean
      {
         return this.var_2893;
      }
      
      public function get isTradeable() : Boolean
      {
         return this.var_2891;
      }
      
      public function get isSellable() : Boolean
      {
         return this.var_2815;
      }
      
      public function get expiryTime() : int
      {
         return this.var_2462;
      }
      
      public function get slotId() : String
      {
         return this.var_2139;
      }
      
      public function get songId() : int
      {
         return this.var_1543;
      }
      
      public function get extra() : int
      {
         return this.var_2225;
      }
   }
}
