package com.sulake.room.object.visualization
{
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Point;
   
   public final class RoomObjectSprite implements IRoomObjectSprite
   {
      
      private static var var_1216:int = 0;
       
      
      private var var_476:BitmapData = null;
      
      private var var_2497:String = "";
      
      private var var_323:Boolean = true;
      
      private var var_2411:String = "";
      
      private var var_2440:int = 255;
      
      private var _color:int = 16777215;
      
      private var var_1839:String;
      
      private var var_1486:Boolean = false;
      
      private var var_1485:Boolean = false;
      
      private var _offset:Point;
      
      private var var_232:int = 0;
      
      private var _height:int = 0;
      
      private var var_1183:Number = 0;
      
      private var var_2412:Boolean = false;
      
      private var var_2495:Boolean = true;
      
      private var var_2410:Boolean = false;
      
      private var _updateID:int = 0;
      
      private var var_2496:int = 0;
      
      private var var_2498:Array = null;
      
      public function RoomObjectSprite()
      {
         this.var_1839 = BlendMode.NORMAL;
         this._offset = new Point(0,0);
         super();
         this.var_2496 = var_1216++;
      }
      
      public function dispose() : void
      {
         this.var_476 = null;
         this.var_232 = 0;
         this._height = 0;
      }
      
      public function get asset() : BitmapData
      {
         return this.var_476;
      }
      
      public function get assetName() : String
      {
         return this.var_2497;
      }
      
      public function get visible() : Boolean
      {
         return this.var_323;
      }
      
      public function get tag() : String
      {
         return this.var_2411;
      }
      
      public function get alpha() : int
      {
         return this.var_2440;
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function get blendMode() : String
      {
         return this.var_1839;
      }
      
      public function get flipV() : Boolean
      {
         return this.var_1485;
      }
      
      public function get flipH() : Boolean
      {
         return this.var_1486;
      }
      
      public function get offsetX() : int
      {
         return this._offset.x;
      }
      
      public function get offsetY() : int
      {
         return this._offset.y;
      }
      
      public function get width() : int
      {
         return this.var_232;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function get relativeDepth() : Number
      {
         return this.var_1183;
      }
      
      public function get varyingDepth() : Boolean
      {
         return this.var_2412;
      }
      
      public function get capturesMouse() : Boolean
      {
         return this.var_2495;
      }
      
      public function get clickHandling() : Boolean
      {
         return this.var_2410;
      }
      
      public function get instanceId() : int
      {
         return this.var_2496;
      }
      
      public function get updateId() : int
      {
         return this._updateID;
      }
      
      public function get filters() : Array
      {
         return this.var_2498;
      }
      
      public function set asset(param1:BitmapData) : void
      {
         if(param1 != null)
         {
            this.var_232 = param1.width;
            this._height = param1.height;
         }
         this.var_476 = param1;
         ++this._updateID;
      }
      
      public function set assetName(param1:String) : void
      {
         this.var_2497 = param1;
         ++this._updateID;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.var_323 = param1;
         ++this._updateID;
      }
      
      public function set tag(param1:String) : void
      {
         this.var_2411 = param1;
         ++this._updateID;
      }
      
      public function set alpha(param1:int) : void
      {
         param1 &= 255;
         this.var_2440 = param1;
         ++this._updateID;
      }
      
      public function set color(param1:int) : void
      {
         param1 &= 16777215;
         this._color = param1;
         ++this._updateID;
      }
      
      public function set blendMode(param1:String) : void
      {
         this.var_1839 = param1;
         ++this._updateID;
      }
      
      public function set filters(param1:Array) : void
      {
         this.var_2498 = param1;
         ++this._updateID;
      }
      
      public function set flipH(param1:Boolean) : void
      {
         this.var_1486 = param1;
         ++this._updateID;
      }
      
      public function set flipV(param1:Boolean) : void
      {
         this.var_1485 = param1;
         ++this._updateID;
      }
      
      public function set offsetX(param1:int) : void
      {
         this._offset.x = param1;
         ++this._updateID;
      }
      
      public function set offsetY(param1:int) : void
      {
         this._offset.y = param1;
         ++this._updateID;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         this.var_1183 = param1;
         ++this._updateID;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         this.var_2412 = param1;
         ++this._updateID;
      }
      
      public function set capturesMouse(param1:Boolean) : void
      {
         this.var_2495 = param1;
         ++this._updateID;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         this.var_2410 = param1;
         ++this._updateID;
      }
   }
}
