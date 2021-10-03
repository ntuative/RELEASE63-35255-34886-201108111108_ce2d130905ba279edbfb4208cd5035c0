package
{
   import com.sulake.bootstrap.RoomSessionManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import mx.core.SimpleApplication;
   
   public class HabboRoomSessionManagerLib extends SimpleApplication
   {
      
      public static var manifest:Class = HabboRoomSessionManagerLib_manifest;
      
      public static var requiredClasses:Array = new Array(RoomSessionManager,IIDHabboRoomSessionManager);
       
      
      public function HabboRoomSessionManagerLib()
      {
         super();
      }
   }
}
