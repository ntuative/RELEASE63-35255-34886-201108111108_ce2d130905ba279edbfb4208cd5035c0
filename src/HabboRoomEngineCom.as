package
{
   import com.sulake.bootstrap.RoomEngine;
   import com.sulake.iid.IIDRoomEngine;
   import mx.core.SimpleApplication;
   
   public class HabboRoomEngineCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboRoomEngineCom_manifest;
      
      public static var requiredClasses:Array = new Array(RoomEngine,IIDRoomEngine);
       
      
      public function HabboRoomEngineCom()
      {
         super();
      }
   }
}
