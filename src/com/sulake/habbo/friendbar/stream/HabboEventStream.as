package com.sulake.habbo.friendbar.stream
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.GetEventStreamComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.LikeStreamEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.SetEventStreamingAllowedComposer;
   import com.sulake.habbo.friendbar.HabboFriendBar;
   import com.sulake.habbo.friendbar.utils.LinkTarget;
   import com.sulake.habbo.friendbar.utils.TestMessageWrapper;
   import com.sulake.habbo.friendbar.view.*;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendBarView;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboEventStream extends AbstractView implements IHabboEventStream
   {
      
      private static const const_1623:String = "page_content";
      
      private static const const_1115:String = "page_welcome";
      
      private static const const_1114:String = "page_empty";
      
      private static const const_705:String = "list";
      
      private static const const_466:String = "header";
      
      private static const const_1372:String = "badge";
      
      private static const CLOSE:String = "close";
      
      private static const const_1619:String = "scroll";
      
      private static const const_1112:String = "image";
      
      private static const const_1116:String = "disable_stream";
      
      private static const ACTIVATE:String = "activate_stream";
      
      private static const const_1113:String = "see_more";
      
      private static const const_1620:uint = 0;
      
      private static const const_2128:uint = 1;
      
      private static const const_711:int = -2;
      
      private static const const_1622:int = -3;
      
      private static const const_1111:int = 42;
      
      private static const const_1621:int = 60000;
      
      private static const const_1618:int = 60000;
      
      private static const GENDER_LOCALIZATION_PREFIX:String = "friendbar.stream.";
       
      
      private var _window:IWindowContainer;
      
      private var var_578:Vector.<EventStreamEntity>;
      
      private var _connection:IConnection;
      
      private var var_783:Boolean = false;
      
      private var var_706:Timer;
      
      private var var_480:Timer;
      
      private var var_1067:IHabboFriendBarView;
      
      private var var_95:IHabboCommunicationManager;
      
      private var var_846:Boolean;
      
      private var var_1602:Vector.<int>;
      
      private var var_1600:Boolean = false;
      
      private var var_2009:Boolean = false;
      
      private var var_1599:Boolean = false;
      
      private var var_2008:int = 1;
      
      private var var_2827:Array;
      
      private var var_2828:Array;
      
      private var var_1601:Map;
      
      public function HabboEventStream(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
      {
         this.var_1602 = new Vector.<int>();
         this.var_2827 = ["friend_made","room_liked","achievement_earned","motto_changed","room_decorated"];
         this.var_2828 = ["no_link","open_mini_profile","visit_room","open_achievements","open_motto_changer","friend_request"];
         this.var_1601 = new Map();
         super(param1,param2,param3);
         this.var_578 = new Vector.<EventStreamEntity>();
         queueInterface(new IIDHabboCommunicationManager(),this.onCommunicationManagerAvailable);
         queueInterface(new IIDHabboFriendBarView(),this.onFriendBarViewAvailable);
         this.var_1601.add("m","his");
         this.var_1601.add("f","her");
         if(!this.var_480)
         {
            this.var_480 = new Timer(const_1618);
            this.var_480.addEventListener(TimerEvent.TIMER,this.onRefreshTimerEvent);
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(!this._window)
         {
            this.setupUserInterface();
         }
         this._window.visible = param1;
         if(param1)
         {
            this._window.x = this._window.desktop.width - (this._window.width + const_1622);
            this._window.y = const_711;
            this._window.height = this._window.desktop.height - (const_711 + const_1111);
            this._window.activate();
            if(this.var_846)
            {
               this.requestEventStreamData(this.var_2008);
            }
         }
      }
      
      public function get visible() : Boolean
      {
         return !!this._window ? Boolean(this._window.visible) : false;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(this.var_706)
            {
               this.var_706.stop();
               this.var_706.removeEventListener(TimerEvent.TIMER,this.onMinuteTimerEvent);
               this.var_706 = null;
            }
            if(this.var_480)
            {
               this.var_480.stop();
               this.var_480.removeEventListener(TimerEvent.TIMER,this.onRefreshTimerEvent);
               this.var_480 = null;
            }
            while(this.var_578.length > 0)
            {
               this.var_578.pop().dispose();
            }
            if(false)
            {
               EventStreamEntity.name_6.dispose();
            }
            EventStreamEntity.name_6 = null;
            EventStreamEntity.var_2260 = null;
            EventStreamEntity.ASSETS = null;
            EventStreamEntity.var_1428 = null;
            if(this._window)
            {
               this._window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
               this._window.dispose();
               this._window = null;
            }
            if(this.var_95)
            {
               if(!this.var_95.disposed)
               {
                  this.var_95.release(new IIDHabboCommunicationManager());
                  this.var_95 = null;
               }
            }
            if(this.var_1067)
            {
               if(!this.var_1067.disposed)
               {
                  this.var_1067.release(new IIDHabboFriendBarView());
                  this.var_1067 = null;
               }
            }
            super.dispose();
         }
      }
      
      private function clearStreamList() : void
      {
         while(this.var_578.length > 0)
         {
            this.var_578.pop().recycle();
         }
      }
      
      public function populate(param1:Vector.<EventStreamData>) : void
      {
         var _loc2_:* = false;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(!this._window)
         {
            this.setupUserInterface();
         }
         if(this.visible)
         {
            this.clearStreamList();
            _loc2_ = this.var_578.length % 2 == 0;
            _loc4_ = this._window.findChildByName(const_705) as IItemListWindow;
            _loc5_ = 0;
            for each(_loc6_ in param1)
            {
               _loc3_ = EventStreamEntity.allocate();
               _loc3_.id = _loc6_.id;
               _loc3_.title = _loc6_.accountName;
               _loc3_.message = this.resolveMessageText(_loc6_);
               _loc3_.linkTarget = this.resolveLinkTarget(_loc6_);
               _loc3_.numberOfLikes = _loc6_.numberOfLikes;
               _loc3_.isLikingEnabled = this.var_1599;
               _loc3_.isLikable = _loc6_.isLikable && this.var_1599;
               _loc3_.minutesElapsed = _loc6_.minutesSinceEvent;
               _loc3_.even = _loc2_;
               this.resolveImagePath(_loc3_,_loc6_);
               this.var_578.push(_loc3_);
               _loc4_.addListItem(_loc3_.window);
               _loc2_ = !_loc2_;
               if(this.var_1602.indexOf(_loc6_.id) == -1)
               {
                  _loc5_++;
                  this.var_1602.push(_loc6_.id);
               }
            }
            if(param1.length == 0)
            {
            }
            _loc7_ = this._window.findChildByName(const_466) as IItemListWindow;
            _loc8_ = _loc7_.getListItemByName(const_1372);
            _loc8_.visible = false;
            this.var_1600 = false;
         }
         else
         {
            for each(_loc9_ in param1)
            {
               if(this.var_1602.indexOf(_loc9_.id) == -1)
               {
                  this.var_1600 = true;
                  break;
               }
            }
         }
         this.selectCorrectView();
      }
      
      private function resolveMessageText(param1:EventStreamData) : String
      {
         var _loc6_:* = null;
         var _loc2_:int = param1.actionId;
         var _loc3_:String = "friendbar.stream.type." + this.var_2827[_loc2_];
         var _loc4_:ILocalization = var_432.getLocalization(_loc3_);
         if(!_loc4_)
         {
            return _loc3_;
         }
         var _loc5_:String = _loc4_.raw;
         switch(_loc2_)
         {
            case EventStreamData.const_1017:
               _loc5_ = _loc5_.replace("%targetString%",param1.extraDataStruct.friendName);
               break;
            case EventStreamData.const_1380:
               _loc5_ = _loc5_.replace("%targetString%",param1.extraDataStruct.roomName);
               break;
            case EventStreamData.const_1001:
               _loc5_ = _loc5_.replace("%targetString%",var_432.getAchievementName(param1.extraDataStruct.achievementCode));
               break;
            case EventStreamData.const_1329:
               _loc6_ = var_432.getLocalization(GENDER_LOCALIZATION_PREFIX + this.var_1601.getValue(param1.accountGender));
               _loc5_ = _loc5_.replace("%gender%",_loc6_.value);
               _loc5_ = _loc5_.replace("%targetString%",param1.extraDataStruct.motto);
               break;
            case EventStreamData.const_1882:
         }
         return _loc5_;
      }
      
      private function resolveLinkTarget(param1:EventStreamData) : LinkTarget
      {
         var _loc3_:* = null;
         var _loc2_:String = "friendbar.stream.link." + this.var_2828[param1.linkTargetType];
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:ILocalization = var_432.getLocalization(_loc2_);
         _loc3_ = !!_loc7_ ? _loc7_.raw : "";
         switch(param1.linkTargetType)
         {
            case EventStreamData.const_2050:
               _loc4_ = 0;
               _loc3_ = "";
               break;
            case EventStreamData.const_1409:
               _loc3_ = _loc3_.replace("%targetString%",param1.extraDataStruct.friendName);
               _loc4_ = 0;
               _loc5_ = uint(param1.extraDataStruct.friendId);
               break;
            case EventStreamData.const_1779:
               _loc4_ = 0;
               _loc5_ = uint(param1.extraDataStruct.roomId);
               break;
            case EventStreamData.const_1817:
               _loc4_ = 0;
               break;
            case EventStreamData.LINK_TARGET_OPEN_MOTTO_CHANGER:
               _loc4_ = 0;
               _loc5_ = 0;
               break;
            case EventStreamData.const_1849:
               _loc3_ = _loc3_.replace("%targetString%",param1.extraDataStruct.friendName);
               _loc4_ = 0;
               _loc5_ = uint(param1.extraDataStruct.friendId);
               _loc6_ = param1.extraDataStruct.friendName;
         }
         return new LinkTarget(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      private function resolveImagePath(param1:EventStreamEntity, param2:EventStreamData) : void
      {
         var image:BitmapData = null;
         var callback:Function = null;
         var entity:EventStreamEntity = param1;
         var data:EventStreamData = param2;
         var result:String = data.imageFilePath;
         var action:int = data.actionId;
         switch(action)
         {
            case EventStreamData.const_1001:
               image = var_414.requestBadgeImage(data.extraDataStruct.achievementCode);
               if(image)
               {
                  entity.image = image;
               }
               else
               {
                  callback = function(param1:BadgeImageReadyEvent):void
                  {
                     if(param1.badgeId == data.extraDataStruct.achievementCode)
                     {
                        entity.image = param1.badgeImage;
                        var_414.events.removeEventListener(BadgeImageReadyEvent.const_136,arguments.callee);
                     }
                  };
                  var_414.events.addEventListener(BadgeImageReadyEvent.const_136,callback);
               }
               break;
            default:
               entity.imageFilePath = result;
         }
      }
      
      private function setupUserInterface() : void
      {
         var scroll:IScrollbarWindow = null;
         var page:IWindowContainer = null;
         var image:IBitmapWrapperWindow = null;
         var list:IItemListWindow = null;
         var item:IWindowContainer = null;
         var icon:IBitmapWrapperWindow = null;
         if(!this._window)
         {
            this._window = _windowManager.buildFromXML(assets.getAssetByName("event_stream_display_xml").content as XML) as IWindowContainer;
            this._window.height = this._window.desktop.height - (const_711 + const_1111);
            this._window.setParamFlag(WindowParam.const_324);
            this._window.setParamFlag(WindowParam.const_308);
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
            this._window.findChildByName(CLOSE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
            this._window.findChildByName(const_1116).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
            this._window.findChildByName(ACTIVATE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
            this._window.findChildByName(const_1113).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseClick);
            this._window.visible = false;
            scroll = this._window.findChildByName(const_1619) as IScrollbarWindow;
            if(scroll)
            {
               scroll.addEventListener(WindowEvent.const_225,function(param1:WindowEvent):void
               {
                  var _loc2_:IScrollbarWindow = param1.target as IScrollbarWindow;
                  if(_loc2_)
                  {
                     _loc2_.visible = true;
                     _loc2_.scrollable.width = _loc2_.scrollable.parent.width - _loc2_.width;
                  }
               });
               scroll.addEventListener(WindowEvent.const_239,function(param1:WindowEvent):void
               {
                  scroll.visible = false;
                  scroll.scrollable.width = scroll.scrollable.parent.width;
               });
               scroll.visible = false;
               scroll.scrollable.width = scroll.scrollable.parent.width;
            }
            page = this._window.findChildByName(const_1115) as IWindowContainer;
            image = page.findChildByName(const_1112) as IBitmapWrapperWindow;
            image.bitmap = assets.getAssetByName(image.bitmapAssetName).content as BitmapData;
            page = this._window.findChildByName(const_1114) as IWindowContainer;
            image = page.findChildByName(const_1112) as IBitmapWrapperWindow;
            image.bitmap = assets.getAssetByName(image.bitmapAssetName).content as BitmapData;
            this.selectCorrectView();
            list = this._window.findChildByName(const_705) as IItemListWindow;
            item = list.removeListItemAt(0) as IWindowContainer;
            icon = IWindowContainer(item.findChildByName("like")).findChildByName("icon") as IBitmapWrapperWindow;
            icon.bitmap = assets.getAssetByName("stream_thumb_png").content as BitmapData;
            icon.disposesBitmap = false;
            EventStreamEntity.var_1428 = this;
            EventStreamEntity.name_6 = item;
            EventStreamEntity.var_2260 = var_432;
            EventStreamEntity.ASSETS = assets;
            if(!this.var_706)
            {
               this.var_706 = new Timer(const_1621);
               this.var_706.addEventListener(TimerEvent.TIMER,this.onMinuteTimerEvent);
               this.var_706.start();
            }
         }
      }
      
      private function selectCorrectView() : void
      {
         var _loc1_:IWindow = this._window.findChildByName(const_1623);
         var _loc2_:IWindow = this._window.findChildByName(const_1115);
         var _loc3_:IWindow = this._window.findChildByName(const_1114);
         if(this.var_846)
         {
            _loc1_.visible = true;
            _loc2_.visible = false;
            _loc3_.visible = this.var_578.length == 0;
         }
         else
         {
            _loc1_.visible = false;
            _loc2_.visible = true;
            _loc3_.visible = false;
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case CLOSE:
               this.visible = false;
               break;
            case const_1116:
               this.changeStreamState(false);
               break;
            case ACTIVATE:
               this.changeStreamState(true);
               break;
            case const_1113:
               _windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,null);
               HabboWebTools.openWebPage(var_615.getKey("link.friendbar.stream.settings.see.more",""));
         }
      }
      
      private function changeStreamState(param1:Boolean) : void
      {
         this.var_846 = param1;
         this.sendSetEventStreamingEnabled(param1);
         this.selectCorrectView();
         if(param1)
         {
            this.var_480.start();
            this.refreshEventStream();
         }
         else
         {
            this.var_480.stop();
         }
         Logger.log("Streaming enabled: " + param1);
      }
      
      private function onMinuteTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in this.var_578)
         {
            _loc2_.minutesElapsed += 1;
         }
      }
      
      private function onRefreshTimerEvent(param1:TimerEvent) : void
      {
         if(this.visible || !this.var_1600)
         {
            this.requestEventStreamData(this.var_2008);
         }
      }
      
      private function requestEventStreamData(param1:uint) : void
      {
         if(this._connection && this._connection.connected && this.var_2009)
         {
            this._connection.send(new GetEventStreamComposer(param1 == const_1620 ? 0 : int(GetEventStreamComposer.const_1979)));
            this.var_783 = true;
            Logger.log("Requested stream events in mode " + param1);
         }
      }
      
      private function onCommunicationManagerAvailable(param1:IID, param2:IUnknown) : void
      {
         this.var_95 = param2 as IHabboCommunicationManager;
         this.var_95.addHabboConnectionMessageEvent(new EventStreamEvent(this.onEventStreamEvent));
         this.var_95.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObjectEvent));
         this._connection = this.var_95.getHabboMainConnection(this.onConnectionInstanceAvailable);
      }
      
      private function onConnectionInstanceAvailable(param1:IConnection) : void
      {
         this._connection = param1;
      }
      
      private function onEventStreamEvent(param1:EventStreamEvent) : void
      {
         this.populate(param1.events);
         this.var_1067.setStreamIconNotify(!this.visible && this.var_1600);
      }
      
      private function testEventStream(param1:int = 1) : void
      {
         var _loc2_:Vector.<EventStreamData> = new Vector.<EventStreamData>();
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_.push(new EventStreamData(_loc3_,EventStreamData.const_1017,String(_loc3_ * 1000),"FooBar" + _loc3_,"m","http://d63.varoke.net/habbo-imaging/badge/b1003Xs05175s05173s091145ec244dcc5eaf54aaabf367665f39c67.gif",_loc3_,EventStreamData.const_1409,3,true,new TestMessageWrapper(["1234","Friend\'s friend" + _loc3_])));
            _loc3_++;
         }
         this.populate(_loc2_);
      }
      
      private function onFriendBarViewAvailable(param1:IID, param2:IUnknown) : void
      {
         this.var_1067 = param2 as IHabboFriendBarView;
      }
      
      override protected function onConfigurationAvailable(param1:IID, param2:IUnknown) : void
      {
         super.onConfigurationAvailable(param1,param2);
         this.var_2009 = var_615.getBoolean("friendbar.stream.enabled",false);
         this.var_1599 = var_615.getBoolean("friendbar.stream.liking.enabled",false);
      }
      
      private function sendSetEventStreamingEnabled(param1:Boolean) : void
      {
         if(this._connection && this._connection.connected)
         {
            this._connection.send(new SetEventStreamingAllowedComposer(param1));
         }
      }
      
      private function onUserObjectEvent(param1:UserObjectEvent) : void
      {
         this.var_846 = param1.getParser().streamPublishingAllowed;
         if(this.var_846)
         {
            this.var_480.start();
         }
         Logger.log("Stream events allowed " + this.var_846);
      }
      
      public function refreshEventStream() : void
      {
         if(this.var_846)
         {
            this.requestEventStreamData(this.var_2008);
         }
      }
      
      public function likeStreamEvent(param1:EventStreamEntity) : void
      {
         if(this._connection && this._connection.connected && this.var_2009 && this.var_1599)
         {
            param1.isLikable = false;
            ++param1.numberOfLikes;
            this._connection.send(new LikeStreamEventMessageComposer(param1.id,var_414.userId));
            Logger.log("Like event " + param1);
         }
      }
   }
}
