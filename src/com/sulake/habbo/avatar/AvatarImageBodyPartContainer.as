package com.sulake.habbo.avatar
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AvatarImageBodyPartContainer
   {
       
      
      private var var_49:BitmapData;
      
      private var var_650:Point;
      
      private var _offset:Point;
      
      public function AvatarImageBodyPartContainer(param1:BitmapData, param2:Point)
      {
         this._offset = new Point(0,0);
         super();
         this.var_49 = param1;
         this.var_650 = param2;
         this.cleanPoints();
      }
      
      public function dispose() : void
      {
         if(this.var_49)
         {
            this.var_49.dispose();
         }
         this.var_49 = null;
         this.var_650 = null;
         this._offset = null;
      }
      
      public function set image(param1:BitmapData) : void
      {
         this.var_49 = param1;
      }
      
      public function get image() : BitmapData
      {
         return this.var_49;
      }
      
      public function setRegPoint(param1:Point) : void
      {
         this.var_650 = param1;
         this.cleanPoints();
      }
      
      public function get regPoint() : Point
      {
         return this.var_650.add(this._offset);
      }
      
      public function set offset(param1:Point) : void
      {
         this._offset = param1;
         this.cleanPoints();
      }
      
      private function cleanPoints() : void
      {
         this.var_650.x = int(this.var_650.x);
         this.var_650.y = int(this.var_650.y);
         this._offset.x = int(this._offset.x);
         this._offset.y = int(this._offset.y);
      }
   }
}
