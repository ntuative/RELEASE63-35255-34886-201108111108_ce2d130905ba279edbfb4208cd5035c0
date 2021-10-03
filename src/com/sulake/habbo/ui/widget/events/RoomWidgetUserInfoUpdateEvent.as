package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_111:String = "RWUIUE_OWN_USER";
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const const_161:String = "RWUIUE_PEER";
      
      public static const TRADE_REASON_OK:int = 0;
      
      public static const const_818:int = 2;
      
      public static const const_932:int = 3;
      
      public static const const_1888:String = "BOT";
       
      
      private var _name:String = "";
      
      private var var_1815:String = "";
      
      private var var_2341:int;
      
      private var var_2338:int = 0;
      
      private var var_2336:int = 0;
      
      private var var_727:String = "";
      
      private var var_49:BitmapData = null;
      
      private var var_253:Array;
      
      private var var_2550:int = 0;
      
      private var var_2546:String = "";
      
      private var var_2544:int = 0;
      
      private var var_2549:int = 0;
      
      private var var_2203:Boolean = false;
      
      private var _realName:String = "";
      
      private var var_2293:Boolean = false;
      
      private var var_2540:Boolean = false;
      
      private var var_2541:Boolean = true;
      
      private var var_1414:int = 0;
      
      private var var_2539:Boolean = false;
      
      private var var_2547:Boolean = false;
      
      private var var_2538:Boolean = false;
      
      private var var_2545:Boolean = false;
      
      private var var_2542:Boolean = false;
      
      private var var_2548:Boolean = false;
      
      private var var_2543:int = 0;
      
      private var var_2201:Boolean = false;
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         this.var_253 = [];
         super(param1,param2,param3);
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set motto(param1:String) : void
      {
         this.var_1815 = param1;
      }
      
      public function get motto() : String
      {
         return this.var_1815;
      }
      
      public function set achievementScore(param1:int) : void
      {
         this.var_2341 = param1;
      }
      
      public function get achievementScore() : int
      {
         return this.var_2341;
      }
      
      public function set webID(param1:int) : void
      {
         this.var_2338 = param1;
      }
      
      public function get webID() : int
      {
         return this.var_2338;
      }
      
      public function set xp(param1:int) : void
      {
         this.var_2336 = param1;
      }
      
      public function get xp() : int
      {
         return this.var_2336;
      }
      
      public function set figure(param1:String) : void
      {
         this.var_727 = param1;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function set image(param1:BitmapData) : void
      {
         this.var_49 = param1;
      }
      
      public function get image() : BitmapData
      {
         return this.var_49;
      }
      
      public function set badges(param1:Array) : void
      {
         this.var_253 = param1;
      }
      
      public function get badges() : Array
      {
         return this.var_253;
      }
      
      public function set groupId(param1:int) : void
      {
         this.var_2550 = param1;
      }
      
      public function get groupId() : int
      {
         return this.var_2550;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         this.var_2546 = param1;
      }
      
      public function get groupBadgeId() : String
      {
         return this.var_2546;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         this.var_2540 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return this.var_2540;
      }
      
      public function set respectLeft(param1:int) : void
      {
         this.var_1414 = param1;
      }
      
      public function get respectLeft() : int
      {
         return this.var_1414;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         this.var_2539 = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return this.var_2539;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         this.var_2547 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return this.var_2547;
      }
      
      public function set amIController(param1:Boolean) : void
      {
         this.var_2538 = param1;
      }
      
      public function get amIController() : Boolean
      {
         return this.var_2538;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         this.var_2545 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return this.var_2545;
      }
      
      public function set hasFlatControl(param1:Boolean) : void
      {
         this.var_2542 = param1;
      }
      
      public function get hasFlatControl() : Boolean
      {
         return this.var_2542;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         this.var_2548 = param1;
      }
      
      public function get canTrade() : Boolean
      {
         return this.var_2548;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         this.var_2543 = param1;
      }
      
      public function get canTradeReason() : int
      {
         return this.var_2543;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         this.var_2541 = param1;
      }
      
      public function get canBeKicked() : Boolean
      {
         return this.var_2541;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         this.var_2201 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return this.var_2201;
      }
      
      public function set carryItem(param1:int) : void
      {
         this.var_2544 = param1;
      }
      
      public function get carryItem() : int
      {
         return this.var_2544;
      }
      
      public function set userRoomId(param1:int) : void
      {
         this.var_2549 = param1;
      }
      
      public function get userRoomId() : int
      {
         return this.var_2549;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         this.var_2203 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return this.var_2203;
      }
      
      public function set realName(param1:String) : void
      {
         this._realName = param1;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         this.var_2293 = param1;
      }
      
      public function get allowNameChange() : Boolean
      {
         return this.var_2293;
      }
   }
}
