package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   public class RoomSettingsData
   {
      
      public static const const_592:int = 0;
      
      public static const const_220:int = 1;
      
      public static const const_130:int = 2;
      
      public static const const_831:Array = ["open","closed","password"];
       
      
      private var _roomId:int;
      
      private var _name:String;
      
      private var var_2158:String;
      
      private var var_2364:int;
      
      private var var_1713:int;
      
      private var var_2698:int;
      
      private var var_2746:int;
      
      private var var_953:Array;
      
      private var var_2699:Array;
      
      private var var_2745:int;
      
      private var var_2661:Boolean;
      
      private var var_2697:Boolean;
      
      private var var_2702:Boolean;
      
      private var _hideWalls:Boolean;
      
      private var var_2701:int;
      
      private var var_2700:int;
      
      public function RoomSettingsData()
      {
         super();
      }
      
      public function get allowPets() : Boolean
      {
         return this.var_2661;
      }
      
      public function set allowPets(param1:Boolean) : void
      {
         this.var_2661 = param1;
      }
      
      public function get allowFoodConsume() : Boolean
      {
         return this.var_2697;
      }
      
      public function set allowFoodConsume(param1:Boolean) : void
      {
         this.var_2697 = param1;
      }
      
      public function get allowWalkThrough() : Boolean
      {
         return this.var_2702;
      }
      
      public function set allowWalkThrough(param1:Boolean) : void
      {
         this.var_2702 = param1;
      }
      
      public function get hideWalls() : Boolean
      {
         return this._hideWalls;
      }
      
      public function set hideWalls(param1:Boolean) : void
      {
         this._hideWalls = param1;
      }
      
      public function get wallThickness() : int
      {
         return this.var_2701;
      }
      
      public function set wallThickness(param1:int) : void
      {
         this.var_2701 = param1;
      }
      
      public function get floorThickness() : int
      {
         return this.var_2700;
      }
      
      public function set floorThickness(param1:int) : void
      {
         this.var_2700 = param1;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         this._roomId = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get description() : String
      {
         return this.var_2158;
      }
      
      public function set description(param1:String) : void
      {
         this.var_2158 = param1;
      }
      
      public function get doorMode() : int
      {
         return this.var_2364;
      }
      
      public function set doorMode(param1:int) : void
      {
         this.var_2364 = param1;
      }
      
      public function get categoryId() : int
      {
         return this.var_1713;
      }
      
      public function set categoryId(param1:int) : void
      {
         this.var_1713 = param1;
      }
      
      public function get maximumVisitors() : int
      {
         return this.var_2698;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         this.var_2698 = param1;
      }
      
      public function get maximumVisitorsLimit() : int
      {
         return this.var_2746;
      }
      
      public function set maximumVisitorsLimit(param1:int) : void
      {
         this.var_2746 = param1;
      }
      
      public function get tags() : Array
      {
         return this.var_953;
      }
      
      public function set tags(param1:Array) : void
      {
         this.var_953 = param1;
      }
      
      public function get controllers() : Array
      {
         return this.var_2699;
      }
      
      public function set controllers(param1:Array) : void
      {
         this.var_2699 = param1;
      }
      
      public function get controllerCount() : int
      {
         return this.var_2745;
      }
      
      public function set controllerCount(param1:int) : void
      {
         this.var_2745 = param1;
      }
   }
}
