package com.sulake.habbo.ui.widget.roomchat
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RoomChatWidget extends RoomWidgetBase implements IUpdateReceiver
   {
      
      private static const const_121:int = 18;
      
      private static const const_1734:int = 9;
      
      private static const const_1154:int = 10;
      
      private static const const_726:int = 25;
      
      private static const const_1731:int = 25;
      
      private static const const_1153:int = 4000;
      
      private static const const_1729:int = 6000;
      
      private static const const_1733:int = 3;
      
      private static const const_1732:int = 1;
      
      private static const const_727:int = 8;
      
      private static const const_490:int = 0;
      
      private static const const_1152:int = (const_727 + const_490) * const_121 + const_121;
      
      private static const const_491:int = 9;
      
      private static const const_1730:int = 40;
       
      
      private var var_1378:int = 0;
      
      private var var_1121:int = 0;
      
      private var var_43:IWindowContainer;
      
      private var var_420:IItemListWindow;
      
      private var var_140:IWindowContainer;
      
      private var _itemList:Array;
      
      private var var_81:Array;
      
      private var var_302:Array;
      
      private var var_2999:int;
      
      private var var_2998:int = 0;
      
      private var var_903:Number = 1;
      
      private var _baseUrl:String;
      
      private var var_1122:Number = 1;
      
      private var var_2134:Number = 0;
      
      private var var_902:Point;
      
      private var var_30:RoomChatHistoryViewer;
      
      private var var_1084:Boolean = false;
      
      private var var_2133:Boolean = false;
      
      private var var_22:Component = null;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_2997:int = 150;
      
      private var var_262:int = 171.0;
      
      private var var_1120:int = 18;
      
      private var var_3130:int = 100;
      
      private var var_3129:int = 195;
      
      public function RoomChatWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:int, param7:Component)
      {
         this._itemList = new Array();
         this.var_81 = new Array();
         this.var_302 = new Array();
         this.var_902 = new Point();
         super(param1,param2,param3,param4);
         this._config = param5;
         this.var_2999 = param6;
         this.var_43 = param2.createWindow("chat_container","",HabboWindowType.const_73,HabboWindowStyle.const_30,HabboWindowParam.const_45,new Rectangle(0,0,200,this.var_262 + RoomChatHistoryPulldown.const_94),null,0) as IWindowContainer;
         this.var_43.background = true;
         this.var_43.color = 33554431;
         this.var_43.tags.push("room_widget_chat");
         this.var_420 = param2.createWindow("chat_contentlist","",HabboWindowType.const_1191,HabboWindowStyle.const_45,0 | 0,new Rectangle(0,0,200,this.var_262),null,0) as IItemListWindow;
         this.var_43.addChild(this.var_420);
         this.var_140 = param2.createWindow("chat_active_content","",HabboWindowType.const_73,HabboWindowStyle.const_45,HabboWindowParam.const_64,new Rectangle(0,0,200,this.var_262),null,0) as IWindowContainer;
         this.var_140.clipping = false;
         this.var_420.addListItem(this.var_140);
         this.var_30 = new RoomChatHistoryViewer(this,param2,this.var_43,param3);
         this._baseUrl = param5.getKey("site.url");
         this.var_2997 = int(param5.getKey("chat.history.item.max.count","150"));
         var _loc8_:Boolean = param5.getBoolean("chat.history.disabled",false);
         if(this.var_30 != null)
         {
            this.var_30.disabled = _loc8_;
         }
         if(param7 != null)
         {
            this.var_22 = param7;
            this.var_22.registerUpdateReceiver(this,1);
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         return this.var_43;
      }
      
      public function get config() : IHabboConfigurationManager
      {
         return this._config;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(disposed)
         {
            return;
         }
         while(this.var_302.length > 0)
         {
            _loc1_ = this.var_302.shift();
         }
         this.var_30.dispose();
         this.var_30 = null;
         while(this._itemList.length > 0)
         {
            _loc1_ = this._itemList.shift();
            _loc1_.dispose();
         }
         while(this.var_81.length > 0)
         {
            _loc1_ = this.var_81.shift();
            _loc1_.dispose();
         }
         this.var_43.dispose();
         if(this.var_22 != null)
         {
            this.var_22.removeUpdateReceiver(this);
            this.var_22 = null;
         }
         super.dispose();
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(getTimer() > this.var_1378 && this.var_1378 > 0)
         {
            this.var_1378 = -1;
            this.animationStart();
         }
         if(this.var_1084)
         {
            _loc2_ = param1 / const_1731 * const_1733;
            if(_loc2_ + this.var_1121 > this.var_1120)
            {
               _loc2_ = this.var_1120 - this.var_1121;
            }
            if(_loc2_ > 0)
            {
               this.moveItemsUp(_loc2_);
               this.var_1121 += _loc2_;
            }
            if(this.var_1121 >= this.var_1120)
            {
               this.var_1120 = const_121;
               this.var_1121 = 0;
               this.animationStop();
               this.processBuffer();
               this.var_1378 = getTimer() + const_1153;
            }
         }
         if(this.var_30 != null)
         {
            this.var_30.update(param1);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetChatUpdateEvent.const_743,this.onChatMessage);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_543,this.onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_966,this.onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_911,this.onRoomViewUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetChatUpdateEvent.const_743,this.onChatMessage);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_543,this.onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_966,this.onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_911,this.onRoomViewUpdate);
      }
      
      private function onChatMessage(param1:RoomWidgetChatUpdateEvent) : void
      {
         var _loc2_:RoomChatItem = new RoomChatItem(this,windowManager,assets,this.getFreeItemId(),localizations,this._baseUrl);
         _loc2_.define(param1);
         if(this.var_1122 != 1)
         {
            _loc2_.senderX /= this.var_1122;
         }
         _loc2_.senderX -= this.var_902.x;
         this.setChatItemLocHorizontal(_loc2_);
         this.var_81.push(_loc2_);
         this.processBuffer();
      }
      
      private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent) : void
      {
         var _loc2_:Rectangle = param1.rect;
         if(param1.scale > 0)
         {
            if(this.var_2134 == 0)
            {
               this.var_2134 = param1.scale;
            }
            else
            {
               this.var_1122 = param1.scale / this.var_2134;
            }
         }
         if(param1.positionDelta != null)
         {
            this.var_902.x += param1.positionDelta.x / this.var_1122;
            this.var_902.y += param1.positionDelta.y / this.var_1122;
         }
         if(param1.rect != null)
         {
            if(this.var_30 == null)
            {
               return;
            }
            this.var_43.width = _loc2_.width;
            this.var_43.height = this.var_262 + this.var_30.pulldownBarHeight;
            this.var_420.width = this.var_43.width - this.var_30.scrollbarWidth;
            this.var_420.height = this.var_262;
            this.var_420.x = this.var_43.x;
            this.var_420.y = this.var_43.y;
            this.var_140.width = this.var_43.width - this.var_30.scrollbarWidth;
            this.var_140.height = this.var_262;
            if(this.historyViewerActive())
            {
               this.reAlignItemsToHistoryContent();
            }
            this.var_30.containerResized(this.var_43.rectangle,true);
         }
         this.alignItems();
      }
      
      private function processBuffer() : void
      {
         if(this.var_1084)
         {
            return;
         }
         if(this.var_81.length == 0)
         {
            return;
         }
         while(this.var_81.length > const_1732 || this.historyViewerActive() && this.var_81.length > 0)
         {
            this.activateItemFromBuffer();
         }
         var _loc1_:Boolean = false;
         if(this._itemList.length == 0)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = this.checkLastItemAllowsAdding(this.var_81[0]);
         }
         if(_loc1_)
         {
            this.activateItemFromBuffer();
            this.var_1378 = getTimer() + const_1153;
         }
         else
         {
            if(this._itemList.length > 0 && this.var_81.length > 0)
            {
               this.var_1120 = this.getItemSpacing(this._itemList[this._itemList.length - 1],this.var_81[0]);
            }
            else
            {
               this.var_1120 = const_121;
            }
            this.animationStart();
         }
      }
      
      private function activateItemFromBuffer() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(this.var_81.length == 0)
         {
            return;
         }
         if(this.historyViewerMinimized())
         {
            this.resetArea();
            this.hideHistoryViewer();
         }
         if(!this.checkLastItemAllowsAdding(this.var_81[0]))
         {
            this.selectItemsToMove();
            this.moveItemsUp(this.getItemSpacing(this._itemList[this._itemList.length - 1],this.var_81[0]));
            if(!this.checkLastItemAllowsAdding(this.var_81[0]))
            {
               this.var_140.height += const_121;
               if(this.var_30 != null)
               {
                  this.var_30.containerResized(this.var_43.rectangle);
               }
            }
         }
         _loc1_ = this.var_81.shift();
         if(_loc1_ != null)
         {
            _loc1_.renderView();
            _loc2_ = _loc1_.view;
            if(_loc2_ != null)
            {
               this.var_140.addChild(_loc2_);
               _loc1_.timeStamp = new Date().time;
               this._itemList.push(_loc1_);
               _loc3_ = 0;
               if(this._itemList.length > 1)
               {
                  _loc3_ = this._itemList[this._itemList.length - 2].screenLevel;
                  if(this.historyViewerActive())
                  {
                     _loc1_.screenLevel = _loc3_ + 1;
                  }
                  else
                  {
                     _loc1_.screenLevel = _loc3_ + Math.max(this.var_903,1);
                  }
               }
               else
               {
                  _loc1_.screenLevel = 100;
               }
               _loc1_.aboveLevels = this.var_903;
               if(_loc1_.aboveLevels > const_727 + const_490 + 2)
               {
                  _loc1_.aboveLevels = const_727 + const_490 + 2;
               }
               this.var_903 = 0;
               this.setChatItemLocHorizontal(_loc1_);
               this.setChatItemLocVertical(_loc1_);
               this.setChatItemRenderable(_loc1_);
            }
         }
      }
      
      private function checkLastItemAllowsAdding(param1:RoomChatItem) : Boolean
      {
         if(this._itemList.length == 0)
         {
            return true;
         }
         var _loc2_:RoomChatItem = this._itemList[this._itemList.length - 1];
         if(param1 == null || _loc2_ == null)
         {
            return false;
         }
         if(_loc2_.view == null)
         {
            return true;
         }
         if(this.var_140.rectangle.bottom - (this.var_140.y + _loc2_.y + _loc2_.height) <= this.getItemSpacing(_loc2_,param1))
         {
            return false;
         }
         return true;
      }
      
      private function alignItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(this.var_30 == null)
         {
            return;
         }
         _loc1_ = this._itemList.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._itemList[_loc1_];
            if(_loc2_ != null)
            {
               this.setChatItemLocHorizontal(_loc2_);
               this.setChatItemLocVertical(_loc2_);
            }
            _loc1_--;
         }
         _loc1_ = 0;
         while(_loc1_ < this._itemList.length)
         {
            _loc2_ = this._itemList[_loc1_];
            if(_loc2_ != null)
            {
               this.setChatItemRenderable(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.var_81.length)
         {
            _loc2_ = this.var_81[_loc1_];
            if(_loc2_ != null)
            {
               this.setChatItemLocHorizontal(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function animationStart() : void
      {
         if(this.var_1084)
         {
            return;
         }
         this.selectItemsToMove();
         this.var_1084 = true;
      }
      
      private function animationStop() : void
      {
         this.var_1084 = false;
      }
      
      private function selectItemsToMove() : void
      {
         var _loc4_:* = null;
         if(this.var_1084)
         {
            return;
         }
         this.purgeItems();
         this.var_302 = new Array();
         var _loc1_:int = new Date().time;
         var _loc2_:int = 0;
         if(this._itemList.length == 0)
         {
            this.var_903 = 1;
            return;
         }
         if(this.historyViewerActive())
         {
            return;
         }
         ++this.var_903;
         var _loc3_:int = this._itemList.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = this._itemList[_loc3_];
            if(_loc4_.view != null)
            {
               if(_loc4_.screenLevel > const_490 || _loc4_.screenLevel == _loc2_ - 1 || _loc1_ - _loc4_.timeStamp >= const_1729)
               {
                  _loc4_.timeStamp = _loc1_;
                  _loc2_ = _loc4_.screenLevel;
                  --_loc4_.screenLevel;
                  this.var_302.push(_loc4_);
               }
            }
            _loc3_--;
         }
      }
      
      private function moveItemsUp(param1:int) : void
      {
         var _loc3_:Boolean = false;
         if(this.var_302 == null)
         {
            return;
         }
         if(this.var_302.length == 0)
         {
            return;
         }
         var _loc2_:* = null;
         var _loc4_:int = -1;
         var _loc5_:int = this.var_302.length - 1;
         while(_loc5_ >= 0)
         {
            _loc2_ = this.var_302[_loc5_];
            if(_loc2_ != null)
            {
               if(_loc4_ == -1)
               {
                  _loc4_ = this._itemList.indexOf(_loc2_);
               }
               else
               {
                  _loc4_++;
               }
               _loc3_ = true;
               if(this.historyViewerActive())
               {
                  if(_loc2_.y - param1 + _loc2_.height < 0)
                  {
                     _loc3_ = false;
                  }
               }
               if(_loc4_ > 0)
               {
                  if(this._itemList[_loc4_ - 1].view != null)
                  {
                     if(_loc2_.y - param1 - this._itemList[_loc4_ - 1].y < this.getItemSpacing(this._itemList[_loc4_ - 1],_loc2_))
                     {
                        _loc3_ = false;
                     }
                  }
               }
               if(_loc3_)
               {
                  _loc2_.y -= param1;
               }
            }
            _loc5_--;
         }
      }
      
      private function setChatItemLocHorizontal(param1:RoomChatItem) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 == null || this.var_30 == null)
         {
            return;
         }
         var _loc2_:Number = (param1.senderX + this.var_902.x) * this.var_1122;
         var _loc3_:Number = _loc2_ - param1.width / 2;
         var _loc4_:Number = _loc3_ + param1.width;
         var _loc5_:Number = -this.var_43.width / 2 - const_1154 + this.var_3130;
         var _loc6_:Number = this.var_43.width / 2 + const_1154 - this.var_30.scrollbarWidth - this.var_3129;
         var _loc7_:Boolean = _loc3_ >= _loc5_ && _loc3_ <= _loc6_;
         var _loc8_:Boolean = _loc4_ >= _loc5_ && _loc4_ <= _loc6_;
         if(_loc7_ && _loc8_)
         {
            _loc9_ = _loc3_;
            _loc10_ = _loc9_;
         }
         else if(_loc2_ >= 0)
         {
            _loc9_ = _loc6_ - param1.width;
         }
         else
         {
            _loc9_ = _loc5_;
         }
         param1.x = _loc9_ + this.var_43.width / 2 + this.var_43.x;
         if(_loc2_ < _loc5_ || _loc2_ > _loc6_)
         {
            param1.hidePointer();
         }
         else
         {
            param1.setPointerOffset(_loc3_ - _loc9_);
         }
      }
      
      private function setChatItemLocVertical(param1:RoomChatItem) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 != null)
         {
            _loc2_ = this._itemList.indexOf(param1);
            _loc3_ = !!this.historyViewerActive() ? 0 : Number(this.var_903);
            if(_loc2_ == this._itemList.length - 1)
            {
               param1.y = this.getAreaBottom() - (_loc3_ + 1) * const_121 - const_491;
            }
            else
            {
               _loc4_ = this._itemList[_loc2_ + 1].aboveLevels;
               if(_loc4_ < 2)
               {
                  param1.y = this._itemList[_loc2_ + 1].y - this.getItemSpacing(param1,this._itemList[_loc2_ + 1]);
               }
               else
               {
                  param1.y = this._itemList[_loc2_ + 1].y - _loc4_ * const_121;
               }
            }
         }
      }
      
      private function setChatItemRenderable(param1:RoomChatItem) : void
      {
         if(param1 != null)
         {
            if(param1.y < -const_726)
            {
               if(param1.view != null)
               {
                  this.var_140.removeChild(param1.view);
                  param1.hideView();
               }
            }
            else if(param1.view == null)
            {
               param1.renderView();
               if(param1.view != null)
               {
                  this.var_140.addChild(param1.view);
               }
            }
         }
      }
      
      public function getTotalContentHeight() : int
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._itemList.length)
         {
            _loc1_ = this._itemList[_loc3_];
            if(_loc1_ != null)
            {
               if(_loc3_ == 0)
               {
                  _loc2_ += const_121;
               }
               else
               {
                  _loc2_ += this.getItemSpacing(this._itemList[_loc3_ - 1],_loc1_);
               }
               _loc2_ += (_loc1_.aboveLevels - 1) * const_121;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getAreaBottom() : Number
      {
         if(this.historyViewerActive())
         {
            return this.var_140.height;
         }
         return this.var_262 + this.var_43.y;
      }
      
      private function getItemSpacing(param1:RoomChatItem, param2:RoomChatItem) : Number
      {
         if(param1.checkOverlap(param2.x,param1.y,param2.width,param2.height))
         {
            return const_121;
         }
         return const_1734;
      }
      
      private function purgeItems() : void
      {
         var _loc2_:* = null;
         if(this.historyViewerActive())
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         while(this._itemList.length > this.var_2997)
         {
            _loc2_ = this._itemList.shift();
            _loc3_ = this.var_302.indexOf(_loc2_);
            if(_loc3_ > -1)
            {
               this.var_302.splice(_loc3_,1);
            }
            if(_loc2_.view != null)
            {
               this.var_140.removeChild(_loc2_.view);
               _loc2_.hideView();
            }
            _loc2_.dispose();
            _loc2_ = null;
         }
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         for(; _loc1_ < this._itemList.length; _loc1_++)
         {
            _loc2_ = this._itemList[_loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.y > -const_726)
               {
                  _loc4_ = true;
               }
               _loc2_.aboveLevels = 1;
               if(_loc2_.view != null)
               {
                  _loc3_ = this.var_302.indexOf(_loc2_);
                  if(_loc3_ > -1)
                  {
                     this.var_302.splice(_loc3_,1);
                  }
                  this.var_140.removeChild(_loc2_.view);
                  _loc2_.hideView();
               }
               continue;
               break;
            }
         }
         if(this.var_81.length > 0)
         {
            _loc4_ = true;
         }
         if(this.getTotalContentHeight() > const_121 && !_loc4_ && !this.historyViewerActive())
         {
            if(this.var_30 != null)
            {
               this.stretchAreaBottomTo(this.var_43.y);
               this.alignItems();
               if(!this.historyViewerActive())
               {
                  this.var_30.showHistoryViewer();
               }
               if(!this.historyViewerVisible())
               {
                  this.var_30.visible = true;
               }
            }
         }
         else if(this.historyViewerVisible())
         {
            this.var_30.visible = false;
         }
      }
      
      private function getFreeItemId() : String
      {
         return "chat_" + this.var_2999.toString() + "_item_" + (this.var_2998++).toString();
      }
      
      public function onItemMouseClick(param1:int, param2:String, param3:int, param4:int, param5:int, param6:WindowMouseEvent) : void
      {
         if(param6.shiftKey)
         {
            if(this.var_30 != null)
            {
               this.var_30.toggleHistoryViewer();
            }
            return;
         }
         var _loc7_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_668,param1,param3);
         messageListener.processWidgetMessage(_loc7_);
         var _loc8_:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.const_902,param1,param2,param4,param5);
         messageListener.processWidgetMessage(_loc8_);
      }
      
      public function onItemMouseDown(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
         if(this.historyViewerVisible())
         {
            return;
         }
         if(this.var_30 != null)
         {
            this.var_30.beginDrag(param5.stageY);
         }
      }
      
      public function onItemMouseOver(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      public function onItemMouseOut(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      public function onPulldownMouseDown(param1:WindowMouseEvent) : void
      {
         if(this.var_30 != null)
         {
            this.var_30.beginDrag(param1.stageY,true);
         }
      }
      
      public function onPulldownCloseButtonClicked(param1:WindowMouseEvent) : void
      {
         if(this.var_30 != null)
         {
            this.var_30.hideHistoryViewer();
         }
      }
      
      public function stretchAreaBottomBy(param1:Number) : void
      {
         var _loc2_:Number = this.var_43.rectangle.bottom + param1 - 0;
         this.stretchAreaBottomTo(_loc2_);
      }
      
      public function stretchAreaBottomTo(param1:Number) : void
      {
         var _loc2_:int = this.var_43.context.getDesktopWindow().height - 0 - const_1730;
         param1 = Math.min(param1,_loc2_);
         this.var_262 = param1 - this.var_43.y;
         this.var_43.height = this.var_262 + RoomChatHistoryPulldown.const_94;
         if(this.var_30 != null)
         {
            this.var_30.containerResized(this.var_43.rectangle);
         }
      }
      
      public function resetArea() : void
      {
         if(this.var_30 == null)
         {
            return;
         }
         this.animationStop();
         this.var_262 = const_1152 + const_491;
         this.var_43.height = this.var_262 + this.var_30.pulldownBarHeight;
         this.var_420.width = this.var_43.width - this.var_30.scrollbarWidth;
         this.var_420.height = this.var_262;
         this.var_140.width = this.var_43.width - this.var_30.scrollbarWidth;
         if(this.historyViewerActive())
         {
            this.var_140.height = this.getTotalContentHeight() + const_491;
         }
         else
         {
            this.var_140.height = this.var_262;
         }
         this.var_420.scrollV = 1;
         if(!this.historyViewerActive())
         {
            this.var_30.containerResized(this.var_43.rectangle);
         }
         this.purgeItems();
         this.alignItems();
      }
      
      private function historyViewerActive() : Boolean
      {
         return this.var_30 == null ? false : Boolean(this.var_30.active);
      }
      
      private function historyViewerVisible() : Boolean
      {
         return this.var_30 == null ? false : Boolean(this.var_30.visible);
      }
      
      public function hideHistoryViewer() : void
      {
         if(this.var_30 != null)
         {
            this.var_30.hideHistoryViewer();
         }
      }
      
      private function historyViewerMinimized() : Boolean
      {
         return this.var_420.height <= 1;
      }
      
      public function resizeContainerToLowestItem() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._itemList.length)
         {
            _loc4_ = this._itemList[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.var_81.length)
         {
            _loc4_ = this.var_81[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc1_ += const_726;
         _loc1_ = _loc1_ < 0 ? 0 : int(_loc1_);
         var _loc3_:int = this.var_43.rectangle.bottom;
         this.stretchAreaBottomTo(this.var_43.rectangle.top + _loc1_);
         _loc3_ -= this.var_43.rectangle.bottom;
         if(Math.abs(_loc3_) < RoomChatHistoryViewer.const_1248)
         {
            this.resetArea();
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this._itemList.length)
         {
            _loc4_ = this._itemList[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.var_81.length)
         {
            _loc4_ = this.var_81[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         this.var_2133 = true;
      }
      
      public function mouseUp() : void
      {
         var _loc1_:Number = this.var_43.rectangle.bottom - 0;
         if(_loc1_ < const_1152)
         {
            if(_loc1_ <= this.var_262 + this.var_43.y)
            {
               if(this.historyViewerActive())
               {
                  this.hideHistoryViewer();
               }
               this.resetArea();
               return;
            }
         }
         if(this.var_2133 && !this.historyViewerActive())
         {
            this.resetArea();
            this.var_2133 = false;
         }
      }
      
      public function reAlignItemsToHistoryContent() : void
      {
         if(this.historyViewerActive())
         {
            this.var_140.height = this.getTotalContentHeight() + const_491;
            this.alignItems();
         }
      }
      
      public function enableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < this._itemList.length)
         {
            _loc1_ = this._itemList[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.var_81.length)
         {
            _loc1_ = this.var_81[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
      }
      
      public function disableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < this._itemList.length)
         {
            _loc1_ = this._itemList[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.var_81.length)
         {
            _loc1_ = this.var_81[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
      }
   }
}
