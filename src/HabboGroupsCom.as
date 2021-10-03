package
{
   import com.sulake.bootstrap.HabboGroupsManager;
   import com.sulake.iid.IIDHabboGroupsManager;
   import mx.core.SimpleApplication;
   
   public class HabboGroupsCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboGroupsCom_manifest;
      
      public static var requiredClasses:Array = new Array(HabboGroupsManager,IIDHabboGroupsManager);
       
      
      public function HabboGroupsCom()
      {
         super();
      }
   }
}
