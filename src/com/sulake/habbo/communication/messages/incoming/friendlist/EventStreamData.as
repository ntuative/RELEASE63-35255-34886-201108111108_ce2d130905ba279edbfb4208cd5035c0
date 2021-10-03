package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class EventStreamData
   {
      
      public static const const_1017:uint = 0;
      
      public static const const_1380:uint = 1;
      
      public static const const_1001:uint = 2;
      
      public static const const_1329:uint = 3;
      
      public static const const_1882:uint = 3;
      
      public static const const_2050:int = 0;
      
      public static const const_1409:int = 1;
      
      public static const const_1779:int = 2;
      
      public static const const_1817:int = 3;
      
      public static const LINK_TARGET_OPEN_MOTTO_CHANGER:int = 4;
      
      public static const const_1849:int = 5;
       
      
      private var _id:int;
      
      private var var_2761:int;
      
      private var var_2758:String;
      
      private var var_2759:String;
      
      private var var_2764:String;
      
      private var var_1337:String;
      
      private var var_2760:int;
      
      private var var_2762:int;
      
      private var var_2757:int;
      
      private var var_2765:Boolean;
      
      private var var_2763:Object;
      
      public function EventStreamData(param1:int, param2:int, param3:String, param4:String, param5:String, param6:String, param7:int, param8:int, param9:int, param10:Boolean, param11:IMessageDataWrapper)
      {
         super();
         this._id = param1;
         this.var_2761 = param2;
         this.var_2758 = param3;
         this.var_2759 = param4;
         this.var_2764 = param5;
         this.var_1337 = param6;
         this.var_2760 = param7;
         this.var_2762 = param8;
         this.var_2757 = param9;
         this.var_2765 = param10;
         this.var_2763 = parse(param2,param11);
      }
      
      protected static function parse(param1:int, param2:IMessageDataWrapper) : Object
      {
         var _loc3_:Object = new Object();
         switch(param1)
         {
            case const_1017:
               _loc3_.friendId = param2.readString();
               _loc3_.friendName = param2.readString();
               break;
            case const_1380:
               _loc3_.roomId = param2.readString();
               _loc3_.roomName = param2.readString();
               break;
            case const_1001:
               _loc3_.achievementCode = param2.readString();
               break;
            case const_1329:
               _loc3_.motto = param2.readString();
         }
         return _loc3_;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get actionId() : int
      {
         return this.var_2761;
      }
      
      public function get accountId() : String
      {
         return this.var_2758;
      }
      
      public function get accountName() : String
      {
         return this.var_2759;
      }
      
      public function get imageFilePath() : String
      {
         return this.var_1337;
      }
      
      public function get minutesSinceEvent() : int
      {
         return this.var_2760;
      }
      
      public function get linkTargetType() : int
      {
         return this.var_2762;
      }
      
      public function get numberOfLikes() : int
      {
         return this.var_2757;
      }
      
      public function get isLikable() : Boolean
      {
         return this.var_2765;
      }
      
      public function get extraDataStruct() : Object
      {
         return this.var_2763;
      }
      
      public function get accountGender() : String
      {
         return this.var_2764;
      }
   }
}

class Struct
{
    
   
   function Struct()
   {
      super();
   }
}

class FriendMadeStruct extends Struct
{
    
   
   public var friendId:String;
   
   public var friendName:String;
   
   function FriendMadeStruct(param1:String, param2:String)
   {
      super();
      this.friendId = param1;
      this.friendName = param2;
   }
}

class RoomLikedStruct extends Struct
{
    
   
   public var roomId:String;
   
   public var roomName:String;
   
   function RoomLikedStruct(param1:String, param2:String)
   {
      super();
      this.roomId = param1;
      this.roomName = param2;
   }
}

class AchievementEarnedStruct extends Struct
{
    
   
   public var achievementCode:String;
   
   function AchievementEarnedStruct(param1:String)
   {
      super();
      this.achievementCode = param1;
   }
}
