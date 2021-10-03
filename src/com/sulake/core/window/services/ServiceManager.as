package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContext;
   import flash.display.DisplayObject;
   
   public class ServiceManager implements IInternalWindowServices, IDisposable
   {
       
      
      private var var_3128:uint;
      
      private var _root:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      private var var_675:IWindowContext;
      
      private var var_1369:IMouseDraggingService;
      
      private var var_1370:IMouseScalingService;
      
      private var var_1367:IMouseListenerService;
      
      private var var_1368:IFocusManagerService;
      
      private var var_1366:IToolTipAgentService;
      
      private var var_1371:IGestureAgentService;
      
      public function ServiceManager(param1:IWindowContext, param2:DisplayObject)
      {
         super();
         this.var_3128 = 0;
         this._root = param2;
         this.var_675 = param1;
         this.var_1369 = new WindowMouseDragger(param2);
         this.var_1370 = new WindowMouseScaler(param2);
         this.var_1367 = new WindowMouseListener(param2);
         this.var_1368 = new FocusManager(param2);
         this.var_1366 = new WindowToolTipAgent(param2);
         this.var_1371 = new GestureAgentService();
      }
      
      public function dispose() : void
      {
         if(this.var_1369 != null)
         {
            this.var_1369.dispose();
            this.var_1369 = null;
         }
         if(this.var_1370 != null)
         {
            this.var_1370.dispose();
            this.var_1370 = null;
         }
         if(this.var_1367 != null)
         {
            this.var_1367.dispose();
            this.var_1367 = null;
         }
         if(this.var_1368 != null)
         {
            this.var_1368.dispose();
            this.var_1368 = null;
         }
         if(this.var_1366 != null)
         {
            this.var_1366.dispose();
            this.var_1366 = null;
         }
         if(this.var_1371 != null)
         {
            this.var_1371.dispose();
            this.var_1371 = null;
         }
         this._root = null;
         this.var_675 = null;
         this._disposed = true;
      }
      
      public function getMouseDraggingService() : IMouseDraggingService
      {
         return this.var_1369;
      }
      
      public function getMouseScalingService() : IMouseScalingService
      {
         return this.var_1370;
      }
      
      public function getMouseListenerService() : IMouseListenerService
      {
         return this.var_1367;
      }
      
      public function getFocusManagerService() : IFocusManagerService
      {
         return this.var_1368;
      }
      
      public function getToolTipAgentService() : IToolTipAgentService
      {
         return this.var_1366;
      }
      
      public function getGestureAgentService() : IGestureAgentService
      {
         return this.var_1371;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
   }
}
