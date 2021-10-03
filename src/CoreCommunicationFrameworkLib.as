package
{
   import com.sulake.bootstrap.CoreCommunicationManager;
   import com.sulake.iid.IIDCoreCommunicationManager;
   import mx.core.SimpleApplication;
   
   public class CoreCommunicationFrameworkLib extends SimpleApplication
   {
      
      public static var manifest:Class = CoreCommunicationFrameworkLib_manifest;
      
      public static var requiredClasses:Array = new Array(CoreCommunicationManager,IIDCoreCommunicationManager);
       
      
      public function CoreCommunicationFrameworkLib()
      {
         super();
      }
   }
}
