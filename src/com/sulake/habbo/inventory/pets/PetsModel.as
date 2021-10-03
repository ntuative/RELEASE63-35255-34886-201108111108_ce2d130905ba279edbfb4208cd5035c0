package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
   import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectTypeEnum;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   
   public class PetsModel implements IInventoryModel
   {
       
      
      private var var_26:HabboInventory;
      
      private var _view:PetsView;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _pets:Map;
      
      private var var_1958:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_2504:Boolean;
      
      private var var_569:Array;
      
      private var _furniModel:FurniModel;
      
      public function PetsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:IRoomEngine, param7:IAvatarRenderManager, param8:IHabboCatalog)
      {
         super();
         this.var_26 = param1;
         this._assets = param4;
         this._communication = param3;
         this._roomEngine = param6;
         this._roomEngine.events.addEventListener(RoomEngineObjectEvent.const_163,this.onObjectPlaced);
         this._catalog = param8;
         this._pets = new Map();
         this.var_569 = [];
         this._view = new PetsView(this,param2,param4,param5,param6,param7);
      }
      
      public function set furniModel(param1:FurniModel) : void
      {
         this._furniModel = param1;
      }
      
      public function get furniModel() : FurniModel
      {
         return this._furniModel;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(this._view)
            {
               this._view.dispose();
               this._view = null;
            }
            if(this._roomEngine)
            {
               if(this._roomEngine.events)
               {
                  this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.const_163,this.onObjectPlaced);
               }
               this._roomEngine = null;
            }
            if(this._pets)
            {
               this._pets.dispose();
               this._pets = null;
            }
            this.var_26 = null;
            this._catalog = null;
            this._assets = null;
            this._communication = null;
            this.var_569 = null;
            this._disposed = true;
         }
      }
      
      public function isListInitialized() : Boolean
      {
         return this.var_2504;
      }
      
      public function setListInitialized() : void
      {
         this.var_2504 = true;
         this._view.updateState();
      }
      
      public function requestPetInventory() : void
      {
         if(this._communication == null)
         {
            return;
         }
         var _loc1_:IConnection = this._communication.getHabboMainConnection(null);
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new GetPetInventoryComposer());
      }
      
      public function requestCatalogOpen() : void
      {
         this._catalog.openCatalog();
      }
      
      public function get pets() : Map
      {
         return this._pets;
      }
      
      public function addPet(param1:PetData) : void
      {
         if(this._pets.add(param1.id,param1))
         {
            this._view.addPet(param1);
         }
         this._view.updateState();
      }
      
      public function removePet(param1:int) : void
      {
         this._pets.remove(param1);
         this._view.removePet(param1);
         this._view.updateState();
      }
      
      public function requestInitialization(param1:int = 0) : void
      {
         this.requestPetInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == InventoryCategory.const_138 && this.var_26.isVisible)
         {
            this._view.updateCategoryButtons();
            this.var_26.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_PETS));
         }
      }
      
      public function switchToFurnitureCategory(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:FurniModel = this.var_26.furniModel;
         if(_loc3_ != null)
         {
            _loc3_.switchCategory(param1);
            this.var_26.toggleInventoryPage(InventoryCategory.const_74,param2);
         }
         this.resetUnseenItems();
      }
      
      public function refreshViews() : void
      {
         this._view.update();
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return this._view.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(this._view.isVisible)
         {
            this.resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PetData = this.getPetById(param1);
         if(_loc3_ == null)
         {
            return;
         }
         if(this.var_26.roomSession.isRoomOwner)
         {
            this.var_1958 = this._roomEngine.initializeRoomObjectInsert(_loc3_.id,RoomObjectCategoryEnum.OBJECT_CATEGORY_USER,RoomObjectTypeEnum.const_237,_loc3_.figureString);
            this.var_26.closeView();
            return;
         }
         if(!this.var_26.roomSession.arePetsAllowed)
         {
            return;
         }
         if(!param2)
         {
            this._communication.getHabboMainConnection(null).send(new PlacePetMessageComposer(_loc3_.id,0,0));
         }
      }
      
      public function updateView() : void
      {
         if(this._view == null)
         {
            return;
         }
         this._view.update();
      }
      
      private function getPetById(param1:int) : PetData
      {
         var _loc2_:* = null;
         for each(_loc2_ in this._pets)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.var_1958 && param1.type == RoomEngineObjectEvent.const_163)
         {
            this.var_26.showView();
            this.var_1958 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return this.var_26.roomSession;
      }
      
      public function updatePetsAllowed() : void
      {
         this._view.update();
      }
      
      public function addUnseenPets(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            if(this.var_569.indexOf(_loc2_) == -1)
            {
               this.var_569.push(_loc2_);
            }
         }
         this._view.update();
      }
      
      public function resetUnseenItems() : void
      {
         if(!this.var_26.isMainViewActive)
         {
            return;
         }
         var _loc1_:IConnection = this._communication.getHabboMainConnection(null);
         if(this.var_569 && this.var_569.length > 0)
         {
            _loc1_.send(new ResetUnseenItemsComposer(UnseenItemCategoryEnum.const_55));
            this.var_569 = [];
            this._view.update();
            this.var_26.updateUnseenItemCounts();
         }
      }
      
      public function getUnseenItemCount() : int
      {
         return this.var_569.length;
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return this.var_569.indexOf(param1) > -1;
      }
   }
}
