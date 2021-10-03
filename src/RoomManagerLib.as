package
{
   import com.sulake.bootstrap.RoomManager;
   import com.sulake.iid.IIDRoomManager;
   import mx.core.SimpleApplication;
   
   public class RoomManagerLib extends SimpleApplication
   {
      
      public static var manifest:Class = RoomManagerLib_manifest;
      
      public static var requiredClasses:Array = new Array(RoomManager,IIDRoomManager);
       
      
      public function RoomManagerLib()
      {
         super();
      }
   }
}
