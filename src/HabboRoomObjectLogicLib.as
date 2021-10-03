package
{
   import com.sulake.bootstrap.RoomObjectFactory;
   import com.sulake.iid.IIDRoomObjectFactory;
   import mx.core.SimpleApplication;
   
   public class HabboRoomObjectLogicLib extends SimpleApplication
   {
      
      public static var manifest:Class = HabboRoomObjectLogicLib_manifest;
      
      public static var requiredClasses:Array = new Array(RoomObjectFactory,IIDRoomObjectFactory);
       
      
      public function HabboRoomObjectLogicLib()
      {
         super();
      }
   }
}
