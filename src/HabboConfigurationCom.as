package
{
   import com.sulake.bootstrap.HabboConfigurationManager;
   import com.sulake.habbo.configuration.HabboConfigurationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import mx.core.SimpleApplication;
   
   public class HabboConfigurationCom extends SimpleApplication
   {
      
      public static var requiredClasses:Array = new Array(com.sulake.bootstrap.HabboConfigurationManager,IIDHabboConfigurationManager);
      
      public static var manifest:Class = HabboConfigurationCom_manifest;
      
      public static var default_configuration:Class = HabboConfigurationCom_default_configuration;
      
      public static var IIDHabboConfigurationManager:Class = IIDHabboConfigurationManager;
      
      public static var HabboConfigurationManager:Class = com.sulake.habbo.configuration.HabboConfigurationManager;
       
      
      public function HabboConfigurationCom()
      {
         super();
      }
   }
}
