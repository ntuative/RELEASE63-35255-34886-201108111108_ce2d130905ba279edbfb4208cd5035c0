package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   import com.sulake.habbo.communication.messages.incoming.navigator.MsgWithRequestId;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.utils.Dictionary;
   
   public class NavigatorData
   {
      
      private static const const_2118:int = 10;
       
      
      private var _navigator:HabboNavigator;
      
      private var var_223:MsgWithRequestId;
      
      private var var_689:RoomEventData;
      
      private var var_2740:Boolean;
      
      private var var_2733:Boolean;
      
      private var _currentRoomOwner:Boolean;
      
      private var var_2456:int;
      
      private var var_283:GuestRoomData;
      
      private var var_1042:PublicRoomShortData;
      
      private var var_2736:int;
      
      private var var_2741:Boolean;
      
      private var var_2737:int;
      
      private var var_2739:Boolean;
      
      private var var_1943:int;
      
      private var var_2732:Boolean;
      
      private var var_1537:Array;
      
      private var var_1559:Array;
      
      private var var_2734:int;
      
      private var var_1558:int;
      
      private var _favouriteIds:Dictionary;
      
      private var var_1264:Boolean;
      
      private var var_2738:int;
      
      private var var_2735:Boolean;
      
      private var var_2742:int = 0;
      
      private var var_1942:OfficialRoomEntryData;
      
      public function NavigatorData(param1:HabboNavigator)
      {
         this.var_1537 = new Array();
         this.var_1559 = new Array();
         this._favouriteIds = new Dictionary();
         super();
         this._navigator = param1;
      }
      
      public function get canAddFavourite() : Boolean
      {
         return this.var_283 != null && !this._currentRoomOwner;
      }
      
      public function get canEditRoomSettings() : Boolean
      {
         return this.var_283 != null && this._currentRoomOwner;
      }
      
      public function onRoomEnter(param1:RoomEntryInfoMessageParser) : void
      {
         this.var_1042 = null;
         this.var_283 = null;
         this._currentRoomOwner = false;
         if(param1.privateRoom)
         {
            this._currentRoomOwner = param1.owner;
         }
         else
         {
            this.var_1042 = param1.publicSpace;
            this.var_689 = null;
         }
      }
      
      public function onRoomExit() : void
      {
         if(this.var_689 != null)
         {
            this.var_689.dispose();
            this.var_689 = null;
         }
         if(this.var_1042 != null)
         {
            this.var_1042.dispose();
            this.var_1042 = null;
         }
         if(this.var_283 != null)
         {
            this.var_283.dispose();
            this.var_283 = null;
         }
         this._currentRoomOwner = false;
      }
      
      public function set enteredRoom(param1:GuestRoomData) : void
      {
         if(this.var_283 != null)
         {
            this.var_283.dispose();
         }
         this.var_283 = param1;
      }
      
      public function set roomEventData(param1:RoomEventData) : void
      {
         if(this.var_689 != null)
         {
            this.var_689.dispose();
         }
         this.var_689 = param1;
      }
      
      public function get popularTagsArrived() : Boolean
      {
         return this.var_223 != null && this.var_223 as PopularRoomTagsData != null;
      }
      
      public function get guestRoomSearchArrived() : Boolean
      {
         return this.var_223 != null && this.var_223 as GuestRoomSearchResultData != null;
      }
      
      public function get officialRoomsArrived() : Boolean
      {
         return this.var_223 != null && this.var_223 as OfficialRoomsData != null;
      }
      
      public function set guestRoomSearchResults(param1:GuestRoomSearchResultData) : void
      {
         this.disposeCurrentMsg();
         this.var_223 = param1;
         this.var_1942 = param1.ad;
         this.var_1264 = false;
      }
      
      public function set popularTags(param1:PopularRoomTagsData) : void
      {
         this.disposeCurrentMsg();
         this.var_223 = param1;
         this.var_1264 = false;
      }
      
      public function set officialRooms(param1:OfficialRoomsData) : void
      {
         this.disposeCurrentMsg();
         this.var_223 = param1;
         this.var_1264 = false;
      }
      
      private function disposeCurrentMsg() : void
      {
         if(this.var_223 == null)
         {
            return;
         }
         this.var_223.dispose();
         this.var_223 = null;
      }
      
      public function set adRoom(param1:OfficialRoomEntryData) : void
      {
         this.var_1942 = param1;
      }
      
      public function get adRoom() : OfficialRoomEntryData
      {
         return this.var_1942;
      }
      
      public function get guestRoomSearchResults() : GuestRoomSearchResultData
      {
         return this.var_223 as GuestRoomSearchResultData;
      }
      
      public function get popularTags() : PopularRoomTagsData
      {
         return this.var_223 as PopularRoomTagsData;
      }
      
      public function get officialRooms() : OfficialRoomsData
      {
         return this.var_223 as OfficialRoomsData;
      }
      
      public function get roomEventData() : RoomEventData
      {
         return this.var_689;
      }
      
      public function get avatarId() : int
      {
         return this.var_2456;
      }
      
      public function get eventMod() : Boolean
      {
         return this.var_2740;
      }
      
      public function get roomPicker() : Boolean
      {
         return this.var_2733;
      }
      
      public function get currentRoomOwner() : Boolean
      {
         return this._currentRoomOwner;
      }
      
      public function get enteredGuestRoom() : GuestRoomData
      {
         return this.var_283;
      }
      
      public function get enteredPublicSpace() : PublicRoomShortData
      {
         return this.var_1042;
      }
      
      public function get hcMember() : Boolean
      {
         return this.var_2741;
      }
      
      public function get createdFlatId() : int
      {
         return this.var_2737;
      }
      
      public function get homeRoomId() : int
      {
         return this.var_1943;
      }
      
      public function get hotRoomPopupOpen() : Boolean
      {
         return this.var_2739;
      }
      
      public function get currentRoomRating() : int
      {
         return this.var_2738;
      }
      
      public function get publicSpaceNodeId() : int
      {
         return this.var_2736;
      }
      
      public function get settingsReceived() : Boolean
      {
         return this.var_2732;
      }
      
      public function get adIndex() : int
      {
         return this.var_2742;
      }
      
      public function get currentRoomIsStaffPick() : Boolean
      {
         return this.var_2735;
      }
      
      public function set avatarId(param1:int) : void
      {
         this.var_2456 = param1;
      }
      
      public function set createdFlatId(param1:int) : void
      {
         this.var_2737 = param1;
      }
      
      public function set hcMember(param1:Boolean) : void
      {
         this.var_2741 = param1;
      }
      
      public function set eventMod(param1:Boolean) : void
      {
         this.var_2740 = param1;
      }
      
      public function set roomPicker(param1:Boolean) : void
      {
         this.var_2733 = param1;
      }
      
      public function set hotRoomPopupOpen(param1:Boolean) : void
      {
         this.var_2739 = param1;
      }
      
      public function set homeRoomId(param1:int) : void
      {
         this.var_1943 = param1;
      }
      
      public function set currentRoomRating(param1:int) : void
      {
         this.var_2738 = param1;
      }
      
      public function set publicSpaceNodeId(param1:int) : void
      {
         this.var_2736 = param1;
      }
      
      public function set settingsReceived(param1:Boolean) : void
      {
         this.var_2732 = param1;
      }
      
      public function set adIndex(param1:int) : void
      {
         this.var_2742 = param1;
      }
      
      public function set currentRoomIsStaffPick(param1:Boolean) : void
      {
         this.var_2735 = param1;
      }
      
      public function set categories(param1:Array) : void
      {
         var _loc2_:* = null;
         this.var_1537 = param1;
         this.var_1559 = new Array();
         for each(_loc2_ in this.var_1537)
         {
            if(_loc2_.visible)
            {
               this.var_1559.push(_loc2_);
            }
         }
      }
      
      public function get allCategories() : Array
      {
         return this.var_1537;
      }
      
      public function get visibleCategories() : Array
      {
         return this.var_1559;
      }
      
      public function onFavourites(param1:FavouritesMessageParser) : void
      {
         var _loc2_:int = 0;
         this.var_2734 = param1.limit;
         this.var_1558 = param1.favouriteRoomIds.length;
         this._favouriteIds = new Dictionary();
         for each(_loc2_ in param1.favouriteRoomIds)
         {
            this._favouriteIds[_loc2_] = "yes";
         }
      }
      
      public function favouriteChanged(param1:int, param2:Boolean) : void
      {
         this._favouriteIds[param1] = !!param2 ? "yes" : null;
         this.var_1558 += !!param2 ? 1 : -1;
      }
      
      public function isCurrentRoomFavourite() : Boolean
      {
         var _loc1_:int = this.var_283.flatId;
         return this._favouriteIds[_loc1_] != null;
      }
      
      public function isCurrentRoomHome() : Boolean
      {
         if(this.var_283 == null)
         {
            return false;
         }
         var _loc1_:int = this.var_283.flatId;
         return this.var_1943 == _loc1_;
      }
      
      public function isRoomFavourite(param1:int) : Boolean
      {
         return this._favouriteIds[param1] != null;
      }
      
      public function isFavouritesFull() : Boolean
      {
         return this.var_1558 >= this.var_2734;
      }
      
      public function startLoading() : void
      {
         this.var_1264 = true;
      }
      
      public function isLoading() : Boolean
      {
         return this.var_1264;
      }
   }
}
