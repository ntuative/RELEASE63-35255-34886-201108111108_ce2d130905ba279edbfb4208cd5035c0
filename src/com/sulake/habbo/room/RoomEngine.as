package com.sulake.habbo.room
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.advertisement.IAdManager;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.habbo.room.utils.FurnitureData;
   import com.sulake.habbo.room.utils.LegacyWallGeometry;
   import com.sulake.habbo.room.utils.RoomCamera;
   import com.sulake.habbo.room.utils.RoomData;
   import com.sulake.habbo.room.utils.RoomInstanceData;
   import com.sulake.habbo.room.utils.SelectedRoomObjectData;
   import com.sulake.habbo.room.utils.TileHeightMap;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.iid.IIDHabboAdManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomManager;
   import com.sulake.iid.IIDRoomObjectFactory;
   import com.sulake.iid.IIDRoomObjectVisualizationFactory;
   import com.sulake.iid.IIDRoomRendererFactory;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.IRoomManager;
   import com.sulake.room.IRoomManagerListener;
   import com.sulake.room.IRoomObjectFactory;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectVisualizationFactory;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.renderer.IRoomRenderer;
   import com.sulake.room.renderer.IRoomRendererFactory;
   import com.sulake.room.renderer.IRoomRenderingCanvas;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.NumberBank;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.getTimer;
   
   public class RoomEngine extends Component implements IRoomEngine, IRoomManagerListener, IRoomCreator, IRoomEngineServices, IUpdateReceiver
   {
      
      private static const const_706:String = "temporary_room";
      
      private static const const_392:int = -1;
      
      private static const const_707:String = "room";
      
      private static const const_1108:int = -2;
      
      private static const const_1603:String = "tile_cursor";
      
      private static const const_1106:int = -3;
      
      private static const const_1602:String = "selection_arrow";
      
      private static const OVERLAY_SPRITE:String = "overlay";
      
      private static const const_393:String = "object_icon_sprite";
      
      private static const const_482:int = 15;
      
      private static const const_1107:int = 40;
       
      
      private var _communication:IHabboCommunicationManager = null;
      
      private var _connection:IConnection = null;
      
      private var _roomManager:IRoomManager = null;
      
      private var _roomRendererFactory:IRoomRendererFactory = null;
      
      private var var_839:IRoomObjectFactory = null;
      
      private var var_564:IRoomObjectVisualizationFactory = null;
      
      private var var_337:IAdManager = null;
      
      private var var_414:ISessionDataManager = null;
      
      private var var_15:IRoomSessionManager = null;
      
      private var var_398:IHabboToolbar = null;
      
      private var var_156:IHabboConfigurationManager;
      
      private var var_74:RoomObjectEventHandler = null;
      
      private var var_478:RoomMessageHandler = null;
      
      private var var_14:RoomContentLoader = null;
      
      private var var_2808:Boolean = false;
      
      private var var_841:NumberBank;
      
      private var var_1295:Map;
      
      private var var_573:Boolean = false;
      
      private var var_87:int = 0;
      
      private var var_86:int = 0;
      
      private var var_1587:int = -1;
      
      private var var_1590:int = 0;
      
      private var var_1589:int = 0;
      
      private var var_838:Boolean = false;
      
      private var var_840:Boolean = false;
      
      private var var_2807:int = 0;
      
      private var var_2810:int = 0;
      
      private var var_1588:int = 0;
      
      private var var_1591:int = 0;
      
      private var var_2809:Boolean = false;
      
      private var var_400:Map = null;
      
      private var var_289:Map = null;
      
      private var var_1061:Boolean = false;
      
      private var var_574:Array;
      
      private var var_1294:Boolean;
      
      public function RoomEngine(param1:IContext, param2:uint = 0)
      {
         this.var_574 = new Array();
         super(param1,param2);
         this.var_289 = new Map();
         this.var_841 = new NumberBank(1000);
         this.var_1295 = new Map();
         this.var_400 = new Map();
         this.var_74 = new RoomObjectEventHandler(this);
         this.var_478 = new RoomMessageHandler(this);
         var _loc3_:DisplayObjectContainer = param1.displayObjectContainer;
         var _loc4_:LoaderInfo = _loc3_.loaderInfo;
         this.var_14 = new RoomContentLoader(_loc4_.loaderURL);
         queueInterface(new IIDRoomObjectFactory(),this.onObjectFactoryReady);
         queueInterface(new IIDRoomObjectVisualizationFactory(),this.onVisualizationFactoryReady);
         queueInterface(new IIDRoomManager(),this.onRoomManagerReady);
         queueInterface(new IIDRoomRendererFactory(),this.onRendererFactoryReady);
         queueInterface(new IIDHabboCommunicationManager(),this.onCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),this.onHabboConfigurationReady);
         queueInterface(new IIDHabboAdManager(),this.onAdManagerReady);
         queueInterface(new IIDSessionDataManager(),this.onSessionDataManagerReady);
         queueInterface(new IIDHabboRoomSessionManager(),this.onRoomSessionManagerReady);
         queueInterface(new IIDHabboToolbar(),this.onToolbarReady);
         this.initialize();
         registerUpdateReceiver(this,1);
      }
      
      public function get isInitialized() : Boolean
      {
         return this.var_573;
      }
      
      public function get roomManager() : IRoomManager
      {
         return this._roomManager;
      }
      
      public function get connection() : IConnection
      {
         return this._connection;
      }
      
      public function get activeRoomId() : int
      {
         return this.var_87;
      }
      
      public function get activeRoomCategory() : int
      {
         return this.var_86;
      }
      
      private function get useOffsetScrolling() : Boolean
      {
         return true;
      }
      
      public function isPublicRoomWorldType(param1:String) : Boolean
      {
         if(this.var_14 != null)
         {
            return this.var_14.isPublicRoomWorldType(param1);
         }
         return false;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         removeUpdateReceiver(this);
         if(this.var_839 != null)
         {
            this.var_839.release(new IIDRoomObjectFactory());
            this.var_839 = null;
         }
         if(this.var_564 != null)
         {
            this.var_564.release(new IIDRoomObjectVisualizationFactory());
            this.var_564 = null;
         }
         if(this._roomManager != null)
         {
            this._roomManager.release(new IIDRoomManager());
            this._roomManager = null;
         }
         if(this._roomRendererFactory != null)
         {
            this._roomRendererFactory.release(new IIDRoomRendererFactory());
            this._roomRendererFactory = null;
         }
         if(this._communication != null)
         {
            this._communication.release(new IIDHabboCommunicationManager());
            this._communication = null;
         }
         if(this.var_156 != null)
         {
            this.var_156.release(new IIDHabboConfigurationManager());
            this.var_156 = null;
         }
         if(this.var_398 != null)
         {
            this.var_398.events.removeEventListener(HabboToolbarEvent.const_48,this.onToolbarClicked);
            this.var_398.release(new IIDHabboToolbar());
            this.var_398 = null;
         }
         if(this.var_337)
         {
            this.var_337.release(new IIDHabboAdManager());
            this.var_337 = null;
         }
         if(this.var_414)
         {
            this.var_414.release(new IIDSessionDataManager());
            this.var_414 = null;
         }
         if(this.var_15)
         {
            this.var_15.release(new IIDHabboRoomSessionManager());
            this.var_15 = null;
         }
         this._connection = null;
         if(this.var_841 != null)
         {
            this.var_841.dispose();
            this.var_841 = null;
         }
         if(this.var_1295 != null)
         {
            this.var_1295.dispose();
         }
         if(this.var_74 != null)
         {
            this.var_74.dispose();
            this.var_74 = null;
         }
         if(this.var_478 != null)
         {
            this.var_478.dispose();
            this.var_478 = null;
         }
         if(this.var_14 != null)
         {
            this.var_14.dispose();
            this.var_14 = null;
         }
         if(this.var_400 != null)
         {
            this.var_400.dispose();
            this.var_400 = null;
         }
         if(this.var_289 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_289.length)
            {
               _loc2_ = this.var_289.getWithIndex(_loc1_) as RoomInstanceData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_289.dispose();
            this.var_289 = null;
         }
         super.dispose();
      }
      
      private function initialize() : void
      {
      }
      
      private function getRoomInstanceData(param1:int, param2:int) : RoomInstanceData
      {
         var _loc3_:String = this.getRoomIdentifier(param1,param2);
         var _loc4_:* = null;
         if(this.var_289 != null)
         {
            _loc4_ = this.var_289.getValue(_loc3_) as RoomInstanceData;
            if(_loc4_ == null)
            {
               _loc4_ = new RoomInstanceData(param1,param2);
               this.var_289.add(_loc3_,_loc4_);
            }
         }
         return _loc4_;
      }
      
      public function setTileHeightMap(param1:int, param2:int, param3:TileHeightMap) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.tileHeightMap = param3;
         }
      }
      
      public function getTileHeightMap(param1:int, param2:int) : TileHeightMap
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.tileHeightMap;
         }
         return null;
      }
      
      public function setWorldType(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.worldType = param3;
         }
      }
      
      public function getWorldType(param1:int, param2:int) : String
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.worldType;
         }
         return null;
      }
      
      public function getLegacyGeometry(param1:int, param2:int) : LegacyWallGeometry
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.legacyGeometry;
         }
         return null;
      }
      
      private function getDefaultCamera() : RoomCamera
      {
         return this.getRoomCamera(this.var_87,this.var_86);
      }
      
      private function getRoomCamera(param1:int, param2:int) : RoomCamera
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.roomCamera;
         }
         return null;
      }
      
      public function setSelectedObjectData(param1:int, param2:int, param3:SelectedRoomObjectData) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.selectedObject = param3;
            if(param3 != null)
            {
               _loc4_.placedObject = null;
            }
         }
      }
      
      public function getSelectedObjectData(param1:int, param2:int) : ISelectedRoomObjectData
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.selectedObject;
         }
         return null;
      }
      
      public function setPlacedObjectData(param1:int, param2:int, param3:SelectedRoomObjectData) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.placedObject = param3;
         }
      }
      
      public function getPlacedObjectData(param1:int, param2:int) : ISelectedRoomObjectData
      {
         var _loc3_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.placedObject;
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(this._roomManager != null)
         {
            this.createRoomFurniture();
            this._roomManager.update(param1);
            _loc2_ = 0;
            while(_loc2_ < this._roomManager.getRoomCount())
            {
               _loc3_ = this._roomManager.getRoomWithIndex(_loc2_);
               if(_loc3_ != null && _loc3_.getRenderer() != null)
               {
                  _loc3_.getRenderer().update(param1);
               }
               _loc2_++;
            }
            this.updateRoomCameras(param1);
            if(this.var_1294)
            {
               this.updateMouseCursor();
            }
         }
      }
      
      private function updateMouseCursor() : void
      {
         this.var_1294 = false;
         if(this.var_574 && this.var_574.length > 0)
         {
            Mouse.cursor = MouseCursor.BUTTON;
         }
         else
         {
            Mouse.cursor = MouseCursor.ARROW;
         }
         this.var_1294 = false;
      }
      
      public function requestMouseCursor(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:int = this.getRoomObjectCategory(param3);
         switch(param1)
         {
            case RoomObjectFurnitureActionEvent.const_305:
               this.addBtnMouseCursorOwner(_loc4_,param2);
               break;
            default:
               this.removeBtnMouseCursorOwner(_loc4_,param2);
         }
      }
      
      private function addBtnMouseCursorOwner(param1:int, param2:int) : void
      {
         if(!this.var_574)
         {
            return;
         }
         var _loc3_:IRoomSession = this.var_15.getSession(this.var_87,this.var_86);
         if((param1 == RoomObjectCategoryEnum.const_27 || param1 == RoomObjectCategoryEnum.const_26) && !_loc3_.isRoomController)
         {
            return;
         }
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:int = this.var_574.indexOf(_loc4_);
         if(_loc5_ == -1)
         {
            this.var_574.push(_loc4_);
            this.var_1294 = true;
         }
      }
      
      private function removeBtnMouseCursorOwner(param1:int, param2:int) : void
      {
         if(!this.var_574)
         {
            return;
         }
         var _loc3_:String = param1 + "_" + param2;
         var _loc4_:int = this.var_574.indexOf(_loc3_);
         if(_loc4_ > -1)
         {
            this.var_574.splice(_loc4_,1);
            this.var_1294 = true;
         }
      }
      
      public function addFloorHole(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param3 >= 0)
         {
            _loc4_ = this.getObjectRoom(param1,param2);
            _loc5_ = this.getObjectFurniture(param1,param2,param3);
            if(_loc5_ != null && _loc5_.getModel() != null && _loc4_ != null && _loc4_.getEventHandler() != null)
            {
               _loc6_ = "null";
               _loc7_ = _loc5_.getLocation().x;
               _loc8_ = _loc5_.getLocation().y;
               _loc9_ = _loc5_.getModel().getNumber(RoomObjectVariableEnum.const_263);
               _loc10_ = _loc5_.getModel().getNumber(RoomObjectVariableEnum.const_378);
               _loc4_.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_loc6_,param3,_loc7_,_loc8_,_loc9_,_loc10_));
            }
         }
      }
      
      public function removeFloorHole(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param3 >= 0)
         {
            _loc4_ = this.getObjectRoom(param1,param2);
            if(_loc4_ != null && _loc4_.getEventHandler() != null)
            {
               _loc5_ = "null";
               _loc4_.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_loc5_,param3));
            }
         }
      }
      
      private function createRoomFurniture() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(this.var_1061)
         {
            this.var_1061 = false;
            return;
         }
         var _loc1_:int = getTimer();
         var _loc7_:int = 0;
         var _loc8_:* = this.var_289;
         do
         {
            for each(_loc4_ in _loc8_)
            {
               _loc5_ = 0;
               _loc6_ = null;
               while((_loc6_ = _loc4_.getFurnitureData()) != null)
               {
                  this.addObjectFurnitureFromData(_loc4_.roomId,_loc4_.roomCategory,_loc6_.id,_loc6_);
                  if(++_loc5_ % 5 == 0)
                  {
                     _loc3_ = getTimer();
                     if(_loc3_ - _loc1_ >= const_1107)
                     {
                        this.var_1061 = true;
                        break;
                     }
                  }
               }
               while(!this.var_1061 && (_loc6_ = _loc4_.getWallItemData()) != null)
               {
                  this.addObjectWallItemFromData(_loc4_.roomId,_loc4_.roomCategory,_loc6_.id,_loc6_);
                  if(++_loc5_ % 5 == 0)
                  {
                     _loc3_ = getTimer();
                     if(_loc3_ - _loc1_ >= const_1107)
                     {
                        this.var_1061 = true;
                        break;
                     }
                  }
               }
            }
            return;
         }
         while(!this.var_1061);
         
      }
      
      private function updateRoomCameras(param1:uint) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.var_289.length)
         {
            _loc5_ = this.var_289.getWithIndex(_loc3_) as RoomInstanceData;
            _loc6_ = null;
            _loc7_ = 0;
            _loc8_ = 0;
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.roomCamera;
               _loc7_ = _loc5_.roomId;
               _loc8_ = _loc5_.roomCategory;
            }
            if(_loc6_ != null)
            {
               _loc9_ = _loc6_.targetId;
               _loc10_ = _loc6_.targetCategory;
               _loc11_ = this.getRoomObject(_loc7_,_loc8_,_loc9_,_loc10_);
               if(_loc11_ != null)
               {
                  if(_loc7_ != this.var_87 || _loc8_ != this.var_86 || !this.var_838)
                  {
                     this.updateRoomCamera(_loc7_,_loc8_,1,_loc11_.getLocation(),param1);
                  }
               }
            }
            _loc3_++;
         }
         var _loc4_:IRoomRenderingCanvas = this.getRoomCanvas(this.var_87,this.var_86,1);
         if(_loc4_ != null)
         {
            if(this.var_838)
            {
               _loc4_.screenOffsetX += this.var_1588;
               _loc4_.screenOffsetY += this.var_1591;
               this.var_1588 = 0;
               this.var_1591 = 0;
            }
         }
      }
      
      private function updateRoomCamera(param1:int, param2:int, param3:int, param4:IVector3d, param5:uint) : void
      {
         var _loc11_:* = NaN;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = NaN;
         var _loc24_:* = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:* = null;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:* = NaN;
         var _loc31_:* = NaN;
         var _loc32_:* = NaN;
         var _loc33_:* = NaN;
         var _loc34_:* = null;
         var _loc35_:Boolean = false;
         var _loc36_:Boolean = false;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:* = NaN;
         var _loc42_:* = NaN;
         var _loc43_:* = NaN;
         var _loc44_:int = 0;
         var _loc45_:int = 0;
         var _loc46_:* = null;
         var _loc47_:* = null;
         var _loc6_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         var _loc7_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc6_ == null || _loc7_ == null)
         {
            return;
         }
         var _loc8_:RoomGeometry = _loc6_.geometry as RoomGeometry;
         var _loc9_:RoomCamera = _loc7_.roomCamera;
         var _loc10_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc8_ != null && _loc9_ != null && _loc10_ != null)
         {
            _loc11_ = Number(Math.floor(param4.z) + 1);
            _loc12_ = this.getRoomCanvasRectangle(param1,param2,param3);
            if(_loc12_ != null)
            {
               _loc13_ = Math.round(_loc12_.width);
               _loc14_ = Math.round(_loc12_.height);
               _loc15_ = this.getActiveRoomBoundingRectangle(param3);
               if(_loc15_ != null && (_loc15_.right < 0 || _loc15_.bottom < 0 || _loc15_.left >= _loc13_ || _loc15_.top >= _loc14_))
               {
                  _loc9_.reset();
               }
               if(_loc9_.screenWd != _loc13_ || _loc9_.screenHt != _loc14_ || _loc9_.scale != _loc8_.scale || _loc9_.geometryUpdateId != _loc8_.updateId || !Vector3d.isEqual(param4,_loc9_.targetObjectLoc) || _loc9_.isMoving)
               {
                  _loc9_.targetObjectLoc = param4;
                  _loc16_ = new Vector3d();
                  _loc16_.assign(param4);
                  _loc16_.x = Math.round(_loc16_.x);
                  _loc16_.y = Math.round(_loc16_.y);
                  _loc17_ = _loc10_.getNumber(RoomVariableEnum.const_905) - 0.5;
                  _loc18_ = _loc10_.getNumber(RoomVariableEnum.const_981) - 0.5;
                  _loc19_ = _loc10_.getNumber(RoomVariableEnum.const_852) + 0.5;
                  _loc20_ = _loc10_.getNumber(RoomVariableEnum.const_986) + 0.5;
                  _loc21_ = Math.round((_loc17_ + _loc19_) / 2);
                  _loc22_ = Math.round((_loc18_ + _loc20_) / 2);
                  _loc23_ = 2;
                  _loc24_ = new Point(_loc16_.x - _loc21_,_loc16_.y - _loc22_);
                  _loc25_ = _loc8_.scale / Math.sqrt(2);
                  _loc26_ = _loc25_ / 2;
                  _loc27_ = new Matrix();
                  _loc27_.rotate(-(_loc8_.direction.x + 90) / 180 * 0);
                  _loc24_ = _loc27_.transformPoint(_loc24_);
                  _loc24_.y *= _loc26_ / _loc25_;
                  _loc28_ = _loc12_.width / 2 / _loc25_ - 1;
                  _loc29_ = _loc12_.height / 2 / _loc26_ - 1;
                  _loc30_ = 0;
                  _loc31_ = 0;
                  _loc32_ = 0;
                  _loc33_ = 0;
                  _loc34_ = _loc8_.getScreenPoint(new Vector3d(_loc21_,_loc22_,_loc23_));
                  _loc34_.x += Math.round(_loc12_.width / 2);
                  _loc34_.y += Math.round(_loc12_.height / 2);
                  if(_loc15_ == null)
                  {
                     _loc8_.adjustLocation(new Vector3d(0,0),25);
                     return;
                  }
                  _loc15_.offset(-_loc6_.screenOffsetX,-_loc6_.screenOffsetY);
                  if(!(_loc15_.width > 1 && _loc15_.height > 1))
                  {
                     _loc8_.adjustLocation(new Vector3d(-30,-30),25);
                     return;
                  }
                  _loc30_ = Number((_loc15_.left - _loc34_.x - _loc8_.scale * 0.25) / _loc25_);
                  _loc32_ = Number((_loc15_.right - _loc34_.x + _loc8_.scale * 0.25) / _loc25_);
                  _loc31_ = Number((_loc15_.top - _loc34_.y - _loc8_.scale * 0.5) / _loc26_);
                  _loc33_ = Number((_loc15_.bottom - _loc34_.y + _loc8_.scale * 0.5) / _loc26_);
                  _loc35_ = false;
                  _loc36_ = false;
                  _loc37_ = false;
                  _loc38_ = false;
                  _loc39_ = Math.round((_loc32_ - _loc30_) * _loc25_);
                  if(_loc39_ < _loc12_.width)
                  {
                     _loc11_ = 2;
                     _loc24_.x = (_loc32_ + _loc30_) / 2;
                     _loc37_ = true;
                  }
                  else
                  {
                     if(_loc24_.x > _loc32_ - _loc28_)
                     {
                        _loc24_.x = _loc32_ - _loc28_;
                        _loc35_ = true;
                     }
                     if(_loc24_.x < _loc30_ + _loc28_)
                     {
                        _loc24_.x = _loc30_ + _loc28_;
                        _loc35_ = true;
                     }
                  }
                  _loc40_ = Math.round((_loc33_ - _loc31_) * _loc26_);
                  if(_loc40_ < _loc12_.height)
                  {
                     _loc11_ = 2;
                     _loc24_.y = (_loc33_ + _loc31_) / 2;
                     _loc38_ = true;
                  }
                  else
                  {
                     if(_loc24_.y > _loc33_ - _loc29_)
                     {
                        _loc24_.y = _loc33_ - _loc29_;
                        _loc36_ = true;
                     }
                     if(_loc24_.y < _loc31_ + _loc29_)
                     {
                        _loc24_.y = _loc31_ + _loc29_;
                        _loc36_ = true;
                     }
                     if(_loc36_)
                     {
                        _loc24_.y /= _loc26_ / _loc25_;
                     }
                  }
                  _loc27_.invert();
                  _loc24_ = _loc27_.transformPoint(_loc24_);
                  _loc24_.x += _loc21_;
                  _loc24_.y += _loc22_;
                  _loc41_ = 0.35;
                  _loc42_ = 0.2;
                  _loc43_ = 0.2;
                  _loc44_ = 10;
                  _loc45_ = 10;
                  if(_loc43_ * _loc13_ > 100)
                  {
                     _loc43_ = Number(100 / _loc13_);
                  }
                  if(_loc41_ * _loc14_ > 150)
                  {
                     _loc41_ = Number(150 / _loc14_);
                  }
                  if(_loc42_ * _loc14_ > 150)
                  {
                     _loc42_ = Number(150 / _loc14_);
                  }
                  if(_loc9_.limitedLocationX && _loc9_.screenWd == _loc13_ && _loc9_.screenHt == _loc14_)
                  {
                     _loc43_ = 0;
                  }
                  if(_loc9_.limitedLocationY && _loc9_.screenWd == _loc13_ && _loc9_.screenHt == _loc14_)
                  {
                     _loc41_ = 0;
                     _loc42_ = 0;
                  }
                  _loc12_.right *= 1 - _loc43_ * 2;
                  _loc12_.bottom *= 1 - (_loc41_ + _loc42_);
                  if(_loc12_.right < _loc44_)
                  {
                     _loc12_.right = _loc44_;
                  }
                  if(_loc12_.bottom < _loc45_)
                  {
                     _loc12_.bottom = _loc45_;
                  }
                  if(_loc41_ + _loc42_ > 0)
                  {
                     _loc12_.offset(-_loc12_.width / 2,-_loc12_.height * (_loc42_ / (_loc41_ + _loc42_)));
                  }
                  else
                  {
                     _loc12_.offset(-_loc12_.width / 2,-_loc12_.height / 2);
                  }
                  _loc34_ = _loc8_.getScreenPoint(_loc16_);
                  if(_loc34_ != null)
                  {
                     _loc34_.x += _loc6_.screenOffsetX;
                     _loc34_.y += _loc6_.screenOffsetY;
                     _loc16_.z = _loc11_;
                     _loc16_.x = Math.round(_loc24_.x * 2) / 2;
                     _loc16_.y = Math.round(_loc24_.y * 2) / 2;
                     if(_loc9_.location == null)
                     {
                        _loc8_.location = _loc16_;
                        if(this.useOffsetScrolling)
                        {
                           _loc9_.initializeLocation(new Vector3d(0,0,0));
                        }
                        else
                        {
                           _loc9_.initializeLocation(_loc16_);
                        }
                     }
                     _loc46_ = _loc8_.getScreenPoint(_loc16_);
                     _loc47_ = new Vector3d(0,0,0);
                     if(_loc46_ != null)
                     {
                        _loc47_.x = _loc46_.x;
                        _loc47_.y = _loc46_.y;
                     }
                     if((_loc34_.x < _loc12_.left || _loc34_.x > _loc12_.right) && !_loc9_.centeredLocX || (_loc34_.y < _loc12_.top || _loc34_.y > _loc12_.bottom) && !_loc9_.centeredLocY || _loc37_ && !_loc9_.centeredLocX && _loc9_.screenWd != _loc13_ || _loc38_ && !_loc9_.centeredLocY && _loc9_.screenHt != _loc14_ || (_loc9_.roomWd != _loc15_.width || _loc9_.roomHt != _loc15_.height) || (_loc9_.screenWd != _loc13_ || _loc9_.screenHt != _loc14_))
                     {
                        _loc9_.limitedLocationX = _loc35_;
                        _loc9_.limitedLocationY = _loc36_;
                        if(this.useOffsetScrolling)
                        {
                           _loc9_.target = _loc47_;
                        }
                        else
                        {
                           _loc9_.target = _loc16_;
                        }
                     }
                     else
                     {
                        if(!_loc35_)
                        {
                           _loc9_.limitedLocationX = false;
                        }
                        if(!_loc36_)
                        {
                           _loc9_.limitedLocationY = false;
                        }
                     }
                  }
                  _loc9_.centeredLocX = _loc37_;
                  _loc9_.centeredLocY = _loc38_;
                  _loc9_.screenWd = _loc13_;
                  _loc9_.screenHt = _loc14_;
                  _loc9_.scale = _loc8_.scale;
                  _loc9_.geometryUpdateId = _loc8_.updateId;
                  _loc9_.roomWd = _loc15_.width;
                  _loc9_.roomHt = _loc15_.height;
                  if(this.useOffsetScrolling)
                  {
                     _loc9_.update(param5,8);
                  }
                  else
                  {
                     _loc9_.update(param5,0.5);
                  }
                  if(this.useOffsetScrolling)
                  {
                     _loc6_.screenOffsetX = -_loc9_.location.x;
                     _loc6_.screenOffsetY = -_loc9_.location.y;
                  }
                  else
                  {
                     _loc8_.adjustLocation(_loc9_.location,25);
                  }
               }
               else
               {
                  _loc9_.limitedLocationX = false;
                  _loc9_.limitedLocationY = false;
                  _loc9_.centeredLocX = false;
                  _loc9_.centeredLocY = false;
               }
            }
         }
      }
      
      private function onObjectFactoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_839 = param2 as IRoomObjectFactory;
         this.initializeObjectEvents();
         this.initializeRoomManager();
      }
      
      private function onVisualizationFactoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_564 = param2 as IRoomObjectVisualizationFactory;
         if(this.var_14 != null)
         {
            this.var_14.visualizationFactory = this.var_564;
         }
         this.initializeRoomManager();
      }
      
      private function onRoomManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._roomManager = param2 as IRoomManager;
         if(this._roomManager != null)
         {
            this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.const_27);
            this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.const_26);
            this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.const_383);
            this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.const_82);
            this._roomManager.setContentLoader(this.var_14);
         }
         this.initializeRoomManager();
      }
      
      private function onRendererFactoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._roomRendererFactory = param2 as IRoomRendererFactory;
         this.initializeRoomManager();
      }
      
      private function onCommunicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this._communication = param2 as IHabboCommunicationManager;
         if(this._communication != null)
         {
            this._connection = this._communication.getHabboMainConnection(this.onConnectionReady);
            if(this._connection != null)
            {
               this.onConnectionReady(this._connection);
            }
         }
         this.initializeRoomManager();
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            this._connection = param1;
            if(this.var_478 != null)
            {
               this.var_478.connection = param1;
            }
         }
      }
      
      private function onHabboConfigurationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_156 = param2 as IHabboConfigurationManager;
         if(this.var_14 != null)
         {
            events.addEventListener(RoomContentLoader.const_826,this.onContentLoaderReady);
            this.var_14.initialize(events,this.var_156);
         }
         this.var_2809 = this.var_156.getKey("room.dragging.always_center","0") == "1";
         this.initializeRoomManager();
      }
      
      private function onContentLoaderReady(param1:Event) : void
      {
         if(param1 != null && param1.type == RoomContentLoader.const_826)
         {
            this.var_2808 = true;
            this.initializeRoomManager();
         }
      }
      
      private function onAdManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_337 = param2 as IAdManager;
         this.var_337.events.addEventListener(AdEvent.const_555,this.showRoomAd);
         this.var_337.events.addEventListener(AdEvent.const_855,this.onRoomAdImageLoaded);
         this.var_337.events.addEventListener(AdEvent.const_1311,this.onRoomAdImageLoaded);
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_414 = param2 as ISessionDataManager;
         this.var_14.sessionDataManager = this.var_414;
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_15 = param2 as IRoomSessionManager;
         this.var_15.events.addEventListener(RoomSessionEvent.const_77,this.onRoomSessionEvent);
         this.var_15.events.addEventListener(RoomSessionEvent.const_84,this.onRoomSessionEvent);
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case RoomSessionEvent.const_77:
               if(this.var_478)
               {
                  this.var_478.setCurrentRoom(param1.session.roomId,param1.session.roomCategory);
               }
               break;
            case RoomSessionEvent.const_84:
               if(this.var_478)
               {
                  this.var_478.resetCurrentRoom();
                  this.disposeRoom(param1.session.roomId,param1.session.roomCategory);
               }
         }
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         this.var_398 = param2 as IHabboToolbar;
         this.var_398.events.addEventListener(HabboToolbarEvent.const_48,this.onToolbarClicked);
      }
      
      private function onToolbarClicked(param1:HabboToolbarEvent) : void
      {
         var _loc2_:* = null;
         if(param1.iconId == HabboToolbarIconEnum.MEMENU)
         {
            _loc2_ = this.getDefaultCamera();
            if(_loc2_)
            {
               _loc2_.reset();
            }
         }
      }
      
      private function initializeObjectEvents() : void
      {
         if(this.var_839 != null)
         {
            this.var_839.addObjectEventListener(this.roomObjectEventHandler);
         }
      }
      
      private function initializeRoomManager() : void
      {
         if(this.var_839 == null || this.var_564 == null || this._roomManager == null || this._roomRendererFactory == null || this._communication == null || this.var_156 == null || !this.var_2808)
         {
            return;
         }
         this._roomManager.initialize(<nothing/>,this);
      }
      
      public function roomManagerInitialized(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1)
         {
            this.var_573 = true;
            events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.const_894,0,0));
            _loc2_ = 0;
            while(_loc2_ < this.var_400.length)
            {
               _loc3_ = this.var_400.getWithIndex(_loc2_) as RoomData;
               if(_loc3_ != null)
               {
                  this.initializeRoom(_loc3_.roomId,_loc3_.roomCategory,_loc3_.data);
               }
               _loc2_++;
            }
         }
      }
      
      public function setActiveRoom(param1:int, param2:int) : void
      {
         this.var_87 = param1;
         this.var_86 = param2;
      }
      
      public function getRoomIdentifier(param1:int, param2:int) : String
      {
         return String(param1 + "_" + param2);
      }
      
      private function getRoomId(param1:String) : int
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            _loc2_ = param1.split("_");
            if(_loc2_.length > 0)
            {
               return _loc2_[0];
            }
         }
         return -1;
      }
      
      private function getRoomCategory(param1:String) : int
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            _loc2_ = param1.split("_");
            if(_loc2_.length > 1)
            {
               return _loc2_[1];
            }
         }
         return -1;
      }
      
      public function isPublicRoom(param1:int, param2:int) : Boolean
      {
         return this.isPublicRoomWorldType(this.getWorldType(param1,param2));
      }
      
      public function getRoomNumberValue(param1:int, param2:int, param3:String) : Number
      {
         var _loc4_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc4_ != null)
         {
            return _loc4_.getNumber(param3);
         }
         return NaN;
      }
      
      public function getRoomStringValue(param1:int, param2:int, param3:String) : String
      {
         var _loc4_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc4_ != null)
         {
            return _loc4_.getString(param3);
         }
         return null;
      }
      
      public function setIsPlayingGame(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc4_ != null)
         {
            _loc5_ = !!param3 ? 1 : 0;
            _loc4_.setNumber(RoomVariableEnum.const_1423,_loc5_);
            if(_loc5_ == 0)
            {
               events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.const_574,param1,param2));
            }
            else
            {
               events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.const_550,param1,param2));
            }
         }
      }
      
      public function getIsPlayingGame(param1:int, param2:int) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc3_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getNumber(RoomVariableEnum.const_1423);
            if(_loc4_ > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getRoom(param1:int, param2:int) : IRoomInstance
      {
         if(!this.var_573)
         {
            return null;
         }
         var _loc3_:String = this.getRoomIdentifier(param1,param2);
         return this._roomManager.getRoom(_loc3_);
      }
      
      public function initializeRoom(param1:int, param2:int, param3:XML) : void
      {
         var _loc4_:String = this.getRoomIdentifier(param1,param2);
         var _loc5_:* = null;
         var _loc6_:String = "111";
         var _loc7_:String = "201";
         var _loc8_:String = "1";
         if(!this.var_573)
         {
            _loc5_ = this.var_400.remove(_loc4_);
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.floorType;
               _loc7_ = _loc5_.wallType;
               _loc8_ = _loc5_.landscapeType;
            }
            _loc5_ = new RoomData(param1,param2,param3);
            _loc5_.floorType = _loc6_;
            _loc5_.wallType = _loc7_;
            _loc5_.landscapeType = _loc8_;
            this.var_400.add(_loc4_,_loc5_);
            Logger.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
            return;
         }
         if(param3 == null)
         {
            Logger.log("Room property messages received before floor height map, will initialize when floor height map received.");
            return;
         }
         _loc5_ = this.var_400.remove(_loc4_);
         if(_loc5_ != null)
         {
            if(_loc5_.floorType != null && _loc5_.floorType.length > 0)
            {
               _loc6_ = _loc5_.floorType;
            }
            if(_loc5_.wallType != null && _loc5_.wallType.length > 0)
            {
               _loc7_ = _loc5_.wallType;
            }
            if(_loc5_.landscapeType != null && _loc5_.landscapeType.length > 0)
            {
               _loc8_ = _loc5_.landscapeType;
            }
         }
         var _loc9_:IRoomInstance = this.createRoom(_loc4_,param3,_loc6_,_loc7_,_loc8_,this.getWorldType(param1,param2));
         if(_loc9_ == null)
         {
            return;
         }
         events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.const_183,param1,param2));
      }
      
      private function createRoom(param1:String, param2:XML, param3:String, param4:String, param5:String, param6:String) : IRoomInstance
      {
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:* = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:* = null;
         var _loc30_:* = null;
         var _loc31_:* = null;
         if(!this.var_573)
         {
            return null;
         }
         var _loc7_:IRoomInstance = this._roomManager.createRoom(param1,param2);
         if(_loc7_ == null)
         {
            return null;
         }
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = 1;
         if(this.isPublicRoomWorldType(param6))
         {
            _loc11_ = this.var_14.getPublicRoomContentType(param6);
            _loc9_ = _loc7_.createRoomObject(const_392,_loc11_,_loc8_) as IRoomObjectController;
            _loc9_.getModelController().setString(RoomObjectVariableEnum.const_1407,param6,true);
            _loc7_.setNumber(RoomVariableEnum.const_993,1,true);
            _loc12_ = parseInt(this.var_156.getKey("ads.billboard.displayDelayMillis","1000"));
            _loc9_.getModelController().setNumber(RoomVariableEnum.const_1340,_loc12_,true);
            if(this.var_14 != null)
            {
               _loc10_ = Number(this.var_14.getPublicRoomWorldHeightScale(param6));
            }
         }
         else
         {
            _loc9_ = _loc7_.createRoomObject(const_392,const_707,_loc8_) as IRoomObjectController;
            _loc7_.setNumber(RoomVariableEnum.const_993,0,true);
         }
         _loc7_.setNumber(RoomVariableEnum.const_899,_loc10_,true);
         if(param2 != null)
         {
            _loc13_ = 0;
            if(param2.dimensions.length() == 1)
            {
               _loc14_ = param2.dimensions[0];
               _loc15_ = Number(_loc14_.@minX);
               _loc16_ = Number(_loc14_.@maxX);
               _loc17_ = Number(_loc14_.@minY);
               _loc18_ = Number(_loc14_.@maxY);
               _loc7_.setNumber(RoomVariableEnum.const_905,_loc15_);
               _loc7_.setNumber(RoomVariableEnum.const_852,_loc16_);
               _loc7_.setNumber(RoomVariableEnum.const_981,_loc17_);
               _loc7_.setNumber(RoomVariableEnum.const_986,_loc18_);
               _loc13_ += _loc15_ * 423 + _loc16_ * 671 + _loc17_ * 913 + _loc18_ * 7509;
               if(_loc9_ != null && _loc9_.getModelController() != null)
               {
                  _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_1305,_loc13_,true);
               }
            }
         }
         if(_loc9_ != null && _loc9_.getEventHandler() != null)
         {
            _loc9_.getEventHandler().initialize(param2);
            _loc19_ = null;
            if(param3 != null)
            {
               _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_934,param3);
               _loc9_.getEventHandler().processUpdateMessage(_loc19_);
               _loc7_.setString(RoomObjectVariableEnum.const_221,param3);
            }
            if(param4 != null)
            {
               _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_755,param4);
               _loc9_.getEventHandler().processUpdateMessage(_loc19_);
               _loc7_.setString(RoomObjectVariableEnum.const_217,param4);
            }
            if(param5 != null)
            {
               _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_985,param5);
               _loc9_.getEventHandler().processUpdateMessage(_loc19_);
               _loc7_.setString(RoomObjectVariableEnum.const_236,param5);
            }
            if(param2 != null)
            {
               if(param2.doors.door.length() > 0)
               {
                  _loc20_ = param2.doors.door;
                  _loc21_ = ["x","y","z","dir"];
                  _loc22_ = null;
                  _loc23_ = 0;
                  while(_loc23_ < _loc20_.length())
                  {
                     _loc24_ = _loc20_[_loc23_];
                     if(XMLValidator.checkRequiredAttributes(_loc24_,_loc21_))
                     {
                        _loc25_ = Number(_loc24_.@x);
                        _loc26_ = Number(_loc24_.@y);
                        _loc27_ = Number(_loc24_.@z);
                        _loc28_ = Number(_loc24_.@dir);
                        _loc29_ = "null";
                        _loc30_ = "door_" + _loc23_;
                        _loc31_ = new Vector3d(_loc25_,_loc26_,_loc27_);
                        _loc22_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.const_540,_loc30_,_loc29_,_loc31_,RoomObjectRoomMaskUpdateMessage.const_292);
                        _loc9_.getEventHandler().processUpdateMessage(_loc22_);
                        if(_loc28_ == 90 || _loc28_ == 180)
                        {
                           if(_loc28_ == 90)
                           {
                              _loc7_.setNumber(RoomObjectVariableEnum.const_938,_loc25_ - 0.5,true);
                              _loc7_.setNumber(RoomObjectVariableEnum.const_963,_loc26_,true);
                           }
                           if(_loc28_ == 180)
                           {
                              _loc7_.setNumber(RoomObjectVariableEnum.const_938,_loc25_,true);
                              _loc7_.setNumber(RoomObjectVariableEnum.const_963,_loc26_ - 0.5,true);
                           }
                           _loc7_.setNumber(RoomObjectVariableEnum.const_1367,_loc27_,true);
                           _loc7_.setNumber(RoomObjectVariableEnum.const_1211,_loc28_,true);
                        }
                     }
                     _loc23_++;
                  }
               }
            }
         }
         _loc7_.createRoomObject(const_1108,const_1603,RoomObjectCategoryEnum.const_383);
         if(this.var_156.getKey("avatar.widget.enabled","0") == "0")
         {
            _loc7_.createRoomObject(const_1106,const_1602,RoomObjectCategoryEnum.const_383);
         }
         return _loc7_;
      }
      
      public function getObjectRoom(param1:int, param2:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),const_392,RoomObjectCategoryEnum.const_82);
      }
      
      public function updateObjectRoom(param1:int, param2:int, param3:String = null, param4:String = null, param5:String = null, param6:Boolean = false) : Boolean
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc7_:IRoomObjectController = this.getObjectRoom(param1,param2);
         var _loc8_:IRoomInstance = this.getRoom(param1,param2);
         if(_loc7_ == null)
         {
            _loc10_ = this.getRoomIdentifier(param1,param2);
            _loc11_ = this.var_400.getValue(_loc10_);
            if(_loc11_ == null)
            {
               _loc11_ = new RoomData(param1,param2,null);
               this.var_400.add(_loc10_,_loc11_);
            }
            if(param3 != null)
            {
               _loc11_.floorType = param3;
            }
            if(param4 != null)
            {
               _loc11_.wallType = param4;
            }
            if(param5 != null)
            {
               _loc11_.landscapeType = param5;
            }
            return true;
         }
         if(_loc7_.getEventHandler() == null)
         {
            return false;
         }
         var _loc9_:* = null;
         if(param3 != null)
         {
            if(_loc8_ != null && !param6)
            {
               _loc8_.setString(RoomObjectVariableEnum.const_221,param3);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_934,param3);
            _loc7_.getEventHandler().processUpdateMessage(_loc9_);
         }
         if(param4 != null)
         {
            if(_loc8_ != null && !param6)
            {
               _loc8_.setString(RoomObjectVariableEnum.const_217,param4);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_755,param4);
            _loc7_.getEventHandler().processUpdateMessage(_loc9_);
         }
         if(param5 != null)
         {
            if(_loc8_ != null && !param6)
            {
               _loc8_.setString(RoomObjectVariableEnum.const_236,param5);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.const_985,param5);
            _loc7_.getEventHandler().processUpdateMessage(_loc9_);
         }
         return true;
      }
      
      public function updateObjectRoomColor(param1:int, param2:int, param3:uint, param4:int, param5:Boolean) : Boolean
      {
         var _loc6_:IRoomObjectController = this.getObjectRoom(param1,param2);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         var _loc7_:* = null;
         _loc7_ = new RoomObjectRoomColorUpdateMessage(RoomObjectRoomColorUpdateMessage.const_1960,param3,param4,param5);
         _loc6_.getEventHandler().processUpdateMessage(_loc7_);
         events.dispatchEvent(new RoomEngineRoomColorEvent(param1,param2,param3,param4,param5));
         return true;
      }
      
      public function updateObjectRoomVisibilities(param1:int, param2:int, param3:Boolean, param4:Boolean = true) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectRoom(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc6_:* = null;
         _loc6_ = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.const_1292,param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         _loc6_ = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.const_1240,param4);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function updateObjectRoomPlaneThicknesses(param1:int, param2:int, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectRoom(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc6_:* = null;
         _loc6_ = new RoomObjectRoomPlanePropertyUpdateMessage(RoomObjectRoomPlanePropertyUpdateMessage.const_1394,param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         _loc6_ = new RoomObjectRoomPlanePropertyUpdateMessage(RoomObjectRoomPlanePropertyUpdateMessage.const_729,param4);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function disposeRoom(param1:int, param2:int) : void
      {
         var _loc3_:String = this.getRoomIdentifier(param1,param2);
         this._roomManager.disposeRoom(_loc3_);
         var _loc4_:RoomInstanceData = this.var_289.remove(_loc3_);
         if(_loc4_ != null)
         {
            _loc4_.dispose();
         }
         events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.const_386,param1,param2));
      }
      
      public function setOwnUserId(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:RoomCamera = this.getRoomCamera(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.targetId = param3;
            _loc4_.targetCategory = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
         }
      }
      
      public function createRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : DisplayObject
      {
         var _loc12_:* = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc7_:String = this.getRoomIdentifier(param1,param2);
         var _loc8_:IRoomInstance = this._roomManager.getRoom(_loc7_);
         if(_loc8_ == null)
         {
            return null;
         }
         var _loc9_:IRoomRenderer = _loc8_.getRenderer() as IRoomRenderer;
         if(_loc9_ == null)
         {
            _loc9_ = this._roomRendererFactory.createRenderer();
         }
         if(_loc9_ == null)
         {
            return null;
         }
         _loc9_.roomObjectVariableAccurateZ = RoomObjectVariableEnum.const_1304;
         _loc8_.setRenderer(_loc9_);
         var _loc10_:IRoomRenderingCanvas = _loc9_.createCanvas(param3,param4,param5,param6);
         if(_loc10_ == null)
         {
            return null;
         }
         _loc10_.mouseListener = this.var_74;
         if(_loc10_.geometry != null)
         {
            _loc12_ = this.getWorldType(param1,param2);
            if(this.isPublicRoomWorldType(_loc12_))
            {
               if(this.var_14 != null)
               {
                  if(this.var_14.getPublicRoomWorldSize(_loc12_) != 64)
                  {
                     _loc10_.geometry.performZoomOut();
                  }
               }
            }
            _loc10_.geometry.z_scale = _loc8_.getNumber(RoomVariableEnum.const_899);
         }
         if(_loc10_.geometry != null)
         {
            _loc13_ = _loc8_.getNumber(RoomObjectVariableEnum.const_938);
            _loc14_ = _loc8_.getNumber(RoomObjectVariableEnum.const_963);
            _loc15_ = _loc8_.getNumber(RoomObjectVariableEnum.const_1367);
            _loc16_ = _loc8_.getNumber(RoomObjectVariableEnum.const_1211);
            _loc17_ = new Vector3d(_loc13_,_loc14_,_loc15_);
            _loc18_ = null;
            if(_loc16_ == 90)
            {
               _loc18_ = new Vector3d(-1000,0,0);
            }
            if(_loc16_ == 180)
            {
               _loc18_ = new Vector3d(0,-1000,0);
            }
            _loc10_.geometry.setDisplacement(_loc17_,_loc18_);
         }
         var _loc11_:Sprite = _loc10_.displayObject as Sprite;
         if(_loc11_ != null)
         {
            _loc19_ = new Sprite();
            _loc19_.name = OVERLAY_SPRITE;
            _loc19_.mouseEnabled = false;
            _loc11_.addChild(_loc19_);
         }
         return _loc11_;
      }
      
      private function getRoomCanvas(param1:int, param2:int, param3:int) : IRoomRenderingCanvas
      {
         var _loc4_:String = this.getRoomIdentifier(param1,param2);
         var _loc5_:IRoomInstance = this._roomManager.getRoom(_loc4_);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:IRoomRenderer = _loc5_.getRenderer() as IRoomRenderer;
         if(_loc6_ == null)
         {
            return null;
         }
         return _loc6_.getCanvas(param3);
      }
      
      public function modifyRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc6_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc6_ == null)
         {
            return false;
         }
         _loc6_.initialize(param4,param5);
         return true;
      }
      
      public function setRoomCanvasMask(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc5_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.useMask = param4;
      }
      
      private function getRoomCanvasRectangle(param1:int, param2:int, param3:int) : Rectangle
      {
         var _loc4_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc4_ == null)
         {
            return null;
         }
         return new Rectangle(0,0,_loc4_.width,_loc4_.height);
      }
      
      public function getRoomCanvasGeometry(param1:int, param2:int, param3:int) : IRoomGeometry
      {
         var _loc4_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.geometry;
      }
      
      public function getRoomCanvasScreenOffset(param1:int, param2:int, param3:int) : Point
      {
         var _loc4_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc4_ == null)
         {
            return null;
         }
         return new Point(_loc4_.screenOffsetX,_loc4_.screenOffsetY);
      }
      
      public function setRoomCanvasScreenOffset(param1:int, param2:int, param3:int, param4:Point) : Boolean
      {
         var _loc5_:IRoomRenderingCanvas = this.getRoomCanvas(param1,param2,param3);
         if(_loc5_ == null || param4 == null)
         {
            return false;
         }
         _loc5_.screenOffsetX = param4.x;
         _loc5_.screenOffsetY = param4.y;
         return true;
      }
      
      private function handleRoomDragging(param1:IRoomRenderingCanvas, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc8_:int = param2 - this.var_1590;
         var _loc9_:int = param3 - this.var_1589;
         if(param4 == MouseEvent.MOUSE_DOWN)
         {
            if(!param5 && !param6 && !param7)
            {
               this.var_838 = true;
               this.var_840 = false;
               this.var_2807 = this.var_1590;
               this.var_2810 = this.var_1589;
            }
         }
         else if(param4 == MouseEvent.MOUSE_UP)
         {
            if(this.var_838)
            {
               this.var_838 = false;
               if(this.var_840)
               {
                  _loc10_ = this.getRoomInstanceData(this.var_87,this.var_86);
                  if(_loc10_ != null)
                  {
                     _loc11_ = _loc10_.roomCamera;
                     if(_loc11_ != null)
                     {
                        if(this.useOffsetScrolling)
                        {
                           if(!_loc11_.isMoving)
                           {
                              _loc11_.centeredLocX = false;
                              _loc11_.centeredLocY = false;
                           }
                           _loc11_.resetLocation(new Vector3d(-param1.screenOffsetX,-param1.screenOffsetY));
                        }
                        if(this.var_2809)
                        {
                           _loc11_.reset();
                        }
                     }
                  }
               }
            }
         }
         else if(param4 == MouseEvent.MOUSE_MOVE)
         {
            if(this.var_838)
            {
               if(!this.var_840)
               {
                  _loc8_ = param2 - this.var_2807;
                  _loc9_ = param3 - this.var_2810;
                  if(_loc8_ <= -const_482 || _loc8_ >= const_482 || _loc9_ <= -const_482 || _loc9_ >= const_482)
                  {
                     this.var_840 = true;
                  }
                  _loc8_ = 0;
                  _loc9_ = 0;
               }
               if(_loc8_ != 0 || _loc9_ != 0)
               {
                  this.var_1588 += _loc8_;
                  this.var_1591 += _loc9_;
                  this.var_840 = true;
               }
            }
         }
         else if(param4 == MouseEvent.CLICK || param4 == MouseEvent.DOUBLE_CLICK)
         {
            this.var_838 = false;
            if(this.var_840)
            {
               this.var_840 = false;
               return true;
            }
         }
         return false;
      }
      
      public function handleRoomCanvasMouseEvent(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc9_:IRoomRenderingCanvas = this.getRoomCanvas(this.var_87,this.var_86,param1);
         if(_loc9_ != null)
         {
            _loc10_ = this.getOverlaySprite(_loc9_);
            _loc11_ = this.getOverlayIconSprite(_loc10_,const_393);
            if(_loc11_ != null)
            {
               _loc12_ = _loc11_.getRect(_loc11_);
               _loc11_.x = param2 - _loc12_.width / 2;
               _loc11_.y = param3 - _loc12_.height / 2;
            }
            if(!this.handleRoomDragging(_loc9_,param2,param3,param4,param5,param6,param7))
            {
               if(!_loc9_.handleMouseEvent(param2,param3,param4,param5,param6,param7,param8))
               {
                  _loc13_ = "";
                  if(param4 == MouseEvent.CLICK)
                  {
                     if(events != null)
                     {
                        events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_587,this.var_87,this.var_86,-1,RoomObjectCategoryEnum.const_153));
                     }
                     _loc13_ = "null";
                  }
                  else if(param4 == MouseEvent.MOUSE_MOVE)
                  {
                     _loc13_ = "null";
                  }
                  else if(param4 == MouseEvent.MOUSE_DOWN)
                  {
                     _loc13_ = "null";
                  }
                  if(this.var_74 != null)
                  {
                     _loc14_ = new RoomObjectMouseEvent(_loc13_,null,const_392,const_707);
                     this.var_74.handleRoomObjectEvent(_loc14_,this.var_87,this.var_86);
                  }
               }
            }
            this.var_1587 = param1;
            this.var_1590 = param2;
            this.var_1589 = param3;
         }
      }
      
      private function getOverlaySprite(param1:IRoomRenderingCanvas) : Sprite
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Sprite = param1.displayObject as Sprite;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getChildByName(OVERLAY_SPRITE) as Sprite;
      }
      
      private function addOverlayIconSprite(param1:Sprite, param2:String, param3:BitmapData) : Sprite
      {
         if(param1 == null || param3 == null)
         {
            return null;
         }
         var _loc4_:Sprite = this.getOverlayIconSprite(param1,param2);
         if(_loc4_ != null)
         {
            return null;
         }
         _loc4_ = new Sprite();
         _loc4_.name = param2;
         _loc4_.mouseEnabled = false;
         var _loc5_:Bitmap = new Bitmap(param3);
         _loc4_.addChild(_loc5_);
         param1.addChild(_loc4_);
         return _loc4_;
      }
      
      private function removeOverlayIconSprite(param1:Sprite, param2:String) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:int = param1.numChildren - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1.getChildAt(_loc3_) as Sprite;
            if(_loc4_ != null)
            {
               if(_loc4_.name == param2)
               {
                  param1.removeChildAt(_loc3_);
                  _loc5_ = _loc4_.getChildAt(0) as Bitmap;
                  if(_loc5_ != null && _loc5_.bitmapData != null)
                  {
                     _loc5_.bitmapData.dispose();
                     _loc5_.bitmapData = null;
                  }
                  return true;
               }
            }
            _loc3_--;
         }
         return false;
      }
      
      private function getOverlayIconSprite(param1:Sprite, param2:String) : Sprite
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = param1.numChildren - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1.getChildAt(_loc3_) as Sprite;
            if(_loc4_ != null)
            {
               if(_loc4_.name == param2)
               {
                  return _loc4_;
               }
            }
            _loc3_--;
         }
         return null;
      }
      
      public function setObjectMoverIconSprite(param1:int, param2:int, param3:Boolean, param4:String = null) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         if(param3)
         {
            _loc5_ = this.getRoomObjectImage(this.var_87,this.var_86,param1,param2,new Vector3d(),1,null);
         }
         else if(this.var_14 != null)
         {
            _loc7_ = null;
            _loc8_ = 0;
            if(param2 == RoomObjectCategoryEnum.const_27)
            {
               _loc7_ = this.var_14.getActiveObjectType(param1);
               _loc8_ = this.var_14.getActiveObjectColorIndex(param1);
            }
            else if(param2 == RoomObjectCategoryEnum.const_26)
            {
               _loc7_ = this.var_14.getWallItemType(param1,param4);
               _loc8_ = this.var_14.getWallItemColorIndex(param1);
            }
            if(param2 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
            {
               _loc7_ = this.getUserType(param1);
               if(_loc7_ == "pet")
               {
                  _loc7_ = this.getPetType(param4);
               }
               _loc5_ = this.getGenericRoomObjectImage(_loc7_,param4,new Vector3d(180),1,null);
            }
            else
            {
               _loc5_ = this.getGenericRoomObjectImage(_loc7_,String(_loc8_),new Vector3d(),1,null,0,param4);
            }
         }
         if(_loc5_ == null || _loc5_.data == null)
         {
            return;
         }
         var _loc6_:IRoomRenderingCanvas = this.getRoomCanvas(this.var_87,this.var_86,this.var_1587);
         if(_loc6_ != null)
         {
            _loc9_ = this.getOverlaySprite(_loc6_);
            this.removeOverlayIconSprite(_loc9_,const_393);
            _loc10_ = this.addOverlayIconSprite(_loc9_,const_393,_loc5_.data);
            if(_loc10_ != null)
            {
               _loc10_.x = this.var_1590 - _loc5_.data.width / 2;
               _loc10_.y = this.var_1589 - _loc5_.data.height / 2;
            }
         }
      }
      
      public function setObjectMoverIconSpriteVisible(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:IRoomRenderingCanvas = this.getRoomCanvas(this.var_87,this.var_86,this.var_1587);
         if(_loc2_ != null)
         {
            _loc3_ = this.getOverlaySprite(_loc2_);
            _loc4_ = this.getOverlayIconSprite(_loc3_,const_393);
            if(_loc4_ != null)
            {
               _loc4_.visible = param1;
            }
         }
      }
      
      public function removeObjectMoverIconSprite() : void
      {
         var _loc2_:* = null;
         var _loc1_:IRoomRenderingCanvas = this.getRoomCanvas(this.var_87,this.var_86,this.var_1587);
         if(_loc1_ != null)
         {
            _loc2_ = this.getOverlaySprite(_loc1_);
            this.removeOverlayIconSprite(_loc2_,const_393);
         }
      }
      
      public function getRoomObjectCount(param1:int, param2:int, param3:int) : int
      {
         if(!this.var_573)
         {
            return 0;
         }
         var _loc4_:String = this.getRoomIdentifier(param1,param2);
         var _loc5_:IRoomInstance = this._roomManager.getRoom(_loc4_);
         if(_loc5_ == null)
         {
            return 0;
         }
         return _loc5_.getObjectCount(param3);
      }
      
      public function getRoomObject(param1:int, param2:int, param3:int, param4:int) : IRoomObject
      {
         if(!this.var_573)
         {
            return null;
         }
         var _loc5_:String = this.getRoomIdentifier(param1,param2);
         return this.getObject(_loc5_,param3,param4);
      }
      
      public function getRoomObjectWithIndex(param1:int, param2:int, param3:int, param4:int) : IRoomObject
      {
         if(!this.var_573)
         {
            return null;
         }
         var _loc5_:String = this.getRoomIdentifier(param1,param2);
         var _loc6_:IRoomInstance = this._roomManager.getRoom(_loc5_);
         if(_loc6_ == null)
         {
            return null;
         }
         return _loc6_.getObjectWithIndex(param3,param4);
      }
      
      public function modifyRoomObject(param1:int, param2:int, param3:String) : Boolean
      {
         if(this.var_74 != null)
         {
            return this.var_74.modifyRoomObject(this.var_87,this.var_86,param1,param2,param3);
         }
         return false;
      }
      
      public function modifyRoomObjectDataWithMap(param1:int, param2:int, param3:String, param4:Map) : Boolean
      {
         if(this.var_74 != null)
         {
            if(param2 == RoomObjectCategoryEnum.const_27)
            {
               return this.var_74.modifyRoomObjectData(this.var_87,this.var_86,param1,param2,param3,param4);
            }
         }
         return false;
      }
      
      public function modifyRoomObjectData(param1:int, param2:int, param3:String) : Boolean
      {
         if(this.var_74 != null)
         {
            if(param2 == RoomObjectCategoryEnum.const_26)
            {
               return this.var_74.modifyWallItemData(this.var_87,this.var_86,param1,param3);
            }
         }
         return false;
      }
      
      public function deleteRoomObject(param1:int, param2:int) : Boolean
      {
         if(this.var_74 != null)
         {
            if(param2 == RoomObjectCategoryEnum.const_26)
            {
               return this.var_74.deleteWallItem(this.var_87,this.var_86,param1);
            }
         }
         return false;
      }
      
      public function initializeRoomObjectInsert(param1:int, param2:int, param3:int, param4:String = null) : Boolean
      {
         var _loc5_:IRoomInstance = this.getRoom(this.var_87,this.var_86);
         if(_loc5_ == null || _loc5_.getNumber(RoomVariableEnum.const_993) != 0)
         {
            return false;
         }
         if(this.var_74 != null)
         {
            return this.var_74.initializeRoomObjectInsert(this.var_87,this.var_86,param1,param2,param3,param4);
         }
         return false;
      }
      
      public function cancelRoomObjectInsert() : void
      {
         if(this.var_74 != null)
         {
            this.var_74.cancelRoomObjectInsert(this.var_87,this.var_86);
         }
      }
      
      public function useRoomObjectInActiveRoom(param1:int, param2:int) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:IRoomObject = this.getRoomObject(this.var_87,this.var_86,param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getMouseHandler() as IRoomObjectEventHandler;
            if(_loc4_ != null)
            {
               _loc4_.useObject();
               return true;
            }
         }
         return false;
      }
      
      private function getRoomObjectAdURL(param1:String) : String
      {
         if(this.var_14 != null)
         {
            return this.var_14.getRoomObjectAdURL(param1);
         }
         return "";
      }
      
      public function setRoomObjectAlias(param1:String, param2:String) : void
      {
         if(this.var_14 != null)
         {
            this.var_14.setRoomObjectAlias(param1,param2);
         }
      }
      
      public function getRoomObjectCategory(param1:String) : int
      {
         if(this.var_14 != null)
         {
            return this.var_14.getObjectCategory(param1);
         }
         return RoomObjectCategoryEnum.const_153;
      }
      
      public function getFurnitureType(param1:int) : String
      {
         if(this.var_14 != null)
         {
            return this.var_14.getActiveObjectType(param1);
         }
         return "";
      }
      
      public function getWallItemType(param1:int, param2:String = null) : String
      {
         if(this.var_14 != null)
         {
            return this.var_14.getWallItemType(param1,param2);
         }
         return "";
      }
      
      private function getUserType(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return "user";
            case 2:
               return "pet";
            case 3:
               return "bot";
            default:
               return null;
         }
      }
      
      private function getPetType(param1:String) : String
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length > 1)
            {
               _loc3_ = parseInt(_loc2_[0]);
               if(_loc3_ >= 8)
               {
                  if(this.var_14 != null)
                  {
                     return this.var_14.getPetType(_loc3_);
                  }
               }
               return "pet";
            }
         }
         return null;
      }
      
      public function getPetColor(param1:int, param2:int) : PetColorResult
      {
         if(this.var_14 != null)
         {
            return this.var_14.getPetColor(param1,param2);
         }
         return null;
      }
      
      private function getFurnitureColorIndex(param1:int) : int
      {
         if(this.var_14 != null)
         {
            return this.var_14.getActiveObjectColorIndex(param1);
         }
         return 0;
      }
      
      private function getWallItemColorIndex(param1:int) : int
      {
         if(this.var_14 != null)
         {
            return this.var_14.getWallItemColorIndex(param1);
         }
         return 0;
      }
      
      public function getSelectionArrow(param1:int, param2:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),const_1106,RoomObjectCategoryEnum.const_383);
      }
      
      public function getTileCursor(param1:int, param2:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),const_1108,RoomObjectCategoryEnum.const_383);
      }
      
      public function addObjectFurniture(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String, param9:Number = NaN, param10:int = -1, param11:Boolean = false) : Boolean
      {
         var _loc13_:* = null;
         var _loc12_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc12_ != null)
         {
            _loc13_ = new FurnitureData(param3,param4,null,param5,param6,param7,param8,param9,param10,param11);
            _loc12_.addFurnitureData(_loc13_);
         }
         return true;
      }
      
      public function addObjectFurnitureByName(param1:int, param2:int, param3:int, param4:String, param5:IVector3d, param6:IVector3d, param7:int, param8:String, param9:Number = NaN) : Boolean
      {
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc10_:String = this.getWorldType(param1,param2);
         if(this.isPublicRoomWorldType(_loc10_) && this.var_14 != null)
         {
            _loc12_ = this.var_14.getPublicRoomContentType(_loc10_) + "_";
            param4 = _loc12_ + param4;
         }
         var _loc11_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc11_ != null)
         {
            _loc13_ = new FurnitureData(param3,0,param4,param5,param6,param7,param8,param9,0);
            _loc11_.addFurnitureData(_loc13_);
         }
         return true;
      }
      
      private function addObjectFurnitureFromData(param1:int, param2:int, param3:int, param4:FurnitureData) : Boolean
      {
         var _loc11_:* = null;
         if(param4 == null)
         {
            _loc11_ = this.getRoomInstanceData(param1,param2);
            if(_loc11_ != null)
            {
               param4 = _loc11_.getFurnitureDataWithId(param3);
            }
         }
         if(param4 == null)
         {
            return false;
         }
         var _loc5_:Boolean = false;
         var _loc6_:String = param4.type;
         if(_loc6_ == null)
         {
            _loc6_ = this.getFurnitureType(param4.typeId);
            _loc5_ = true;
         }
         var _loc7_:int = this.getFurnitureColorIndex(param4.typeId);
         var _loc8_:String = this.getRoomObjectAdURL(_loc6_);
         if(_loc6_ == null)
         {
            _loc6_ = "";
         }
         var _loc9_:IRoomObjectController = this.createObjectFurniture(param1,param2,param3,_loc6_);
         if(_loc9_ == null)
         {
            return false;
         }
         if(_loc9_ != null && _loc9_.getModelController() != null && _loc5_)
         {
            _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_271,_loc7_,true);
            _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_306,param4.typeId,true);
            _loc9_.getModelController().setString(RoomObjectVariableEnum.const_404,_loc8_,true);
            _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_906,1,true);
            _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_1238,param4.expiryTime);
            _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_1358,getTimer());
            if(param4.knownAsUsable)
            {
               _loc9_.getModelController().setNumber(RoomObjectVariableEnum.const_901,1);
            }
         }
         if(!this.updateObjectFurniture(param1,param2,param3,param4.loc,param4.dir,param4.state,param4.data,param4.extra))
         {
            return false;
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_200,param1,param2,param3,RoomObjectCategoryEnum.const_27));
         }
         var _loc10_:ISelectedRoomObjectData = this.getPlacedObjectData(param1,param2);
         if(_loc10_ && Math.abs(_loc10_.id) == param3 && _loc10_.category == RoomObjectCategoryEnum.const_27)
         {
            this.selectRoomObject(param1,param2,param3,RoomObjectCategoryEnum.const_27);
         }
         return true;
      }
      
      public function changeObjectState(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:* = NaN;
         var _loc5_:IRoomObjectController = this.getObject(this.getRoomIdentifier(param1,param2),param3,param4);
         if(_loc5_ != null && _loc5_.getModelController() != null)
         {
            _loc6_ = Number(_loc5_.getModelController().getNumber(RoomObjectVariableEnum.const_1000));
            if(isNaN(_loc6_))
            {
               _loc6_ = 1;
            }
            else
            {
               _loc6_ += 1;
            }
            _loc5_.getModelController().setNumber(RoomObjectVariableEnum.const_1000,_loc6_);
         }
      }
      
      public function updateObjectFurniture(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String, param8:Number = NaN) : Boolean
      {
         var _loc9_:IRoomObjectController = this.getObjectFurniture(param1,param2,param3);
         if(_loc9_ == null)
         {
            return false;
         }
         var _loc10_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param4,param5);
         var _loc11_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param6,param7,param8);
         if(_loc9_ != null && _loc9_.getEventHandler() != null)
         {
            _loc9_.getEventHandler().processUpdateMessage(_loc10_);
            _loc9_.getEventHandler().processUpdateMessage(_loc11_);
         }
         return true;
      }
      
      public function updateObjectFurnitureLocation(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d) : Boolean
      {
         var _loc7_:* = null;
         var _loc6_:IRoomObjectController = this.getObjectFurniture(param1,param2,param3);
         if(_loc6_ == null)
         {
            return false;
         }
         if(_loc6_ != null && _loc6_.getEventHandler() != null)
         {
            _loc7_ = new RoomObjectMoveUpdateMessage(param4,param5,null,param5 != null);
            _loc6_.getEventHandler().processUpdateMessage(_loc7_);
         }
         return true;
      }
      
      private function createObjectFurniture(param1:int, param2:int, param3:int, param4:String) : IRoomObjectController
      {
         var _loc5_:int = 0;
         return this.createObject(this.getRoomIdentifier(param1,param2),param3,param4,_loc5_);
      }
      
      private function getObjectFurniture(param1:int, param2:int, param3:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.const_27);
      }
      
      public function disposeObjectFurniture(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.getFurnitureDataWithId(param3);
         }
         this.disposeObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.const_27);
         this.removeBtnMouseCursorOwner(RoomObjectCategoryEnum.const_27,param3);
      }
      
      public function addObjectWallItem(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String, param9:Boolean = false) : Boolean
      {
         var _loc11_:* = null;
         var _loc10_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc10_ != null)
         {
            _loc11_ = new FurnitureData(param3,param4,null,param5,param6,param7,param8,NaN,-1,param9);
            _loc10_.addWallItemData(_loc11_);
         }
         return true;
      }
      
      private function addObjectWallItemFromData(param1:int, param2:int, param3:int, param4:FurnitureData) : Boolean
      {
         var _loc10_:* = null;
         if(param4 == null)
         {
            _loc10_ = this.getRoomInstanceData(param1,param2);
            if(_loc10_ != null)
            {
               param4 = _loc10_.getWallItemDataWithId(param3);
            }
         }
         if(param4 == null)
         {
            return false;
         }
         var _loc5_:String = this.getWallItemType(param4.typeId,param4.data);
         var _loc6_:int = this.getWallItemColorIndex(param4.typeId);
         var _loc7_:String = this.getRoomObjectAdURL(_loc5_);
         if(_loc5_ == null)
         {
            _loc5_ = "";
         }
         var _loc8_:IRoomObjectController = this.createObjectWallItem(param1,param2,param3,_loc5_);
         if(_loc8_ == null)
         {
            return false;
         }
         if(_loc8_ != null && _loc8_.getModelController() != null)
         {
            _loc8_.getModelController().setNumber(RoomObjectVariableEnum.const_271,_loc6_,false);
            _loc8_.getModelController().setNumber(RoomObjectVariableEnum.const_306,param4.typeId,true);
            _loc8_.getModelController().setString(RoomObjectVariableEnum.const_404,_loc7_,true);
            _loc8_.getModelController().setNumber(RoomObjectVariableEnum.const_1304,1,true);
            if(param4.knownAsUsable)
            {
               _loc8_.getModelController().setNumber(RoomObjectVariableEnum.const_901,1);
            }
         }
         if(!this.updateObjectWallItem(param1,param2,param3,param4.loc,param4.dir,param4.state,param4.data))
         {
            return false;
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_200,param1,param2,param3,RoomObjectCategoryEnum.const_26));
         }
         var _loc9_:ISelectedRoomObjectData = this.getPlacedObjectData(param1,param2);
         if(_loc9_ && _loc9_.id == param3 && _loc9_.category == RoomObjectCategoryEnum.const_26)
         {
            this.selectRoomObject(param1,param2,param3,RoomObjectCategoryEnum.const_26);
         }
         return true;
      }
      
      public function updateObjectWallItem(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String) : Boolean
      {
         var _loc8_:IRoomObjectController = this.getObjectWallItem(param1,param2,param3);
         if(_loc8_ == null)
         {
            return false;
         }
         var _loc9_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param4,param5);
         var _loc10_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param6,param7);
         if(_loc8_ != null && _loc8_.getEventHandler() != null)
         {
            _loc8_.getEventHandler().processUpdateMessage(_loc9_);
            _loc8_.getEventHandler().processUpdateMessage(_loc10_);
         }
         this.updateObjectRoomWindow(param1,param2,param3);
         return true;
      }
      
      public function updateObjectRoomWindow(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc5_:String = "undefined_" + param3;
         var _loc6_:* = null;
         var _loc7_:IRoomObjectController = this.getObjectWallItem(param1,param2,param3);
         if(_loc7_ != null)
         {
            if(_loc7_.getModel() != null)
            {
               if(_loc7_.getModel().getNumber(RoomObjectVariableEnum.const_1330) > 0)
               {
                  _loc9_ = _loc7_.getModel().getString(RoomObjectVariableEnum.const_1413);
                  _loc10_ = _loc7_.getLocation();
                  if(param4)
                  {
                     _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.const_540,_loc5_,_loc9_,_loc10_);
                  }
                  else
                  {
                     _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.const_767,_loc5_);
                  }
               }
            }
         }
         else
         {
            _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.const_767,_loc5_);
         }
         var _loc8_:IRoomObjectController = this.getObjectRoom(param1,param2);
         if(_loc8_ != null && _loc8_.getEventHandler() != null && _loc6_ != null)
         {
            _loc8_.getEventHandler().processUpdateMessage(_loc6_);
         }
      }
      
      public function updateObjectWallItemData(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectWallItem(param1,param2,param3);
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc6_:RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(param4);
         if(_loc5_ != null && _loc5_.getEventHandler() != null)
         {
            _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         }
         return true;
      }
      
      private function createObjectWallItem(param1:int, param2:int, param3:int, param4:String) : IRoomObjectController
      {
         var _loc5_:int = 0;
         return this.createObject(this.getRoomIdentifier(param1,param2),param3,param4,_loc5_);
      }
      
      private function getObjectWallItem(param1:int, param2:int, param3:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.const_26);
      }
      
      public function updateObjectWallItemLocation(param1:int, param2:int, param3:int, param4:IVector3d) : Boolean
      {
         var _loc6_:* = null;
         var _loc5_:IRoomObjectController = this.getObjectWallItem(param1,param2,param3);
         if(_loc5_ == null)
         {
            return false;
         }
         if(_loc5_.getEventHandler() != null)
         {
            _loc6_ = new RoomObjectMoveUpdateMessage(param4,null,null);
            _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         }
         this.updateObjectRoomWindow(param1,param2,param3);
         return true;
      }
      
      public function disposeObjectWallItem(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:RoomInstanceData = this.getRoomInstanceData(param1,param2);
         if(_loc4_ != null)
         {
            _loc4_.getWallItemDataWithId(param3);
         }
         this.disposeObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.const_26);
         this.updateObjectRoomWindow(param1,param2,param3,false);
         this.removeBtnMouseCursorOwner(RoomObjectCategoryEnum.const_26,param3);
      }
      
      public function addObjectUser(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:Number, param7:int, param8:String = null) : Boolean
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         if(this.getObjectUser(param1,param2,param3) != null)
         {
            return false;
         }
         var _loc9_:String = this.getUserType(param7);
         if(_loc9_ == "pet")
         {
            _loc9_ = this.getPetType(param8);
         }
         var _loc10_:IRoomObjectController = this.createObjectUser(param1,param2,param3,_loc9_);
         if(_loc10_ == null)
         {
            return false;
         }
         if(_loc10_ != null && _loc10_.getEventHandler() != null)
         {
            _loc11_ = new RoomObjectAvatarUpdateMessage(param4,null,param5,param6);
            _loc10_.getEventHandler().processUpdateMessage(_loc11_);
            if(param8 != null)
            {
               _loc12_ = new RoomObjectAvatarFigureUpdateMessage(param8);
               _loc10_.getEventHandler().processUpdateMessage(_loc12_);
            }
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_200,param1,param2,param3,RoomObjectCategoryEnum.OBJECT_CATEGORY_USER));
         }
         return true;
      }
      
      public function updateObjectUser(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:IVector3d = null, param7:Number = NaN) : Boolean
      {
         var _loc8_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc8_ == null || _loc8_.getEventHandler() == null || _loc8_.getModel() == null)
         {
            return false;
         }
         if(param4 == null)
         {
            param4 = _loc8_.getLocation();
         }
         if(param6 == null)
         {
            param6 = _loc8_.getDirection();
         }
         if(isNaN(param7))
         {
            param7 = _loc8_.getModel().getNumber(RoomObjectVariableEnum.const_207);
         }
         var _loc9_:RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(param4,param5,param6,param7);
         _loc8_.getEventHandler().processUpdateMessage(_loc9_);
         return true;
      }
      
      public function updateObjectUserFlatControl(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc6_:RoomObjectUpdateStateMessage = new RoomObjectAvatarFlatControlUpdateMessage(param4);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function updateObjectUserFigure(param1:int, param2:int, param3:int, param4:String, param5:String = null, param6:String = null) : Boolean
      {
         var _loc7_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc7_ == null || _loc7_.getEventHandler() == null)
         {
            return false;
         }
         var _loc8_:RoomObjectUpdateStateMessage = new RoomObjectAvatarFigureUpdateMessage(param4,param5,param6);
         _loc7_.getEventHandler().processUpdateMessage(_loc8_);
         return true;
      }
      
      public function updateObjectUserAction(param1:int, param2:int, param3:int, param4:String, param5:int, param6:String = null) : Boolean
      {
         var _loc7_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc7_ == null || _loc7_.getEventHandler() == null)
         {
            return false;
         }
         var _loc8_:* = null;
         switch(param4)
         {
            case RoomObjectVariableEnum.const_192:
               _loc8_ = new RoomObjectAvatarChatUpdateMessage(param5);
               break;
            case RoomObjectVariableEnum.const_316:
               _loc8_ = new RoomObjectAvatarWaveUpdateMessage(param5 != 0);
               break;
            case RoomObjectVariableEnum.const_301:
               _loc8_ = new RoomObjectAvatarSleepUpdateMessage(param5 != 0);
               break;
            case RoomObjectVariableEnum.const_498:
               _loc8_ = new RoomObjectAvatarTypingUpdateMessage(param5 != 0);
               break;
            case RoomObjectVariableEnum.const_337:
               _loc8_ = new RoomObjectAvatarCarryObjectUpdateMessage(param5,param6);
               break;
            case RoomObjectVariableEnum.const_286:
               _loc8_ = new RoomObjectAvatarUseObjectUpdateMessage(param5);
               break;
            case RoomObjectVariableEnum.const_666:
               _loc8_ = new RoomObjectAvatarDanceUpdateMessage(param5);
               break;
            case RoomObjectVariableEnum.const_402:
               _loc8_ = new RoomObjectAvatarExperienceUpdateMessage(param5);
               break;
            case RoomObjectVariableEnum.const_444:
               _loc8_ = new RoomObjectAvatarPlayerValueUpdateMessage(param5);
               break;
            case RoomObjectVariableEnum.const_399:
               _loc8_ = new RoomObjectAvatarSignUpdateMessage(param5);
         }
         _loc7_.getEventHandler().processUpdateMessage(_loc8_);
         return true;
      }
      
      public function updateObjectUserPosture(param1:int, param2:int, param3:int, param4:String, param5:String = "") : Boolean
      {
         var _loc6_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         var _loc7_:RoomObjectUpdateStateMessage = new RoomObjectAvatarPostureUpdateMessage(param4,param5);
         _loc6_.getEventHandler().processUpdateMessage(_loc7_);
         return true;
      }
      
      public function updateObjectUserGesture(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc6_:RoomObjectUpdateStateMessage = new RoomObjectAvatarGestureUpdateMessage(param4);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function updateObjectPetGesture(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         var _loc5_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc6_:RoomObjectUpdateStateMessage = new RoomObjectAvatarPetGestureUpdateMessage(param4);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function updateObjectUserEffect(param1:int, param2:int, param3:int, param4:int, param5:int = 0) : Boolean
      {
         var _loc6_:IRoomObjectController = this.getObjectUser(param1,param2,param3);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         _loc6_.getEventHandler().processUpdateMessage(new RoomObjectAvatarEffectUpdateMessage(param4,param5));
         return true;
      }
      
      private function createObjectUser(param1:int, param2:int, param3:int, param4:String) : IRoomObjectController
      {
         var _loc5_:int = 0;
         return this.createObject(this.getRoomIdentifier(param1,param2),param3,param4,_loc5_);
      }
      
      private function getObjectUser(param1:int, param2:int, param3:int) : IRoomObjectController
      {
         return this.getObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
      }
      
      public function disposeObjectUser(param1:int, param2:int, param3:int) : void
      {
         this.disposeObject(this.getRoomIdentifier(param1,param2),param3,RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
      }
      
      private function createObject(param1:String, param2:int, param3:String, param4:int) : IRoomObjectController
      {
         var _loc5_:IRoomInstance = this._roomManager.getRoom(param1);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:* = null;
         return _loc5_.createRoomObject(param2,param3,param4) as IRoomObjectController;
      }
      
      private function getObject(param1:String, param2:int, param3:int) : IRoomObjectController
      {
         var _loc4_:* = null;
         if(this._roomManager != null)
         {
            _loc4_ = this._roomManager.getRoom(param1);
         }
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:* = null;
         _loc5_ = _loc4_.getObject(param2,param3) as IRoomObjectController;
         if(_loc5_ == null)
         {
            if(param3 == RoomObjectCategoryEnum.const_27)
            {
               this.addObjectFurnitureFromData(this.getRoomId(param1),this.getRoomCategory(param1),param2,null);
               _loc5_ = _loc4_.getObject(param2,param3) as IRoomObjectController;
            }
            else if(param3 == RoomObjectCategoryEnum.const_26)
            {
               this.addObjectWallItemFromData(this.getRoomId(param1),this.getRoomCategory(param1),param2,null);
               _loc5_ = _loc4_.getObject(param2,param3) as IRoomObjectController;
            }
         }
         return _loc5_;
      }
      
      private function disposeObject(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         if(this._roomManager != null)
         {
            _loc4_ = this._roomManager.getRoom(param1);
            if(_loc4_ == null)
            {
               return;
            }
            if(_loc4_.disposeObject(param2,param3))
            {
               if(events != null)
               {
                  events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_436,this.var_87,this.var_86,param2,param3));
               }
            }
         }
      }
      
      private function roomObjectEventHandler(param1:RoomObjectEvent) : void
      {
         if(this.var_74 != null)
         {
            this.var_74.handleRoomObjectEvent(param1,this.var_87,this.var_86);
         }
      }
      
      public function getFurnitureIcon(param1:int, param2:IGetImageListener, param3:String = null) : ImageResult
      {
         return this.getFurnitureImage(param1,new Vector3d(),1,param2,0,param3);
      }
      
      public function getWallItemIcon(param1:int, param2:IGetImageListener, param3:String = null) : ImageResult
      {
         return this.getWallItemImage(param1,new Vector3d(),1,param2,0,param3);
      }
      
      public function getFurnitureImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1) : ImageResult
      {
         var _loc9_:* = null;
         var _loc10_:String = "";
         if(this.var_14 != null)
         {
            _loc9_ = this.var_14.getActiveObjectType(param1);
            _loc10_ = String(this.var_14.getActiveObjectColorIndex(param1));
         }
         return this.getGenericRoomObjectImage(_loc9_,_loc10_,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getPetImage(param1:int, param2:int, param3:IVector3d, param4:int, param5:IGetImageListener, param6:uint = 0) : ImageResult
      {
         var _loc7_:* = null;
         var _loc8_:* = param2 + "";
         if(this.var_14 != null)
         {
            _loc7_ = this.var_14.getPetType(param1);
         }
         return this.getGenericRoomObjectImage(_loc7_,_loc8_,param3,param4,param5,param6);
      }
      
      public function getWallItemImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1) : ImageResult
      {
         var _loc9_:* = null;
         var _loc10_:String = "";
         if(this.var_14 != null)
         {
            _loc9_ = this.var_14.getWallItemType(param1,param6);
            _loc10_ = String(this.var_14.getWallItemColorIndex(param1));
         }
         return this.getGenericRoomObjectImage(_loc9_,_loc10_,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getRoomImage(param1:String, param2:String, param3:String, param4:int, param5:IGetImageListener, param6:String = null) : ImageResult
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2 == null)
         {
            param2 = "";
         }
         if(param3 == null)
         {
            param3 = "";
         }
         var _loc7_:String = const_707;
         var _loc8_:* = param1 + "\n" + param2 + "\n" + param3 + "\n";
         if(param6 != null)
         {
            _loc8_ += param6;
         }
         return this.getGenericRoomObjectImage(_loc7_,_loc8_,new Vector3d(),param4,param5);
      }
      
      public function getRoomObjectImage(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:int, param7:IGetImageListener, param8:uint = 0) : ImageResult
      {
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc9_:* = null;
         var _loc10_:String = "";
         var _loc12_:String = this.getRoomIdentifier(param1,param2);
         var _loc13_:IRoomInstance = this._roomManager.getRoom(_loc12_);
         if(_loc13_ != null)
         {
            _loc14_ = _loc13_.getObject(param3,param4);
            if(_loc14_ != null && _loc14_.getModel() != null)
            {
               _loc9_ = _loc14_.getType();
               switch(param4)
               {
                  case RoomObjectCategoryEnum.const_27:
                  case RoomObjectCategoryEnum.const_26:
                     _loc10_ = String(_loc14_.getModel().getNumber(RoomObjectVariableEnum.const_271));
                     _loc11_ = _loc14_.getModel().getString(RoomObjectVariableEnum.const_371);
                     break;
                  case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                     _loc10_ = _loc14_.getModel().getString(RoomObjectVariableEnum.const_226);
               }
            }
         }
         return this.getGenericRoomObjectImage(_loc9_,_loc10_,param5,param6,param7,param8,_loc11_);
      }
      
      private function initializeRoomForGettingImage(param1:IRoomObjectController, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = null;
         if(param2 != null)
         {
            _loc3_ = param2.split("\n");
            if(_loc3_.length >= 3)
            {
               _loc4_ = _loc3_[0];
               _loc5_ = _loc3_[1];
               _loc6_ = _loc3_[2];
               _loc7_ = _loc3_[3];
               _loc8_ = 6;
               _loc9_ = new RoomPlaneParser();
               _loc9_.initializeTileMap(_loc8_ + 2,_loc8_ + 2);
               _loc10_ = 1;
               while(_loc10_ < 1 + _loc8_)
               {
                  _loc12_ = 1;
                  while(_loc12_ < 1 + _loc8_)
                  {
                     _loc9_.setTileHeight(_loc12_,_loc10_,0);
                     _loc12_++;
                  }
                  _loc10_++;
               }
               _loc9_.wallHeight = _loc8_;
               _loc9_.initializeFromTileData();
               _loc11_ = _loc9_.getXML();
               param1.getEventHandler().initialize(_loc11_);
               param1.getModelController().setString(RoomObjectVariableEnum.const_221,_loc4_);
               param1.getModelController().setString(RoomObjectVariableEnum.const_217,_loc5_);
               param1.getModelController().setString(RoomObjectVariableEnum.const_236,_loc6_);
               if(_loc7_ != null)
               {
                  _loc13_ = null;
                  _loc14_ = "undefined_1";
                  _loc13_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.const_540,_loc14_,_loc7_,new Vector3d(2.5,0.5,2));
                  param1.getEventHandler().processUpdateMessage(_loc13_);
               }
               _loc9_.dispose();
            }
         }
      }
      
      public function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:IGetImageListener, param6:uint = 0, param7:String = null, param8:int = -1, param9:int = -1) : ImageResult
      {
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc10_:ImageResult = new ImageResult();
         _loc10_.id = -1;
         if(!this.var_573 || param1 == null)
         {
            return _loc10_;
         }
         var _loc11_:IRoomInstance = this._roomManager.getRoom(const_706);
         if(_loc11_ == null)
         {
            _loc11_ = this._roomManager.createRoom(const_706,null);
            if(_loc11_ == null)
            {
               return _loc10_;
            }
         }
         var _loc12_:int = this.var_841.reserveNumber();
         var _loc13_:int = this.getRoomObjectCategory(param1);
         if(_loc12_ < 0)
         {
            return _loc10_;
         }
         _loc12_ += 1;
         var _loc14_:IRoomObjectController = _loc11_.createRoomObject(_loc12_,param1,_loc13_) as IRoomObjectController;
         if(_loc14_ == null || _loc14_.getModelController() == null || _loc14_.getEventHandler() == null)
         {
            return _loc10_;
         }
         switch(_loc13_)
         {
            case RoomObjectCategoryEnum.const_27:
            case RoomObjectCategoryEnum.const_26:
               _loc14_.getModelController().setNumber(RoomObjectVariableEnum.const_271,int(param2));
               _loc14_.getModelController().setString(RoomObjectVariableEnum.const_371,param7);
               break;
            case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
               if(param1 == "user" || param1 == "bot" || param1 == "pet")
               {
                  _loc14_.getModelController().setString(RoomObjectVariableEnum.const_226,param2);
               }
               else
               {
                  _loc14_.getModelController().setNumber(RoomObjectVariableEnum.const_1011,int(param2));
               }
               break;
            case RoomObjectCategoryEnum.const_82:
               this.initializeRoomForGettingImage(_loc14_,param2);
         }
         _loc14_.setDirection(param3);
         var _loc15_:* = null;
         _loc15_ = _loc14_.getVisualization() as IRoomObjectSpriteVisualization;
         if(_loc15_ == null)
         {
            _loc11_.disposeObject(_loc12_,_loc13_);
            return _loc10_;
         }
         if(param8 > -1)
         {
            _loc18_ = _loc14_.getModel().getString(RoomObjectVariableEnum.const_103);
            _loc19_ = new RoomObjectDataUpdateMessage(param8,_loc18_);
            if(_loc14_.getEventHandler() != null)
            {
               _loc14_.getEventHandler().processUpdateMessage(_loc19_);
            }
         }
         var _loc16_:RoomGeometry = new RoomGeometry(param4,new Vector3d(-135,30,0),new Vector3d(11,11,5));
         _loc15_.update(_loc16_,0,true,false);
         if(param9 > 0)
         {
            _loc20_ = 0;
            while(_loc20_ < param9)
            {
               _loc15_.update(_loc16_,0,true,false);
               _loc20_++;
            }
         }
         var _loc17_:BitmapData = _loc15_.getImage(param6);
         _loc10_.data = _loc17_;
         _loc10_.id = _loc12_;
         if(!this.isRoomObjectContentAvailable(param1) && param5 != null)
         {
            this.var_1295.add(String(_loc12_),param5);
            _loc14_.getModelController().setNumber(RoomObjectVariableEnum.const_1333,param4,true);
         }
         else
         {
            _loc11_.disposeObject(_loc12_,_loc13_);
            this.var_841.freeNumber(_loc12_ - 1);
            _loc10_.id = 0;
         }
         _loc16_.dispose();
         return _loc10_;
      }
      
      public function getRoomObjectBoundingRectangle(param1:int, param2:int, param3:int, param4:int, param5:int) : Rectangle
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc6_:IRoomGeometry = this.getRoomCanvasGeometry(param1,param2,param5);
         if(_loc6_ != null)
         {
            _loc7_ = this.getRoomObject(param1,param2,param3,param4);
            if(_loc7_ != null)
            {
               _loc8_ = _loc7_.getVisualization();
               if(_loc8_ != null)
               {
                  _loc9_ = _loc8_.boundingRectangle;
                  _loc10_ = _loc6_.getScreenPoint(_loc7_.getLocation());
                  if(_loc10_ != null)
                  {
                     _loc9_.offset(_loc10_.x,_loc10_.y);
                     _loc11_ = this.getRoomCanvas(param1,param2,param5);
                     if(_loc11_ != null)
                     {
                        _loc9_.offset(_loc11_.width / 2 + _loc11_.screenOffsetX,_loc11_.height / 2 + _loc11_.screenOffsetY);
                        return _loc9_;
                     }
                  }
               }
            }
         }
         return null;
      }
      
      public function getRoomObjectScreenLocation(param1:int, param2:int, param3:int, param4:int, param5:int) : Point
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc6_:IRoomGeometry = this.getRoomCanvasGeometry(param1,param2,param5);
         if(_loc6_ != null)
         {
            _loc7_ = this.getRoomObject(param1,param2,param3,param4);
            if(_loc7_ != null)
            {
               _loc8_ = _loc6_.getScreenPoint(_loc7_.getLocation());
               if(_loc8_ != null)
               {
                  _loc9_ = this.getRoomCanvas(param1,param2,param5);
                  if(_loc9_ != null)
                  {
                     _loc8_.offset(_loc9_.width / 2 + _loc9_.screenOffsetX,_loc9_.height / 2 + _loc9_.screenOffsetY);
                  }
                  return _loc8_;
               }
            }
         }
         return null;
      }
      
      public function getActiveRoomBoundingRectangle(param1:int) : Rectangle
      {
         return this.getRoomObjectBoundingRectangle(this.var_87,this.var_86,const_392,RoomObjectCategoryEnum.const_82,param1);
      }
      
      public function isRoomObjectContentAvailable(param1:String) : Boolean
      {
         return this._roomManager.isContentAvailable(param1);
      }
      
      public function contentLoaded(param1:String, param2:Boolean = false) : void
      {
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:Number = NaN;
         var _loc3_:IRoomInstance = this._roomManager.getRoom(const_706);
         if(_loc3_ == null)
         {
            return;
         }
         if(this.var_14 == null)
         {
            return;
         }
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:int = this.var_14.getObjectCategory(param1);
         var _loc7_:int = _loc3_.getObjectCount(_loc6_);
         var _loc8_:int = _loc7_ - 1;
         while(_loc8_ >= 0)
         {
            _loc9_ = _loc3_.getObjectWithIndex(_loc8_,_loc6_);
            if(_loc9_ != null && _loc9_.getModel() != null && _loc9_.getType() == param1)
            {
               _loc10_ = _loc9_.getId();
               _loc11_ = null;
               _loc12_ = null;
               _loc12_ = _loc9_.getVisualization() as IRoomObjectSpriteVisualization;
               if(_loc12_ != null)
               {
                  _loc14_ = _loc9_.getModel().getNumber(RoomObjectVariableEnum.const_1333);
                  if(_loc4_ != null && _loc5_ != _loc14_)
                  {
                     _loc4_.dispose();
                     _loc4_ = null;
                  }
                  if(_loc4_ == null)
                  {
                     _loc5_ = Number(_loc14_);
                     _loc4_ = new RoomGeometry(_loc14_,new Vector3d(-135,30,0),new Vector3d(11,11,5));
                  }
                  _loc12_.update(_loc4_,0,true,false);
                  _loc11_ = _loc12_.image;
               }
               _loc3_.disposeObject(_loc10_,_loc6_);
               this.var_841.freeNumber(_loc10_ - 1);
               _loc13_ = this.var_1295.remove(String(_loc10_)) as IGetImageListener;
               if(_loc13_ != null && _loc11_ != null)
               {
                  _loc13_.imageReady(_loc10_,_loc11_);
               }
               else if(_loc11_ != null)
               {
                  _loc11_.dispose();
               }
            }
            _loc8_--;
         }
         if(_loc4_ != null)
         {
            _loc4_.dispose();
         }
      }
      
      public function objectInitialized(param1:String, param2:int, param3:int) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc4_:int = this.getRoomId(param1);
         var _loc5_:int = this.getRoomCategory(param1);
         if(param3 == RoomObjectCategoryEnum.const_26)
         {
            this.updateObjectRoomWindow(_loc4_,_loc5_,param2);
         }
         var _loc6_:IRoomObjectController = this.getRoomObject(_loc4_,_loc5_,param2,param3) as IRoomObjectController;
         if(_loc6_ != null && _loc6_.getModel() != null && _loc6_.getEventHandler() != null)
         {
            _loc7_ = _loc6_.getModel().getString(RoomObjectVariableEnum.const_103);
            if(_loc7_ != null)
            {
               _loc8_ = _loc6_.getState(0);
               _loc9_ = new RoomObjectDataUpdateMessage(_loc8_,_loc7_);
               _loc6_.getEventHandler().processUpdateMessage(_loc9_);
            }
            if(events != null)
            {
               events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_946,_loc4_,_loc5_,param2,param3));
            }
         }
      }
      
      public function selectAvatar(param1:int, param2:int, param3:int) : void
      {
         if(this.var_74 != null)
         {
            this.var_74.setSelectedAvatar(param1,param2,param3,true);
         }
      }
      
      public function getSelectedAvatarId() : int
      {
         if(this.var_74 != null)
         {
            return this.var_74.getSelectedAvatarId();
         }
         return -1;
      }
      
      public function selectRoomObject(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(this.var_74 == null)
         {
            return;
         }
         this.var_74.setSelectedObject(param1,param2,param3,param4);
      }
      
      public function loadRoomResources(param1:String) : Array
      {
         if(this.var_14 != null)
         {
            return this.var_14.loadLegacyContent(param1,events);
         }
         return new Array();
      }
      
      private function showRoomAd(param1:AdEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(this.var_14 != null)
         {
            _loc2_ = this.getWorldType(param1.roomId,param1.roomCategory);
            this.var_14.addGraphicAsset(this.var_14.getPublicRoomContentType(_loc2_),RoomObjectVariableEnum.const_416,param1.image,true);
            this.var_14.addGraphicAsset(this.var_14.getPublicRoomContentType(_loc2_),RoomObjectVariableEnum.const_1382,param1.adWarningL,true);
            this.var_14.addGraphicAsset(this.var_14.getPublicRoomContentType(_loc2_),RoomObjectVariableEnum.const_1264,param1.adWarningR,true);
            _loc3_ = this.getObjectRoom(param1.roomId,param1.roomCategory);
            if(_loc3_ == null)
            {
               return;
            }
            _loc4_ = null;
            _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.const_1282,RoomObjectVariableEnum.const_416,param1.clickUrl);
            _loc3_.getEventHandler().processUpdateMessage(_loc4_);
         }
      }
      
      public function requestRoomAdImage(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String) : void
      {
         if(this.var_337 != null)
         {
            this.var_337.loadRoomAdImage(param1,param2,param3,param4,param5,param6);
         }
      }
      
      private function onRoomAdImageLoaded(param1:AdEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:IRoomObjectController = this.getObjectRoom(param1.roomId,param1.roomCategory);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomObjectController = this.getObjectFurniture(param1.roomId,param1.roomCategory,param1.objectId);
         if(_loc3_ == null || _loc3_.getEventHandler() == null)
         {
            return;
         }
         if(param1.image != null)
         {
            this.var_14.addGraphicAsset(_loc3_.getType(),param1.imageUrl,param1.image,true);
         }
         switch(param1.type)
         {
            case AdEvent.const_855:
               _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.const_1400,param1.imageUrl,param1.clickUrl,param1.objectId,param1.image);
               break;
            case AdEvent.const_1311:
               _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.const_1281,param1.imageUrl,param1.clickUrl,param1.objectId,param1.image);
         }
         if(_loc4_ != null)
         {
            _loc3_.getEventHandler().processUpdateMessage(_loc4_);
         }
      }
      
      public function insertContentLibrary(param1:int, param2:int, param3:IAssetLibrary) : Boolean
      {
         return this.var_14.insertObjectContent(param1,param2,param3);
      }
      
      public function setActiveObjectType(param1:int, param2:String) : void
      {
         this.var_14.setActiveObjectType(param1,param2);
      }
   }
}
