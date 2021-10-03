package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetUpdateRoomPreviewEvent extends Event
   {
       
      
      private var var_1655:String = "com.sulake.habbo.communication.messages.outgoing.help";
      
      private var _floorType:String = "com.sulake.habbo.communication.messages.outgoing.help";
      
      private var var_1656:String = "1.1";
      
      private var _tileSize:int = 64;
      
      public function CatalogWidgetUpdateRoomPreviewEvent(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW,param5,param6);
         this._floorType = param1;
         this.var_1655 = param2;
         this.var_1656 = param3;
         this._tileSize = param4;
      }
      
      public function get wallType() : String
      {
         return this.var_1655;
      }
      
      public function get floorType() : String
      {
         return this._floorType;
      }
      
      public function get landscapeType() : String
      {
         return this.var_1656;
      }
      
      public function get tileSize() : int
      {
         return this._tileSize;
      }
   }
}
