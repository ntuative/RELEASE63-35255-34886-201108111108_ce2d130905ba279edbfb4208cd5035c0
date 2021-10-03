package com.sulake.habbo.tracking
{
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   
   public class ToolbarClickTracker
   {
       
      
      private var var_1455:IHabboTracking;
      
      private var var_1891:Boolean = false;
      
      private var var_2774:int = 0;
      
      private var var_1960:int = 0;
      
      public function ToolbarClickTracker(param1:IHabboTracking)
      {
         super();
         this.var_1455 = param1;
      }
      
      public function dispose() : void
      {
         this.var_1455 = null;
      }
      
      public function configure(param1:IHabboConfigurationManager) : void
      {
         this.var_1891 = Boolean(parseInt(param1.getKey("toolbar.tracking.enabled","1")));
         this.var_2774 = parseInt(param1.getKey("toolbar.tracking.max.events","100"));
      }
      
      public function track(param1:String) : void
      {
         if(!this.var_1891)
         {
            return;
         }
         ++this.var_1960;
         if(this.var_1960 <= this.var_2774)
         {
            this.var_1455.trackGoogle("toolbar",param1);
         }
      }
   }
}
