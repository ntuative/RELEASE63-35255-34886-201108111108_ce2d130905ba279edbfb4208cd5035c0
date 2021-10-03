package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.enum.FurniCategory;
   import com.sulake.habbo.inventory.enum.FurniModelCategory;
   import com.sulake.habbo.inventory.items.FloorItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IItem;
   import com.sulake.habbo.inventory.items.WallItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.sound.IHabboSoundManager;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class FurniView implements IInventoryView, IGetImageListener
   {
      
      private static const const_2123:int = 0;
      
      private static const const_1075:int = 1;
      
      private static const const_1094:int = 2;
      
      private static const const_1091:int = 3;
      
      private static const const_1095:int = 42;
      
      private static const const_1093:int = 120;
      
      private static const const_1092:int = 4;
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _view:IWindowContainer;
      
      private var var_78:FurniModel;
      
      private var var_897:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _soundManager:IHabboSoundManager;
      
      private var _disposed:Boolean = false;
      
      private var var_226:Map;
      
      private var var_477:String;
      
      private var var_1375:int = 0;
      
      private var var_1582:int = -1;
      
      public function FurniView(param1:FurniModel, param2:MarketplaceModel, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboSoundManager)
      {
         var _loc12_:* = null;
         super();
         this.var_78 = param1;
         this.var_897 = param2;
         this._assetLibrary = param4;
         this._windowManager = param3;
         this._roomEngine = param5;
         this._soundManager = param6;
         this._soundManager.events.addEventListener(SongInfoReceivedEvent.const_95,this.onSongInfoReceivedEvent);
         this.var_226 = new Map();
         this.var_226.add(FurniModelCategory.const_38,new FurniGridView(this.var_78,FurniModelCategory.const_38,this._windowManager,this._assetLibrary,this._roomEngine));
         this.var_226.add(FurniModelCategory.const_44,new FurniGridView(this.var_78,FurniModelCategory.const_44,this._windowManager,this._assetLibrary,this._roomEngine));
         var _loc7_:XmlAsset = this._assetLibrary.getAssetByName("inventory_furni_base_xml") as XmlAsset;
         if(_loc7_ == null)
         {
            return;
         }
         this._view = this._windowManager.buildFromXML(_loc7_.content as XML) as IWindowContainer;
         this._view.visible = false;
         this._view.procedure = this.windowEventProc;
         this.addUnseenItemSymbols();
         this.switchCategory(FurniModelCategory.const_38);
         var _loc8_:IWindowContainer = this._view.findChildByName("preview_container") as IWindowContainer;
         if(_loc8_ != null)
         {
            _loc7_ = this._assetLibrary.getAssetByName("inventory_furni_preview_xml") as XmlAsset;
            _loc12_ = this._windowManager.buildFromXML(_loc7_.content as XML) as IWindowContainer;
            if(_loc12_ != null)
            {
               _loc8_.addChild(_loc12_);
            }
         }
         var _loc9_:IBitmapWrapperWindow = this._view.findChildByName("download_image") as IBitmapWrapperWindow;
         _loc9_.bitmap = new BitmapData(_loc9_.width,_loc9_.height);
         var _loc10_:BitmapData = this._assetLibrary.getAssetByName("download_icon_png").content as BitmapData;
         _loc9_.bitmap.copyPixels(_loc10_,_loc10_.rect,new Point((_loc9_.width - _loc10_.width) / 2,(_loc9_.height - _loc10_.height) / 2),null,null,true);
         _loc9_ = this._view.findChildByName("image") as IBitmapWrapperWindow;
         _loc9_.bitmap = new BitmapData(_loc9_.width,_loc9_.height);
         var _loc11_:BitmapData = this._assetLibrary.getAssetByName("inventory_empty_png").content as BitmapData;
         _loc9_.bitmap.copyPixels(_loc11_,_loc11_.rect,new Point((_loc9_.width - _loc11_.width) / 2,(_loc9_.height - _loc11_.height) / 2),null,null,true);
         this.setViewToState();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      private function addUnseenItemSymbols() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc1_:XmlAsset = this._assetLibrary.getAssetByName("unseen_item_symbol_xml") as XmlAsset;
         var _loc2_:IWindow = this._windowManager.buildFromXML(_loc1_.content as XML);
         for each(_loc5_ in ["floor","wall","pets"])
         {
            _loc4_ = this._view.findChildByName("tab_" + _loc5_);
            _loc3_ = _loc2_.clone() as IWindowContainer;
            _loc6_ = _loc3_.findChildByName("text");
            if(_loc6_)
            {
               _loc6_.caption = "${" + _loc6_.caption + "}";
            }
            _loc3_.x = _loc4_.rectangle.right - _loc3_.width - const_1092;
            _loc3_.y = _loc4_.y + const_1092;
            _loc3_.tags.push("unseen_symbol_" + _loc5_);
            _loc3_.visible = false;
            this._view.addChild(_loc3_);
         }
         _loc2_.dispose();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!this._disposed)
         {
            this.var_78 = null;
            this.var_897 = null;
            this._assetLibrary = null;
            this._windowManager = null;
            this._roomEngine = null;
            if(this.var_226)
            {
               for each(_loc1_ in this.var_226)
               {
                  _loc1_.dispose();
               }
               this.var_226.dispose();
               this.var_226 = null;
            }
            if(this._soundManager)
            {
               if(this._soundManager.events != null)
               {
                  this._soundManager.events.removeEventListener(SongInfoReceivedEvent.const_95,this.onSongInfoReceivedEvent);
               }
               this._soundManager = null;
            }
            if(this._view)
            {
               this._view.dispose();
               this._view = null;
            }
            this._disposed = true;
         }
      }
      
      public function get isVisible() : Boolean
      {
         return this._view.parent != null && this._view.visible;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         var _loc2_:* = null;
         if(this._view == null)
         {
            return null;
         }
         if(this._view.disposed)
         {
            return null;
         }
         var _loc1_:Boolean = this.var_78.isTradingOpen;
         _loc2_ = this._view.findChildByName("placeinroom_btn");
         if(_loc2_ != null)
         {
            _loc2_.visible = !_loc1_;
         }
         _loc2_ = this._view.findChildByName("offertotrade_btn");
         if(_loc2_ != null)
         {
            _loc2_.visible = _loc1_;
         }
         return this._view;
      }
      
      public function get visibleCategoryId() : String
      {
         return this.var_477;
      }
      
      public function switchCategory(param1:String) : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         if(this.var_477 == param1)
         {
            return;
         }
         var _loc2_:ISelectorWindow = this._view.findChildByName("category_selector") as ISelectorWindow;
         if(this.var_78.isMainViewActive())
         {
            this.var_78.resetUnseenItems();
         }
         switch(param1)
         {
            case FurniModelCategory.const_44:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_wall"));
               this.var_477 = FurniModelCategory.const_44;
               break;
            case FurniModelCategory.const_38:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_floor"));
               this.var_477 = FurniModelCategory.const_38;
               break;
            case FurniModelCategory.const_256:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_pets"));
               this.var_477 = FurniModelCategory.const_256;
               break;
            default:
               throw new Error("Unknown item category: \"" + param1 + "\"");
         }
         this.var_78.furniCategorySwitch();
         this.showCategoryGrid(this.var_477);
         this.setViewToState();
      }
      
      private function showCategoryGrid(param1:String = null) : void
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            param1 = this.var_477;
         }
         var _loc2_:IWindowContainer = this._view.findChildByName("grid_container") as IWindowContainer;
         _loc2_.removeChildAt(0);
         var _loc3_:FurniGridView = this.var_226.getValue(this.var_477);
         if(_loc3_)
         {
            _loc4_ = _loc3_.window;
            if(_loc4_ == null)
            {
               return;
            }
            _loc2_.addChild(_loc4_);
            _loc2_.invalidate();
            this.updateActionView();
         }
      }
      
      public function setViewToState() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = this.var_78.getCategoryContent(this.var_477);
         if(!this.var_78.isListInited())
         {
            _loc2_ = const_1075;
         }
         else if(!_loc1_ || _loc1_.length == 0)
         {
            _loc2_ = const_1094;
         }
         else
         {
            _loc2_ = const_1091;
         }
         if(this.var_1375 == _loc2_)
         {
            return;
         }
         this.var_1375 = _loc2_;
         var _loc3_:IWindowContainer = this._view.findChildByName("loading_container") as IWindowContainer;
         var _loc4_:IWindowContainer = this._view.findChildByName("empty_container") as IWindowContainer;
         var _loc5_:IWindowContainer = this._view.findChildByName("furni_container") as IWindowContainer;
         switch(_loc2_)
         {
            case const_1075:
               _loc3_.visible = true;
               _loc4_.visible = false;
               _loc5_.visible = false;
               break;
            case const_1094:
               _loc3_.visible = false;
               _loc4_.visible = true;
               _loc5_.visible = false;
               break;
            case const_1091:
               _loc3_.visible = false;
               _loc4_.visible = false;
               _loc5_.visible = true;
               this.showCategoryGrid();
         }
      }
      
      public function clearViews() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = [FurniModelCategory.const_38,FurniModelCategory.const_44];
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_];
            _loc3_ = this.var_226.getValue(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.clearGrid();
            }
            _loc4_++;
         }
         this.updateActionView();
      }
      
      public function updateItem(param1:String, param2:GroupItem, param3:int) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:FurniGridView = this.var_226.getValue(param1);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.updateItem(param3,param2.window);
         this.updateActionView();
      }
      
      public function addItemToBottom(param1:String, param2:GroupItem) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:FurniGridView = this.var_226.getValue(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.addItemToBottom(param2.window);
      }
      
      public function addItemAt(param1:String, param2:GroupItem, param3:int) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:FurniGridView = this.var_226.getValue(param1);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.addItemAt(param2.window,param3);
      }
      
      public function removeItem(param1:String, param2:int) : void
      {
         var _loc3_:FurniGridView = this.var_226.getValue(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IWindow = _loc3_.removeItem(param2);
         if(_loc4_)
         {
            _loc4_.dispose();
         }
         this.updateActionView();
      }
      
      public function moveItemTo(param1:GroupItem, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:FurniGridView = this.var_226.getValue(param1.mainCategory);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.moveItemTo(param1.window,param2);
      }
      
      public function setGridLock(param1:String, param2:Boolean) : void
      {
         var _loc3_:FurniGridView = this.var_226.getValue(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.setLock(param2);
      }
      
      public function updateCategoryButtons() : void
      {
         var _loc1_:* = null;
         _loc1_ = this._view.findChildByTag("unseen_symbol_floor");
         _loc1_.visible = this.var_78.getUnseenItemCount(UnseenItemCategoryEnum.const_463) > 0;
         _loc1_ = this._view.findChildByTag("unseen_symbol_wall");
         _loc1_.visible = this.var_78.getUnseenItemCount(UnseenItemCategoryEnum.const_453) > 0;
         _loc1_ = this._view.findChildByTag("unseen_symbol_pets");
         _loc1_.visible = this.var_78.petsModel.getUnseenItemCount() > 0;
      }
      
      public function updateActionView() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:int = 0;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:* = null;
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc3_:int = this.var_78.getSelectedItemIndex();
         _loc4_ = this.var_78.getGroupItemInIndex(_loc3_,this.var_477);
         if(_loc3_ > -1 && _loc4_ != null && _loc4_.method_1() != null)
         {
            _loc5_ = _loc4_.method_1();
            _loc1_ = true;
            _loc16_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId,this._roomEngine.activeRoomCategory,RoomObjectVariableEnum.const_217);
            _loc17_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId,this._roomEngine.activeRoomCategory,RoomObjectVariableEnum.const_221);
            _loc18_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId,this._roomEngine.activeRoomCategory,RoomObjectVariableEnum.const_236);
            _loc16_ = _loc16_ && _loc16_.length > 0 ? _loc16_ : "101";
            _loc17_ = _loc17_ && _loc17_.length > 0 ? _loc17_ : "101";
            _loc18_ = _loc18_ && _loc18_.length > 0 ? _loc18_ : "1.1";
            if(_loc5_.category == FurniCategory.const_379)
            {
               _loc22_ = this._roomEngine.getRoomImage(_loc17_,_loc5_.stuffData,_loc18_,64,this);
               if(_loc22_ != null)
               {
                  _loc2_ = _loc22_.data;
               }
               this.setPreviewImage(_loc2_);
               _loc9_ = "${inventory.furni.item.wallpaper.name}";
               _loc10_ = "${inventory.furni.item.wallpaper.desc}";
            }
            else if(_loc5_.category == FurniCategory.const_332)
            {
               _loc22_ = this._roomEngine.getRoomImage(_loc5_.stuffData,_loc16_,_loc18_,64,this);
               if(_loc22_ != null)
               {
                  _loc2_ = _loc22_.data;
               }
               this.setPreviewImage(_loc2_);
               _loc9_ = "${inventory.furni.item.floor.name}";
               _loc10_ = "${inventory.furni.item.floor.desc}";
            }
            else if(_loc5_.category == FurniCategory.const_348)
            {
               _loc15_ = this._assetLibrary.getAssetByName("icon_landscape_png");
               if(_loc15_ != null)
               {
                  this.setPreviewImage(_loc15_.content as BitmapData);
               }
               _loc9_ = "${inventory.furni.item.landscape.name}";
               _loc10_ = "${inventory.furni.item.landscape.desc}";
            }
            else
            {
               if(_loc5_.category == FurniCategory.const_212)
               {
                  _loc9_ = "${poster_" + _loc5_.stuffData + "_name}";
                  _loc10_ = "${poster_" + _loc5_.stuffData + "_desc}";
               }
               _loc23_ = 4294967295;
               if(_loc5_ is FloorItem)
               {
                  _loc22_ = this._roomEngine.getFurnitureImage(_loc4_.type,new Vector3d(180,0,0),64,this,_loc23_,String(_loc4_.extra));
               }
               else
               {
                  _loc22_ = this._roomEngine.getWallItemImage(_loc4_.type,new Vector3d(180,0,0),64,this,_loc23_,_loc4_.stuffData);
               }
               if(_loc22_ != null)
               {
                  _loc2_ = _loc22_.data;
               }
               this.setPreviewImage(_loc2_);
               _loc4_.previewCallbackId = _loc22_.id;
            }
            _loc6_ = this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow;
            _loc7_ = this._view.findChildByName("tradeable_number") as ITextWindow;
            _loc8_ = this._view.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc6_ != null && _loc7_ != null && _loc8_ != null)
            {
               _loc21_ = _loc4_.getTradeableCount();
               if(_loc21_ == 0)
               {
                  _loc20_ = this._assetLibrary.getAssetByName("no_trade_icon_png");
                  _loc19_ = _loc20_.content as BitmapData;
                  _loc7_.visible = false;
                  _loc8_.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                  _loc7_.filters = [];
               }
               else
               {
                  _loc20_ = this._assetLibrary.getAssetByName("trade_icon_png");
                  _loc19_ = _loc20_.content as BitmapData;
                  _loc7_.visible = true;
                  _loc7_.text = String(_loc21_);
                  _loc8_.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                  _loc7_.filters = [new GlowFilter(16777215,1,3,3,300)];
               }
               _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               if(_loc19_ != null)
               {
                  _loc6_.bitmap.copyPixels(_loc19_,_loc19_.rect,new Point(0,0),null,null,true);
               }
               _loc6_.invalidate();
            }
            _loc6_ = this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow;
            _loc7_ = this._view.findChildByName("recyclable_number") as ITextWindow;
            _loc8_ = this._view.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc6_ != null && _loc7_ != null && _loc8_ != null)
            {
               _loc21_ = _loc4_.getRecyclableCount();
               if(_loc21_ == 0)
               {
                  _loc20_ = this._assetLibrary.getAssetByName("no_recycle_icon_png");
                  _loc19_ = _loc20_.content as BitmapData;
                  _loc7_.visible = false;
                  _loc8_.toolTipCaption = "${inventory.furni.preview.not_recyclable}";
                  _loc7_.filters = [];
               }
               else
               {
                  _loc20_ = this._assetLibrary.getAssetByName("recycle_icon_png");
                  _loc19_ = _loc20_.content as BitmapData;
                  _loc7_.visible = true;
                  _loc7_.text = String(_loc21_);
                  _loc8_.toolTipCaption = "${inventory.furni.preview.recyclable_amount}";
                  _loc7_.filters = [new GlowFilter(16777215,1,3,3,300)];
               }
               _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               if(_loc19_ != null)
               {
                  _loc6_.bitmap.copyPixels(_loc19_,_loc19_.rect,new Point(0,0),null,null,true);
               }
               _loc6_.invalidate();
            }
         }
         else
         {
            this.setPreviewImage(null);
            _loc6_ = this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow;
            _loc7_ = this._view.findChildByName("tradeable_number") as ITextWindow;
            _loc8_ = this._view.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc6_ && _loc7_ && _loc8_)
            {
               _loc6_.bitmap = null;
               _loc7_.visible = false;
            }
            _loc6_ = this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow;
            _loc7_ = this._view.findChildByName("recyclable_number") as ITextWindow;
            _loc8_ = this._view.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc6_ && _loc7_ && _loc8_)
            {
               _loc6_.bitmap = null;
               _loc7_.visible = false;
            }
         }
         var _loc12_:Boolean = this.var_78.isTradingOpen;
         _loc11_ = this._view.findChildByName("placeinroom_btn") as IButtonWindow;
         if(_loc11_)
         {
            if(_loc1_ && this.var_78.isPrivateRoom)
            {
               _loc11_.enable();
            }
            else
            {
               _loc11_.disable();
            }
            _loc11_.visible = !_loc12_;
         }
         _loc11_ = this._view.findChildByName("offertotrade_btn") as IButtonWindow;
         if(_loc11_)
         {
            if(_loc1_ && _loc4_ != null && _loc5_ != null && this.var_78.canUserOfferToTrade())
            {
               if(_loc4_.getUnlockedCount() && _loc5_.tradeable)
               {
                  _loc11_.enable();
               }
               else
               {
                  _loc11_.disable();
               }
            }
            else
            {
               _loc11_.disable();
            }
            _loc11_.visible = _loc12_;
         }
         _loc11_ = this._view.findChildByName("sell_btn") as IButtonWindow;
         if(_loc11_)
         {
            if(_loc1_ && this.var_897 && this.var_897.isEnabled && _loc5_.sellable)
            {
               _loc11_.enable();
            }
            else
            {
               _loc11_.disable();
            }
         }
         this.var_1582 = -1;
         if(_loc5_ != null)
         {
            if(_loc5_.category == FurniCategory.const_1412)
            {
               _loc24_ = _loc5_.extra;
               _loc25_ = this._soundManager.musicController.getSongInfo(_loc24_);
               if(_loc25_ != null)
               {
                  _loc9_ = _loc25_.name;
                  _loc10_ = _loc25_.creator;
               }
               else
               {
                  this._soundManager.musicController.requestSongInfoWithoutSamples(_loc24_);
                  this.var_1582 = _loc24_;
               }
            }
         }
         var _loc13_:ITextWindow = this._view.findChildByName("furni_name") as ITextWindow;
         if(_loc13_ != null)
         {
            if(_loc9_ != null)
            {
               _loc13_.text = _loc9_;
            }
            else if(_loc5_ is FloorItem)
            {
               _loc13_.text = "${roomItem.name." + _loc5_.type + "}";
            }
            else if(_loc5_ is WallItem)
            {
               _loc13_.text = "${wallItem.name." + _loc5_.type + "}";
            }
            else
            {
               _loc13_.text = "";
            }
            _loc13_.height = _loc13_.textHeight;
         }
         var _loc14_:ITextWindow = this._view.findChildByName("furni_description") as ITextWindow;
         if(_loc14_ != null)
         {
            if(_loc10_ != null)
            {
               _loc14_.text = _loc10_;
            }
            else if(_loc5_ is FloorItem)
            {
               _loc14_.text = "${roomItem.desc." + _loc5_.type + "}";
            }
            else if(_loc5_ is WallItem)
            {
               _loc14_.text = "${wallItem.desc." + _loc5_.type + "}";
            }
            else
            {
               _loc14_.text = "";
            }
            _loc14_.height = _loc14_.textHeight + 5;
         }
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc3_:IItem = param1.method_1();
         if(_loc3_ is FloorItem)
         {
            _loc2_ = this._roomEngine.getFurnitureImage(param1.type,new Vector3d(2,0,0),64,this,0,String(param1.extra));
         }
         else
         {
            _loc2_ = this._roomEngine.getWallItemImage(param1.type,new Vector3d(2,0,0),64,this,0,param1.stuffData);
         }
         if(_loc2_ != null)
         {
            this.setPreviewImage(_loc2_.data);
         }
         _loc4_ = this._view.findChildByName("placeinroom_btn") as IButtonWindow;
         if(_loc4_)
         {
            _loc4_.disable();
         }
         _loc4_ = this._view.findChildByName("offertotrade_btn") as IButtonWindow;
         if(_loc4_)
         {
            _loc4_.disable();
         }
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = this._view.findChildByName("furni_preview_image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(20,20);
         }
         var _loc3_:int = param1.height;
         if(_loc3_ > const_1093)
         {
            _loc3_ = const_1093;
         }
         else if(_loc3_ < const_1095)
         {
            _loc3_ = const_1095;
         }
         else
         {
            _loc3_ = Math.ceil(_loc3_ / 10) * 10;
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc3_,true,16777215);
         _loc2_.height = _loc3_;
         var _loc4_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc3_ - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
         _loc2_.invalidate();
         var _loc5_:ITextWindow = this._view.findChildByName("furni_description") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.y = _loc2_.y + _loc2_.height + 5;
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:GroupItem = this.var_78.getGroupItemInIndex(this.var_78.getSelectedItemIndex());
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.previewCallbackId == param1)
         {
            this.setPreviewImage(param2);
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "placeinroom_btn":
                  this.var_78.requestSelectedFurniPlacement(false);
                  break;
               case "offertotrade_btn":
                  this.var_78.requestSelectedFurniToTrading();
                  break;
               case "sell_btn":
                  this.var_78.requestSelectedFurniSelling();
                  break;
               case "open_catalog_btn":
                  this.var_78.requestCatalogOpen();
                  break;
               default:
                  this.var_78.cancelFurniInMover();
            }
         }
         else if(param1.type == WindowEvent.const_47)
         {
            switch(param2.name)
            {
               case "tab_floor":
                  this.switchCategory(FurniModelCategory.const_38);
                  break;
               case "tab_wall":
                  this.switchCategory(FurniModelCategory.const_44);
                  break;
               case "tab_pets":
                  this.switchCategory(FurniModelCategory.const_256);
            }
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(param1.id == this.var_1582)
         {
            this.updateActionView();
            this.var_1582 = -1;
         }
      }
   }
}
