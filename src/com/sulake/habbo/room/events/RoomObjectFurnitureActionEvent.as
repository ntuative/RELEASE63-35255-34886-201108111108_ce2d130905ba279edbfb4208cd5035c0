package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   
   public class RoomObjectFurnitureActionEvent extends RoomObjectEvent
   {
      
      public static const const_620:String = "ROFCAE_DICE_OFF";
      
      public static const const_655:String = "ROFCAE_DICE_ACTIVATE";
      
      public static const const_634:String = "ROFCAE_USE_HABBOWHEEL";
      
      public static const const_594:String = "ROFCAE_STICKIE";
      
      public static const const_610:String = "ROFCAE_VIRAL_GIFT";
      
      public static const const_580:String = "ROFCAE_ENTER_ONEWAYDOOR";
      
      public static const const_545:String = "ROFCAE_QUEST_VENDING";
      
      public static const const_519:String = "ROFCAE_SOUND_MACHINE_INIT";
      
      public static const const_530:String = "ROFCAE_SOUND_MACHINE_START";
      
      public static const const_563:String = "ROFCAE_SOUND_MACHINE_STOP";
      
      public static const const_650:String = "ROFCAE_SOUND_MACHINE_DISPOSE";
      
      public static const const_676:String = "ROFCAE_JUKEBOX_INIT";
      
      public static const const_504:String = "ROFCAE_JUKEBOX_START";
      
      public static const const_591:String = "ROFCAE_JUKEBOX_MACHINE_STOP";
      
      public static const const_494:String = "ROFCAE_JUKEBOX_DISPOSE";
      
      public static const const_305:String = "ROFCAE_MOUSE_BUTTON";
      
      public static const const_367:String = "ROFCAE_MOUSE_ARROW";
       
      
      public function RoomObjectFurnitureActionEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
