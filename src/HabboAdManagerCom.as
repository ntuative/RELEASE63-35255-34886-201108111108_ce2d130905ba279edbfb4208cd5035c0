package
{
   import com.sulake.bootstrap.AdManager;
   import com.sulake.iid.IIDHabboAdManager;
   import mx.core.SimpleApplication;
   
   public class HabboAdManagerCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboAdManagerCom_manifest;
      
      public static var requiredClasses:Array = new Array(AdManager,IIDHabboAdManager);
       
      
      public function HabboAdManagerCom()
      {
         super();
      }
   }
}
