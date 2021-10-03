package
{
   import com.sulake.bootstrap.HabboCommunicationManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import mx.core.SimpleApplication;
   
   public class HabboCommunicationCom extends SimpleApplication
   {
      
      public static var manifest:Class = HabboCommunicationCom_manifest;
      
      public static var requiredClasses:Array = new Array(HabboCommunicationManager,IIDHabboCommunicationManager);
       
      
      public function HabboCommunicationCom()
      {
         super();
      }
   }
}
