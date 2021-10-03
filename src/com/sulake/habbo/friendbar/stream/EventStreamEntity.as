package com.sulake.habbo.friendbar.stream
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendbar.utils.LinkResolver;
   import com.sulake.habbo.friendbar.utils.LinkTarget;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class EventStreamEntity implements IDisposable
   {
      
      public static var name_6:IWindowContainer;
      
      public static var var_2260:IHabboLocalizationManager;
      
      public static var ASSETS:IAssetLibrary;
      
      public static var var_1428:IHabboEventStream;
      
      private static const const_395:Vector.<EventStreamEntity> = new Vector.<EventStreamEntity>();
      
      private static const const_1144:String = "title";
      
      private static const const_1086:String = "message";
      
      private static const LINK:String = "link";
      
      private static const TEXT:String = "text";
      
      private static const const_1702:String = "time";
      
      private static const const_319:String = "canvas";
      
      private static const LIKE_REGION:String = "like";
      
      private static const const_717:String = "border";
      
      private static const const_486:String = "label";
      
      private static const const_2138:String = "icon";
      
      private static const const_1145:uint = 4293519841;
      
      private static const const_1703:uint = 4292467926;
      
      private static const const_1705:uint = 4278220726;
      
      private static const const_1706:uint = 4283058242;
      
      private static const const_2137:uint = 4294967295;
      
      private static const const_1704:String = "minutes";
      
      private static const const_1700:String = "hours";
      
      private static const const_1701:String = "days";
       
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_171:Boolean = false;
      
      private var _id:int = -1;
      
      private var var_791:LinkTarget;
      
      private var var_1650:int;
      
      private var var_1337:String;
      
      public function EventStreamEntity()
      {
         super();
         this._window = name_6.clone() as IWindowContainer;
         this._window.findChildByName(LINK).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onLinkClicked);
      }
      
      public static function allocate() : EventStreamEntity
      {
         var _loc1_:EventStreamEntity = false ? const_395.pop() : new EventStreamEntity();
         _loc1_.var_171 = false;
         return _loc1_;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set even(param1:Boolean) : void
      {
         this._window.color = !!param1 ? uint(const_1145) : uint(const_1703);
         this._window.findChildByName(const_717).visible = false;
      }
      
      public function get even() : Boolean
      {
         return this._window.color == const_1145;
      }
      
      public function set title(param1:String) : void
      {
         this._window.findChildByName(const_1144).caption = param1;
      }
      
      public function get title() : String
      {
         return !!this._window ? this._window.findChildByName(const_1144).caption : null;
      }
      
      public function set message(param1:String) : void
      {
         this._window.findChildByName(const_1086).caption = param1;
      }
      
      public function get message() : String
      {
         return !!this._window ? this._window.findChildByName(const_1086).caption : null;
      }
      
      public function set numberOfLikes(param1:int) : void
      {
         IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(const_486).caption = String(param1);
      }
      
      public function get numberOfLikes() : int
      {
         return !!this._window ? int(parseInt(IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(const_486).caption)) : 0;
      }
      
      public function set isLikable(param1:Boolean) : void
      {
         this.setIsLikable(param1);
      }
      
      public function set isLikingEnabled(param1:Boolean) : void
      {
         if(this._window)
         {
            this._window.findChildByName(LIKE_REGION).visible = param1;
         }
      }
      
      public function set linkTarget(param1:LinkTarget) : void
      {
         this.var_791 = param1;
         var _loc2_:IWindowContainer = IWindowContainer(this._window.findChildByName(LINK));
         if(this.var_791.type == LinkTarget.NONE)
         {
            _loc2_.visible = false;
         }
         else
         {
            _loc2_.visible = true;
            _loc2_.getChildByName(TEXT).caption = param1.text;
         }
      }
      
      public function get linkTarget() : LinkTarget
      {
         return this.var_791;
      }
      
      public function set imageFilePath(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 != this.var_1337)
         {
            this.var_1337 = param1;
            _loc2_ = ASSETS.getAssetByName(param1);
            if(_loc2_)
            {
               this.image = _loc2_.content as BitmapData;
            }
            else
            {
               _loc3_ = ASSETS.loadAssetFromFile(param1,new URLRequest(param1));
               _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.onImageFileLoaded);
               _loc3_.addEventListener(AssetLoaderEvent.const_40,this.onImageFileLoaded);
            }
         }
      }
      
      public function set image(param1:BitmapData) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this.disposed && this._window && param1)
         {
            _loc2_ = this._window.findChildByName(const_319) as IBitmapWrapperWindow;
            _loc3_ = _loc2_.x + _loc2_.width / 2;
            _loc4_ = _loc2_.y + _loc2_.height / 2;
            _loc2_.bitmap = param1;
            _loc2_.x = _loc3_ - param1.width / 2;
            _loc2_.y = _loc4_ - param1.height / 2;
            _loc2_.width = param1.width;
            _loc2_.height = param1.height;
            this.var_1337 = null;
         }
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get recycled() : Boolean
      {
         return this.var_171;
      }
      
      public function set minutesElapsed(param1:int) : void
      {
         this.var_1650 = param1;
         var _loc2_:String = const_1704;
         if(this.var_1650 >= 1440)
         {
            _loc2_ = const_1701;
            param1 /= 1440;
         }
         else if(this.var_1650 >= 60)
         {
            _loc2_ = const_1700;
            param1 /= 60;
         }
         var _loc3_:ILocalization = var_2260.getLocalization("friendbar.stream." + _loc2_ + ".ago");
         this._window.findChildByName(const_1702).caption = !!_loc3_ ? _loc3_.raw.replace("%value%",String(param1)) : "...?";
      }
      
      public function get minutesElapsed() : int
      {
         return this.var_1650;
      }
      
      public function recycle() : void
      {
         if(!this.var_171)
         {
            if(!this._disposed)
            {
               this._window.parent = null;
               IBitmapWrapperWindow(this._window.findChildByName(const_319)).bitmap = null;
               this.setIsLikable(false);
               this.var_171 = true;
               const_395.push(this);
            }
         }
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this.setIsLikable(false);
            if(this._window)
            {
               this._window.findChildByName(LINK).removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onLinkClicked);
               this._window.dispose();
               this._window = null;
            }
            if(this.var_171)
            {
               const_395.splice(const_395.indexOf(this),1);
               this.var_171 = false;
            }
            this._disposed = true;
         }
      }
      
      private function onLinkClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         if(LinkResolver.open(this.var_791))
         {
            _loc2_ = this._window.findChildByName(LINK);
            _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onLinkClicked);
            _loc2_.visible = false;
         }
      }
      
      private function onLikeMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(var_1428 && true)
            {
               var_1428.likeStreamEvent(this);
            }
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(const_717).visible = true;
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(const_717).visible = false;
         }
      }
      
      private function setIsLikable(param1:Boolean) : void
      {
         var _loc2_:IRegionWindow = this._window.findChildByName(LIKE_REGION) as IRegionWindow;
         _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onLikeMouseEvent);
         _loc2_.removeEventListener(WindowMouseEvent.const_25,this.onLikeMouseEvent);
         _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onLikeMouseEvent);
         ITextWindow(_loc2_.findChildByName(const_486)).underline = param1;
         ITextWindow(_loc2_.findChildByName(const_486)).textColor = !!param1 ? uint(const_1705) : uint(const_1706);
         if(param1)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onLikeMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.const_25,this.onLikeMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onLikeMouseEvent);
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function onImageFileLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_.assetName == this.var_1337)
            {
               _loc3_ = ASSETS.getAssetByName(this.var_1337);
               if(_loc3_)
               {
                  this.image = _loc3_.content as BitmapData;
               }
            }
         }
      }
   }
}
