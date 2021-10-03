package com.sulake.habbo.room.object.visualization.data
{
   public class LayerData
   {
      
      public static const const_838:String = "";
      
      public static const const_422:int = 0;
      
      public static const const_570:int = 255;
      
      public static const const_842:Boolean = false;
      
      public static const const_614:int = 0;
      
      public static const const_639:int = 0;
      
      public static const const_419:int = 0;
      
      public static const const_1419:int = 1;
      
      public static const const_1275:int = 2;
      
      public static const INK_DARKEN:int = 3;
       
      
      private var var_2411:String = "";
      
      private var var_1970:int = 0;
      
      private var var_2440:int = 255;
      
      private var var_2441:Boolean = false;
      
      private var var_2444:int = 0;
      
      private var var_2442:int = 0;
      
      private var var_2443:Number = 0;
      
      public function LayerData()
      {
         super();
      }
      
      public function set tag(param1:String) : void
      {
         this.var_2411 = param1;
      }
      
      public function get tag() : String
      {
         return this.var_2411;
      }
      
      public function set ink(param1:int) : void
      {
         this.var_1970 = param1;
      }
      
      public function get ink() : int
      {
         return this.var_1970;
      }
      
      public function set alpha(param1:int) : void
      {
         this.var_2440 = param1;
      }
      
      public function get alpha() : int
      {
         return this.var_2440;
      }
      
      public function set ignoreMouse(param1:Boolean) : void
      {
         this.var_2441 = param1;
      }
      
      public function get ignoreMouse() : Boolean
      {
         return this.var_2441;
      }
      
      public function set xOffset(param1:int) : void
      {
         this.var_2444 = param1;
      }
      
      public function get xOffset() : int
      {
         return this.var_2444;
      }
      
      public function set yOffset(param1:int) : void
      {
         this.var_2442 = param1;
      }
      
      public function get yOffset() : int
      {
         return this.var_2442;
      }
      
      public function set zOffset(param1:Number) : void
      {
         this.var_2443 = param1;
      }
      
      public function get zOffset() : Number
      {
         return this.var_2443;
      }
      
      public function copyValues(param1:LayerData) : void
      {
         if(param1 != null)
         {
            this.tag = param1.tag;
            this.ink = param1.ink;
            this.alpha = param1.alpha;
            this.ignoreMouse = param1.ignoreMouse;
            this.xOffset = param1.xOffset;
            this.yOffset = param1.yOffset;
            this.zOffset = param1.zOffset;
         }
      }
   }
}
