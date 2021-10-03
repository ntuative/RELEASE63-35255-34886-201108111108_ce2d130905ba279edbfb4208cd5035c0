package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   
   public class WindowEvent
   {
      
      public static const const_2016:String = "WE_DESTROY";
      
      public static const const_366:String = "WE_DESTROYED";
      
      public static const const_1833:String = "WE_OPEN";
      
      public static const const_1933:String = "WE_OPENED";
      
      public static const const_1895:String = "WE_CLOSE";
      
      public static const const_1896:String = "WE_CLOSED";
      
      public static const const_2047:String = "WE_FOCUS";
      
      public static const const_353:String = "WE_FOCUSED";
      
      public static const const_1905:String = "WE_UNFOCUS";
      
      public static const const_1907:String = "WE_UNFOCUSED";
      
      public static const const_1375:String = "WE_ACTIVATE";
      
      public static const const_541:String = "WE_ACTIVATED";
      
      public static const const_1956:String = "WE_DEACTIVATE";
      
      public static const const_582:String = "WE_DEACTIVATED";
      
      public static const const_373:String = "WE_SELECT";
      
      public static const const_47:String = "WE_SELECTED";
      
      public static const const_674:String = "WE_UNSELECT";
      
      public static const const_558:String = "WE_UNSELECTED";
      
      public static const const_1877:String = "WE_LOCK";
      
      public static const const_1880:String = "WE_LOCKED";
      
      public static const const_1858:String = "WE_UNLOCK";
      
      public static const const_2073:String = "WE_UNLOCKED";
      
      public static const const_783:String = "WE_ENABLE";
      
      public static const const_225:String = "WE_ENABLED";
      
      public static const const_953:String = "WE_DISABLE";
      
      public static const const_239:String = "WE_DISABLED";
      
      public static const WINDOW_EVENT_RELOCATE:String = "WE_RELOCATE";
      
      public static const const_414:String = "WE_RELOCATED";
      
      public static const const_1320:String = "WE_RESIZE";
      
      public static const const_41:String = "WE_RESIZED";
      
      public static const const_1840:String = "WE_MINIMIZE";
      
      public static const const_1805:String = "WE_MINIMIZED";
      
      public static const const_2049:String = "WE_MAXIMIZE";
      
      public static const const_1824:String = "WE_MAXIMIZED";
      
      public static const const_2028:String = "WE_RESTORE";
      
      public static const const_1890:String = "WE_RESTORED";
      
      public static const const_637:String = "WE_CHILD_ADDED";
      
      public static const const_461:String = "WE_CHILD_REMOVED";
      
      public static const const_229:String = "WE_CHILD_RELOCATED";
      
      public static const const_175:String = "WE_CHILD_RESIZED";
      
      public static const const_384:String = "WE_CHILD_ACTIVATED";
      
      public static const const_503:String = "WE_PARENT_ADDED";
      
      public static const const_1947:String = "WE_PARENT_REMOVED";
      
      public static const const_1897:String = "WE_PARENT_RELOCATED";
      
      public static const const_505:String = "WE_PARENT_RESIZED";
      
      public static const const_1287:String = "WE_PARENT_ACTIVATED";
      
      public static const const_146:String = "WE_OK";
      
      public static const const_532:String = "WE_CANCEL";
      
      public static const const_114:String = "WE_CHANGE";
      
      public static const const_652:String = "WE_SCROLL";
      
      public static const const_116:String = "";
      
      private static const POOL:Array = [];
       
      
      protected var _type:String;
      
      protected var _window:IWindow;
      
      protected var var_759:IWindow;
      
      protected var var_1164:Boolean;
      
      protected var var_519:Boolean;
      
      protected var var_171:Boolean;
      
      protected var var_760:Array;
      
      public function WindowEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false) : WindowEvent
      {
         var _loc5_:WindowEvent = POOL.length > 0 ? POOL.pop() : new WindowEvent();
         _loc5_._type = param1;
         _loc5_._window = param2;
         _loc5_.var_759 = param3;
         _loc5_.var_519 = param4;
         _loc5_.var_171 = false;
         _loc5_.var_760 = POOL;
         return _loc5_;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get target() : IWindow
      {
         return this._window;
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get related() : IWindow
      {
         return this.var_759;
      }
      
      public function get cancelable() : Boolean
      {
         return this.var_519;
      }
      
      public function recycle() : void
      {
         if(this.var_171)
         {
            throw new Error("Event already recycled!");
         }
         this.var_759 = null;
         this._window = null;
         this.var_171 = true;
         this.var_1164 = false;
         this.var_760.push(this);
      }
      
      public function clone() : WindowEvent
      {
         return allocate(this._type,this.window,this.related,this.cancelable);
      }
      
      public function preventDefault() : void
      {
         this.preventWindowOperation();
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return this.var_1164;
      }
      
      public function preventWindowOperation() : void
      {
         if(this.cancelable)
         {
            this.var_1164 = true;
            return;
         }
         throw new Error("Attempted to prevent window operation that is not cancelable!");
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return this.var_1164;
      }
      
      public function stopPropagation() : void
      {
         this.var_1164 = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         this.var_1164 = true;
      }
      
      public function toString() : String
      {
         return "WindowEvent { type: " + this._type + " cancelable: " + this.var_519 + " window: " + this._window + " }";
      }
   }
}
