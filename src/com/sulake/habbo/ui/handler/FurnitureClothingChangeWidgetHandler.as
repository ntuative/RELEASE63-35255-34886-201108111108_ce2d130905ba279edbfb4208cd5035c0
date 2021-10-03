package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.IHabboAvatarEditorDataSaver;
   import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
   import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureClothingChangeWidgetHandler implements IRoomWidgetHandler, IHabboAvatarEditorDataSaver
   {
      
      private static const const_1737:String = "hd-99999-99999.lg-270-62";
      
      private static const const_1738:String = "hd-99999-99999.ch-630-62.lg-695-62";
       
      
      private var var_1173:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_236:int = -1;
      
      public function FurnitureClothingChangeWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_564;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function dispose() : void
      {
         if(this._container && this._container.avatarEditor)
         {
            this._container.avatarEditor.close(AvatarEditorInstanceId.const_452);
         }
         this.var_1173 = true;
         this._container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetFurniToWidgetMessage.const_956,RoomWidgetClothingChangeMessage.const_813,RoomWidgetAvatarEditorMessage.const_567];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         switch(param1.type)
         {
            case RoomWidgetFurniToWidgetMessage.const_956:
               _loc5_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc2_ = this._container.roomEngine.getRoomObject(_loc5_.roomId,_loc5_.roomCategory,_loc5_.id,_loc5_.category);
               if(_loc2_ != null)
               {
                  _loc3_ = _loc2_.getModel();
                  if(_loc3_ != null)
                  {
                     _loc7_ = this._container.roomSession.isRoomOwner || this._container.sessionDataManager.isAnyRoomController;
                     if(_loc7_)
                     {
                        _loc4_ = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.const_409,_loc5_.id,_loc5_.category,_loc5_.roomId,_loc5_.roomCategory);
                        this._container.events.dispatchEvent(_loc4_);
                     }
                  }
               }
               break;
            case RoomWidgetClothingChangeMessage.const_813:
               _loc6_ = param1 as RoomWidgetClothingChangeMessage;
               _loc2_ = this._container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.roomCategory,_loc6_.objectId,_loc6_.objectCategory);
               if(_loc2_ != null)
               {
                  _loc3_ = _loc2_.getModel();
                  if(_loc3_ != null)
                  {
                     this.var_236 = _loc6_.objectId;
                     _loc8_ = "null";
                     _loc9_ = _loc3_.getString(RoomObjectVariableEnum.const_1425);
                     if(_loc9_ == null || _loc9_ == "")
                     {
                        _loc9_ = const_1737;
                     }
                     if(_loc6_.gender == FigureData.FEMALE)
                     {
                        _loc8_ = "null";
                        _loc9_ = _loc3_.getString(RoomObjectVariableEnum.const_1384);
                        if(_loc9_ == null || _loc9_ == "")
                        {
                           _loc9_ = const_1738;
                        }
                     }
                     if(this._container.avatarEditor.openEditor(AvatarEditorInstanceId.const_452,this,[AvatarEditorFigureCategory.const_257,AvatarEditorFigureCategory.const_962],false,"${widget.furni.clothingchange.editor.title}"))
                     {
                        this._container.avatarEditor.loadAvatarInEditor(AvatarEditorInstanceId.const_452,_loc9_,_loc8_,HabboClubLevelEnum.const_52);
                        _loc4_ = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.const_409,_loc6_.objectId,_loc6_.objectCategory,_loc6_.roomId,_loc6_.roomCategory);
                        this._container.events.dispatchEvent(_loc4_);
                     }
                  }
               }
         }
         return null;
      }
      
      public function update() : void
      {
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function saveFigure(param1:String, param2:String) : void
      {
         if(this._container == null)
         {
            return;
         }
         this._container.roomSession.sendUpdateClothingChangeFurniture(this.var_236,param2,param1);
         this._container.avatarEditor.close(AvatarEditorInstanceId.const_452);
      }
   }
}
