package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionViralFurniStatusEvent extends RoomSessionEvent
   {
      
      public static const const_664:String = "RSVFS_STATUS";
      
      public static const const_647:String = "RSVFS_RECEIVED";
       
      
      private var var_206:String;
      
      private var var_236:int;
      
      private var var_438:int = -1;
      
      private var _shareId:String;
      
      private var var_2316:String;
      
      private var var_2317:Boolean;
      
      private var var_1615:int = 0;
      
      public function RoomSessionViralFurniStatusEvent(param1:String, param2:IRoomSession, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
         this.var_438 = this.status;
         this._shareId = this.shareId;
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      public function get shareId() : String
      {
         return this._shareId;
      }
      
      public function get firstClickUserName() : String
      {
         return this.var_2316;
      }
      
      public function get giftWasReceived() : Boolean
      {
         return this.var_2317;
      }
      
      public function get itemCategory() : int
      {
         return this.var_1615;
      }
      
      public function set objectId(param1:int) : void
      {
         this.var_236 = param1;
      }
      
      public function set status(param1:int) : void
      {
         this.var_438 = param1;
      }
      
      public function set shareId(param1:String) : void
      {
         this._shareId = param1;
      }
      
      public function set firstClickUserName(param1:String) : void
      {
         this.var_2316 = param1;
      }
      
      public function set giftWasReceived(param1:Boolean) : void
      {
         this.var_2317 = param1;
      }
      
      public function set itemCategory(param1:int) : void
      {
         this.var_1615 = param1;
      }
      
      public function get campaignID() : String
      {
         return this.var_206;
      }
      
      public function set campaignID(param1:String) : void
      {
         this.var_206 = param1;
      }
   }
}
