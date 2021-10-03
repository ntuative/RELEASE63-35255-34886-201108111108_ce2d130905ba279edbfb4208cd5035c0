package com.sulake.habbo.session
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
   import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
   import com.sulake.habbo.session.events.UserNameUpdateEvent;
   import com.sulake.habbo.session.facebook.FaceBookSession;
   import com.sulake.habbo.session.furniture.FurnitureDataParser;
   import com.sulake.habbo.session.furniture.IFurniDataListener;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.session.product.IProductDataListener;
   import com.sulake.habbo.session.product.ProductDataParser;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.habbo.window.utils.IConfirmDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class SessionDataManager extends Component implements ISessionDataManager
   {
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_15:IRoomSessionManager;
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_727:String;
      
      private var var_1123:String;
      
      private var _realName:String;
      
      private var var_2379:int = 0;
      
      private var var_1414:int = 0;
      
      private var var_935:int = 0;
      
      private var var_3133:Array;
      
      private var var_3057:Boolean;
      
      private var var_3058:Boolean;
      
      private var var_1261:Dictionary;
      
      private var var_753:ProductDataParser;
      
      private var var_610:Map;
      
      private var _wallItems:Map;
      
      private var var_611:Map;
      
      private var var_356:FurnitureDataParser;
      
      private var var_2219:UserTagManager;
      
      private var var_1150:BadgeImageManager;
      
      private var var_2218:HabboGroupInfoManager;
      
      private var var_1149:IgnoredUsersManager;
      
      private var _configuration:IHabboConfigurationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_2217:Boolean = false;
      
      private var var_1415:Array;
      
      private var var_1148:Array;
      
      private var _clubLevel:int;
      
      private var var_2216:int;
      
      private var var_1413:FaceBookSession;
      
      public function SessionDataManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         this.var_3133 = [];
         this.var_2219 = new UserTagManager(events);
         this.var_2218 = new HabboGroupInfoManager(this,events);
         this.var_1149 = new IgnoredUsersManager(this);
         this.var_1413 = new FaceBookSession();
         this.var_1261 = new Dictionary();
         this.var_1415 = [];
         this.var_1148 = [];
         queueInterface(new IIDHabboWindowManager(),this.onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),this.onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),this.onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),this.onLocalizationReady);
         queueInterface(new IIDHabboRoomSessionManager(),this.onRoomSessionManagerReady);
      }
      
      override public function dispose() : void
      {
         if(this.var_610)
         {
            this.var_610.dispose();
            this.var_610 = null;
         }
         if(this.var_611)
         {
            this.var_611.dispose();
            this.var_611 = null;
         }
         if(this._communication)
         {
            this._communication.release(new IIDHabboCommunicationManager());
            this._communication = null;
         }
         if(this._windowManager)
         {
            this._windowManager.release(new IIDHabboWindowManager());
            this._windowManager = null;
         }
         if(this.var_15)
         {
            this.var_15.release(new IIDHabboRoomSessionManager());
            this.var_15 = null;
         }
         if(this._configuration)
         {
            this._configuration.release(new IIDHabboConfigurationManager());
            this._configuration = null;
         }
         if(this._localization)
         {
            this._localization.release(new IIDHabboLocalizationManager());
            this._localization = null;
         }
         this.var_1148 = null;
         if(this.var_356)
         {
            this.var_356.removeEventListener(FurnitureDataParser.const_129,this.onFurnitureReady);
            this.var_356.dispose();
            this.var_356 = null;
         }
         if(this.var_753)
         {
            this.var_753.removeEventListener(ProductDataParser.const_129,this.onProductsReady);
            this.var_753.dispose();
            this.var_753 = null;
         }
         if(this.var_1413)
         {
            this.var_1413.dispose();
            this.var_1413 = null;
         }
         super.dispose();
      }
      
      private function initBadgeImageManager() : void
      {
         if(this.var_1150 != null)
         {
            return;
         }
         if(this._configuration == null || this._localization == null)
         {
            return;
         }
         this.var_1150 = new BadgeImageManager(assets,events,this._configuration,this._localization);
      }
      
      private function onWindowManagerReady(param1:IID, param2:IUnknown) : void
      {
         this._windowManager = param2 as IHabboWindowManager;
      }
      
      private function onHabboCommunicationReady(param1:IID, param2:IUnknown) : void
      {
         this._communication = param2 as IHabboCommunicationManager;
         if(this._communication == null)
         {
            return;
         }
         this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
         this._communication.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
         this._communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(this.onUserChange));
         this._communication.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(this.onUserNameChange));
         this._communication.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(this.onChangeUserNameResult));
         this._communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(this.onAvailabilityStatus));
         this._communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(this.onPetRespectFailed));
         this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
         this._communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(this.onRoomReady) as IMessageEvent);
         this.var_2219.communication = this._communication;
         this.var_2218.communication = this._communication;
         this.var_1413.communication = this._communication;
         this.var_1149.registerMessageEvents();
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         var _loc3_:* = null;
         if(param2 == null)
         {
            return;
         }
         this._configuration = param2 as IHabboConfigurationManager;
         this.initBadgeImageManager();
         if(!this.var_356)
         {
            this.var_610 = new Map();
            this._wallItems = new Map();
            this.var_611 = new Map();
            this.var_356 = new FurnitureDataParser(this.var_610,this._wallItems,this.var_611,this._localization);
            this.var_356.addEventListener(FurnitureDataParser.const_129,this.onFurnitureReady);
            if(this._configuration.keyExists("furnidata.load.url"))
            {
               _loc3_ = this._configuration.getKey("furnidata.load.url");
               this.var_356.loadData(_loc3_);
            }
         }
      }
      
      private function onLocalizationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         this._localization = param2 as IHabboLocalizationManager;
         this.initBadgeImageManager();
         if(this.var_356)
         {
            this.var_356.localization = this._localization;
            this.var_356.registerFurnitureLocalizations();
         }
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_15 = param2 as IRoomSessionManager;
      }
      
      private function onFurnitureReady(param1:Event = null) : void
      {
         var _loc2_:* = null;
         this.var_356.removeEventListener(FurnitureDataParser.const_129,this.onFurnitureReady);
         for each(_loc2_ in this.var_1148)
         {
            _loc2_.furniDataReady();
         }
         this.var_1148 = [];
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:UserRightsMessageEvent = UserRightsMessageEvent(param1);
         this._clubLevel = _loc2_.clubLevel;
         this.var_2216 = _loc2_.securityLevel;
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEvent = param1 as UserObjectEvent;
         var _loc3_:UserObjectMessageParser = _loc2_.getParser();
         this._id = _loc3_.id;
         this._name = _loc3_.name;
         this.var_2379 = _loc3_.respectTotal;
         this.var_1414 = _loc3_.respectLeft;
         this.var_935 = _loc3_.petRespectLeft;
         this.var_727 = _loc3_.figure;
         this.var_1123 = _loc3_.sex;
         this._realName = _loc3_.realName;
         this.var_1149.initIgnoreList();
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            this.var_727 = _loc2_.figure;
            this.var_1123 = _loc2_.sex;
            events.dispatchEvent(new HabboSessionFigureUpdatedEvent(this._id,this.var_727,this.var_1123));
         }
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserNameChangedMessageEvent = param1 as UserNameChangedMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:UserNameChangedMessageParser = _loc2_.getParser();
         if(_loc3_.webId == this._id)
         {
            this._name = _loc3_.newName;
            events.dispatchEvent(new UserNameUpdateEvent(this._name));
         }
      }
      
      private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
         if(_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_513)
         {
            events.dispatchEvent(new UserNameUpdateEvent(_loc2_.name));
         }
      }
      
      private function onAvailabilityStatus(param1:IMessageEvent) : void
      {
         var _loc2_:AvailabilityStatusMessageParser = (param1 as AvailabilityStatusMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         this.var_3057 = _loc2_.isOpen;
         this.var_3058 = _loc2_.onShutDown;
      }
      
      private function onPetRespectFailed(param1:PetRespectFailedEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this.var_935;
      }
      
      private function onAuthenticationOK(param1:IMessageEvent) : void
      {
         this.loadProductData();
      }
      
      public function get systemOpen() : Boolean
      {
         return this.var_3057;
      }
      
      public function get systemShutDown() : Boolean
      {
         return this.var_3058;
      }
      
      public function hasSecurity(param1:int) : Boolean
      {
         return this.var_2216 >= param1;
      }
      
      public function hasUserRight(param1:String, param2:int) : Boolean
      {
         return this._clubLevel >= param2;
      }
      
      public function get clubLevel() : int
      {
         return this._clubLevel;
      }
      
      public function get userId() : int
      {
         return this._id;
      }
      
      public function get userName() : String
      {
         return this._name;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return this.var_2216 >= SecurityLevelEnum.const_1301;
      }
      
      public function getUserTags(param1:int) : Array
      {
         return this.var_2219.getTags(param1);
      }
      
      public function getBadgeImage(param1:String) : BitmapData
      {
         return this.var_1150.getBadgeImage(param1);
      }
      
      public function requestBadgeImage(param1:String) : BitmapData
      {
         return this.var_1150.getBadgeImage(param1,BadgeImageManager.const_1196,false);
      }
      
      public function getBadgeImageWithInfo(param1:String) : BadgeInfo
      {
         return this.var_1150.getBadgeImageWithInfo(param1);
      }
      
      public function showGroupBadgeInfo(param1:int) : void
      {
         if(this._configuration.getKey("groupBadgeInfo.enabled") == "false")
         {
            this._windowManager.alert("${group.inconstruction.title}","${group.inconstruction.desc}",0,this.onAlertClose);
         }
         else
         {
            this.send(new GetHabboGroupDetailsMessageComposer(param1));
         }
         this.send(new EventLogMessageComposer(GroupDetailsView.const_208,"" + param1,"badge clicked"));
      }
      
      private function onAlertClose(param1:IAlertDialog, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      public function getGroupBadgeId(param1:int) : String
      {
         return this.var_2218.getBadgeId(param1);
      }
      
      public function send(param1:IMessageComposer) : void
      {
         this._communication.getHabboMainConnection(null).send(param1);
      }
      
      public function getGroupBadgeImage(param1:String) : BitmapData
      {
         return this.var_1150.getBadgeImage(param1,BadgeImageManager.const_1310);
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return this._communication;
      }
      
      public function isIgnored(param1:String) : Boolean
      {
         return this.var_1149.isIgnored(param1);
      }
      
      public function ignoreUser(param1:String) : void
      {
         this.var_1149.ignoreUser(param1);
      }
      
      public function unignoreUser(param1:String) : void
      {
         this.var_1149.unignoreUser(param1);
      }
      
      public function get respectLeft() : int
      {
         return this.var_1414;
      }
      
      public function get petRespectLeft() : int
      {
         return this.var_935;
      }
      
      public function giveRespect(param1:int) : void
      {
         if(param1 < 0 || this.var_1414 < 1)
         {
            throw new Error("Failed to give respect to user: " + param1);
         }
         this.send(new RespectUserMessageComposer(param1));
         this.var_1414 = this.var_1414 - 1;
      }
      
      public function givePetRespect(param1:int) : void
      {
         if(param1 < 0 || this.var_935 < 1)
         {
            throw new Error("Failed to give respect to pet: " + param1);
         }
         this.send(new RespectPetMessageComposer(param1));
         this.var_935 = this.var_935 - 1;
      }
      
      public function get configuration() : IHabboConfigurationManager
      {
         return this._configuration;
      }
      
      public function getProductData(param1:String) : IProductData
      {
         if(!this.var_2217)
         {
            this.loadProductData();
         }
         return this.var_1261[param1];
      }
      
      public function getFloorItemData(param1:int) : IFurnitureData
      {
         if(this.var_610 == null)
         {
            return null;
         }
         return this.var_610.getValue(param1.toString());
      }
      
      public function getWallItemData(param1:int) : IFurnitureData
      {
         if(this._wallItems == null)
         {
            return null;
         }
         return this._wallItems.getValue(param1.toString());
      }
      
      public function getFloorItemDataByName(param1:String, param2:int = 0) : IFurnitureData
      {
         var _loc4_:int = 0;
         if(this.var_611 == null)
         {
            return null;
         }
         var _loc3_:Array = this.var_611.getValue(param1);
         if(_loc3_ != null && param2 <= _loc3_.length - 1)
         {
            _loc4_ = _loc3_[param2];
            return this.getFloorItemData(_loc4_);
         }
         return null;
      }
      
      public function getWallItemDataByName(param1:String, param2:int = 0) : IFurnitureData
      {
         var _loc4_:int = 0;
         if(this.var_611 == null)
         {
            return null;
         }
         var _loc3_:Array = this.var_611.getValue(param1);
         if(_loc3_ != null && param2 <= _loc3_.length - 1)
         {
            _loc4_ = _loc3_[param2];
            return this.getWallItemData(_loc4_);
         }
         return null;
      }
      
      public function openHabboHomePage(param1:int) : void
      {
         var urlString:String = null;
         var userId:int = param1;
         if(this._configuration != null)
         {
            urlString = this._configuration.getKey("link.format.userpage");
            urlString = urlString.replace("%ID%",String(userId));
            try
            {
               HabboWebTools.navigateToURL(urlString,"habboMain");
            }
            catch(e:Error)
            {
               Logger.log("Error occurred!");
            }
         }
      }
      
      public function pickAllFurniture(param1:int, param2:int) : void
      {
         var roomId:int = param1;
         var roomCategory:int = param2;
         if(this.var_15 == null || this._windowManager == null)
         {
            return;
         }
         var session:IRoomSession = this.var_15.getSession(roomId,roomCategory);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || this.isAnyRoomController)
         {
            this._windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all}",0,function(param1:IConfirmDialog, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == WindowEvent.const_146)
               {
                  sendPickAllFurnitureMessage();
               }
            });
         }
      }
      
      public function loadProductData(param1:IProductDataListener = null) : Boolean
      {
         var _loc2_:* = null;
         if(this.var_2217)
         {
            return true;
         }
         if(param1 && this.var_1415.indexOf(param1) == -1)
         {
            this.var_1415.push(param1);
         }
         if(!this._configuration)
         {
            return false;
         }
         if(this.var_753 == null)
         {
            _loc2_ = this._configuration.getKey("productdata.load.url");
            this.var_753 = new ProductDataParser(_loc2_,this.var_1261);
            this.var_753.addEventListener(ProductDataParser.const_129,this.onProductsReady);
         }
         return false;
      }
      
      private function onProductsReady(param1:Event) : void
      {
         var _loc2_:* = null;
         this.var_753.removeEventListener(ProductDataParser.const_129,this.onProductsReady);
         this.var_2217 = true;
         for each(_loc2_ in this.var_1415)
         {
            if(_loc2_ != null && !_loc2_.disposed)
            {
               _loc2_.productDataReady();
            }
         }
         this.var_1415 = [];
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc2_:RoomReadyMessageEvent = param1 as RoomReadyMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null || param1.connection == null)
         {
            return;
         }
         var _loc3_:RoomReadyMessageParser = _loc2_.getParser();
         HabboWebTools.roomVisited(_loc3_.roomId);
      }
      
      private function sendPickAllFurnitureMessage() : void
      {
         this.send(new ChatMessageComposer(":pickall"));
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return this.var_15;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return this._windowManager;
      }
      
      public function get gender() : String
      {
         return this.var_1123;
      }
      
      public function getFurniData(param1:IFurniDataListener) : Array
      {
         if(this.var_610.length == 0)
         {
            if(this.var_1148.indexOf(param1) == -1)
            {
               this.var_1148.push(param1);
            }
            return null;
         }
         var _loc2_:Array = this.var_610.getValues();
         return _loc2_.concat(this._wallItems.getValues());
      }
      
      public function getXmlWindow(param1:String) : IWindow
      {
         var asset:IAsset = null;
         var xmlAsset:XmlAsset = null;
         var name:String = param1;
         var window:IWindow = null;
         try
         {
            asset = assets.getAssetByName(name);
            xmlAsset = XmlAsset(asset);
            window = this._windowManager.buildFromXML(XML(xmlAsset.content));
         }
         catch(e:Error)
         {
         }
         return window;
      }
      
      public function getButtonImage(param1:String) : BitmapData
      {
         var _loc2_:String = param1;
         var _loc3_:IAsset = assets.getAssetByName(_loc2_);
         var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc3_);
         var _loc5_:BitmapData = BitmapData(_loc4_.content);
         var _loc6_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc6_.draw(_loc5_);
         return _loc6_;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return this._localization;
      }
   }
}
