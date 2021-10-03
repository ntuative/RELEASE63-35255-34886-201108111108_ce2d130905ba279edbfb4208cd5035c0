package
{
   import com.sulake.bootstrap.RoomObjectVisualizationFactory;
   import com.sulake.iid.IIDRoomObjectVisualizationFactory;
   import mx.core.SimpleApplication;
   
   public class HabboRoomObjectVisualizationLib extends SimpleApplication
   {
      
      public static var manifest:Class = HabboRoomObjectVisualizationLib_manifest;
      
      public static var pet_experience_bubble_png:Class = HabboRoomObjectVisualizationLib_pet_experience_bubble_png;
      
      public static var requiredClasses:Array = new Array(RoomObjectVisualizationFactory,IIDRoomObjectVisualizationFactory);
       
      
      public function HabboRoomObjectVisualizationLib()
      {
         super();
      }
   }
}
