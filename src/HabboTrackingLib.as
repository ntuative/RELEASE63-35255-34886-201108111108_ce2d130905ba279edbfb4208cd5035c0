package
{
   import com.sulake.bootstrap.HabboTracking;
   import com.sulake.iid.IIDHabboTracking;
   import mx.core.SimpleApplication;
   
   public class HabboTrackingLib extends SimpleApplication
   {
      
      public static var manifest:Class = HabboTrackingLib_manifest;
      
      public static var requiredClasses:Array = new Array(HabboTracking,IIDHabboTracking);
       
      
      public function HabboTrackingLib()
      {
         super();
      }
   }
}
