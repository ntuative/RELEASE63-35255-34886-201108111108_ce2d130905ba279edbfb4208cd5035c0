package
{
   import com.sulake.bootstrap.RoomRendererFactory;
   import com.sulake.iid.IIDRoomRendererFactory;
   import mx.core.SimpleApplication;
   
   public class RoomSpriteRendererLib extends SimpleApplication
   {
      
      public static var manifest:Class = RoomSpriteRendererLib_manifest;
      
      public static var requiredClasses:Array = new Array(RoomRendererFactory,IIDRoomRendererFactory);
       
      
      public function RoomSpriteRendererLib()
      {
         super();
      }
   }
}
