package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class FriendRequestUpdateEvent extends Event
   {
      
      public static const const_741:String = "FBE_REQUESTS";
       
      
      public function FriendRequestUpdateEvent()
      {
         super(const_741,false,false);
      }
   }
}
