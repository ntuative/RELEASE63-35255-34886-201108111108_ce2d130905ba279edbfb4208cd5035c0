package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFurniToWidgetMessage extends RoomWidgetMessage
   {
      
      public static const const_869:String = "RWFWM_MESSAGE_REQUEST_CREDITFURNI";
      
      public static const const_751:String = "RWFWM_MESSAGE_REQUEST_STICKIE";
      
      public static const const_908:String = "RWFWM_MESSAGE_REQUEST_PRESENT";
      
      public static const const_914:String = "RWFWM_MESSAGE_REQUEST_TROPHY";
      
      public static const const_907:String = "RWFWM_MESSAGE_REQUEST_TEASER";
      
      public static const WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET:String = "RWFWM_MESSAGE_REQUEST_ECOTRONBOX";
      
      public static const const_944:String = "RWFWM_MESSAGE_REQUEST_DIMMER";
      
      public static const const_1327:String = "RWFWM_MESSAGE_REQUEST_PLACEHOLDER";
      
      public static const const_956:String = "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE";
      
      public static const const_1023:String = "RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR";
       
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function RoomWidgetFurniToWidgetMessage(param1:String, param2:int, param3:int, param4:int, param5:int)
      {
         super(param1);
         this._id = param2;
         this._category = param3;
         this._roomId = param4;
         this._roomCategory = param5;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
   }
}
