package com.sulake.habbo.navigator.roomthumbnails
{
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ThumbnailImageConfiguration
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var _id:int;
      
      private var _type:int;
      
      private var var_2221:String;
      
      private var var_2220:BitmapData;
      
      private var _selected:Boolean;
      
      private var var_2222:BitmapData;
      
      private var var_754:IBitmapWrapperWindow;
      
      private var var_2223:Rectangle;
      
      private var var_1712:int = 1;
      
      public function ThumbnailImageConfiguration(param1:HabboNavigator, param2:int, param3:int, param4:String, param5:BitmapData)
      {
         super();
         this._navigator = param1;
         this._id = param2;
         this._type = param3;
         this.var_2221 = param4;
         this.var_2222 = param5;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get picName() : String
      {
         return this.var_2221;
      }
      
      public function getImg() : BitmapData
      {
         if(this.var_2220 == null)
         {
            this.var_2220 = this._navigator.getButtonImage(this.var_2221);
         }
         return this.var_2220;
      }
      
      public function registerListImg(param1:IBitmapWrapperWindow) : void
      {
         this.var_754 = param1;
         this.refreshListImg();
      }
      
      public function copyTo(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = this.getImg();
         param1.copyPixels(_loc2_,_loc2_.rect,new Point((param1.width - _loc2_.width) / 2,param1.height - _loc2_.height),null,null,true);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         this.refreshListImg();
      }
      
      private function refreshListImg() : void
      {
         var _loc1_:* = null;
         if(this.var_2223 == null)
         {
            _loc1_ = this.var_754.bitmap.rect;
            this.var_2223 = new Rectangle(this.var_1712,this.var_1712,_loc1_.width - 2 * this.var_1712,_loc1_.height - 2 * this.var_1712);
         }
         this.var_754.bitmap.fillRect(this.var_754.bitmap.rect,4281545523);
         this.var_754.bitmap.fillRect(this.var_2223,4284900966);
         this.copyTo(this.var_754.bitmap);
         if(this._selected)
         {
            this.var_754.bitmap.copyPixels(this.var_2222,this.var_2222.rect,new Point(0,0),null,null,true);
         }
         this.var_754.invalidate();
      }
   }
}
