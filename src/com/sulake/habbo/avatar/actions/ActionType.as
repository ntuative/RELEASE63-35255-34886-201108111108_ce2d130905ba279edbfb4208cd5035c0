package com.sulake.habbo.avatar.actions
{
   public class ActionType
   {
       
      
      private var _id:int;
      
      private var var_201:int;
      
      private var _prevents:Array;
      
      private var _preventHeadTurn:Boolean = true;
      
      private var var_2112:Boolean = true;
      
      public function ActionType(param1:XML)
      {
         this._prevents = [];
         super();
         this._id = parseInt(param1.@value);
         this.var_201 = parseInt(param1.@value);
         var _loc2_:String = String(param1.@prevents);
         if(_loc2_ != "")
         {
            this._prevents = _loc2_.split(",");
         }
         this._preventHeadTurn = String(param1.@preventheadturn) == "true";
         var _loc3_:String = String(param1.@animated);
         if(_loc3_ == "")
         {
            this.var_2112 = true;
         }
         else
         {
            this.var_2112 = _loc3_ == "true";
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get value() : int
      {
         return this.var_201;
      }
      
      public function get prevents() : Array
      {
         return this._prevents;
      }
      
      public function get preventHeadTurn() : Boolean
      {
         return this._preventHeadTurn;
      }
      
      public function get isAnimated() : Boolean
      {
         return this.var_2112;
      }
   }
}
