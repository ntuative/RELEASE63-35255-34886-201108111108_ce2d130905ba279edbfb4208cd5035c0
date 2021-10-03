package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.enum.LinkTarget;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.utils.PropertyDefaults;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.StyleSheet;
   import flash.text.TextFieldType;
   
   public class HTMLTextController extends TextFieldController implements IHTMLTextWindow
   {
      
      private static var var_999:String = PropertyDefaults.HTML_LINK_TARGET_VALUE;
       
      
      private var var_791:String;
      
      private var var_1219:String = null;
      
      private var var_1844:StyleSheet = null;
      
      public function HTMLTextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         this.var_791 = PropertyDefaults.HTML_LINK_TARGET_VALUE;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         this.immediateClickMode = true;
         _field.type = TextFieldType.DYNAMIC;
         _field.mouseEnabled = true;
         _field.selectable = false;
      }
      
      public static function set defaultLinkTarget(param1:String) : void
      {
         var_999 = param1;
      }
      
      public static function get defaultLinkTarget() : String
      {
         return var_999;
      }
      
      private static function setHtmlStyleSheetString(param1:HTMLTextController, param2:String) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.var_1219 == param2)
         {
            return;
         }
         param1.var_1219 = param2;
         param1.var_1844 = null;
         if(param1.var_1219 != null)
         {
            _loc3_ = new StyleSheet();
            _loc3_.parseCSS(param1.var_1219);
            param1.var_1844 = _loc3_;
         }
      }
      
      private static function convertLinksToEvents(param1:String) : String
      {
         var _loc2_:* = null;
         _loc2_ = /<a[^>]+(http:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
         param1 = param1.replace(_loc2_,"<a href=\'event:$1\'>$2</a>");
         _loc2_ = /<a[^>]+(https:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
         return param1.replace(_loc2_,"<a href=\'event:$1\'>$2</a>");
      }
      
      private static function openWebPage(param1:String, param2:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         if(param2 == null)
         {
            param2 = var_999;
         }
         var _loc3_:URLRequest = new URLRequest(param1);
         if(true)
         {
            navigateToURL(_loc3_,param2);
         }
         else
         {
            _loc4_ = String(ExternalInterface.call("function() { return navigator.userAgent; }")).toLowerCase();
            if(_loc4_.indexOf("safari") > -1 || _loc4_.indexOf("chrome") > -1 || _loc4_.indexOf("firefox") > -1 || _loc4_.indexOf("msie") > -1 && uint(_loc4_.substr(_loc4_.indexOf("msie") + 5,3)) >= 7)
            {
               _loc5_ = ExternalInterface.call("function() {var win = window.open(\'" + _loc3_.url + "\', \'" + param2 + "\'); if (win) { win.focus();} return true; }");
               if(_loc5_)
               {
                  Logger.log("Opened web page url = " + param1);
               }
            }
            else
            {
               navigateToURL(_loc3_,param2);
            }
         }
      }
      
      public function set linkTarget(param1:String) : void
      {
         if(PropertyDefaults.const_936.indexOf(param1) > -1)
         {
            this.var_791 = param1;
         }
      }
      
      public function get linkTarget() : String
      {
         return this.var_791 == LinkTarget.const_30 ? defaultLinkTarget : this.var_791;
      }
      
      public function get htmlStyleSheetString() : String
      {
         return this.var_1219;
      }
      
      public function set htmlStyleSheetString(param1:String) : void
      {
         setHtmlStyleSheetString(this,param1);
      }
      
      override public function set immediateClickMode(param1:Boolean) : void
      {
         if(param1 != var_1160)
         {
            super.immediateClickMode = param1;
            if(var_1160)
            {
               _field.addEventListener(TextEvent.LINK,this.immediateClickHandler);
            }
            else
            {
               _field.removeEventListener(TextEvent.LINK,this.immediateClickHandler);
            }
         }
      }
      
      override public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_145)
         {
            context.removeLocalizationListener(var_18.slice(2,var_18.indexOf("}")),this);
            var_145 = false;
         }
         var_18 = param1;
         if(var_18.charAt(0) == "$" && var_18.charAt(1) == "{")
         {
            context.registerLocalizationListener(var_18.slice(2,var_18.indexOf("}")),this);
            var_145 = true;
         }
         else if(_field != null)
         {
            _field.htmlText = convertLinksToEvents(var_18);
            refreshTextImage();
         }
      }
      
      override public function set localization(param1:String) : void
      {
         if(param1 != null && _field != null)
         {
            _field.htmlText = convertLinksToEvents(param1);
            refreshTextImage();
         }
      }
      
      override public function set htmlText(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_145)
         {
            context.removeLocalizationListener(var_18.slice(2,var_18.indexOf("}")),this);
            var_145 = false;
         }
         var_18 = param1;
         if(var_18.charAt(0) == "$" && var_18.charAt(1) == "{")
         {
            context.registerLocalizationListener(var_18.slice(2,var_18.indexOf("}")),this);
            var_145 = true;
         }
         else if(_field != null)
         {
            _field.htmlText = convertLinksToEvents(var_18);
            _field.styleSheet = this.var_1844;
            refreshTextImage();
         }
      }
      
      override protected function immediateClickHandler(param1:Event) : void
      {
         var _loc2_:* = null;
         if(param1 is TextEvent)
         {
            _loc2_ = WindowLinkEvent.allocate(TextEvent(param1).text,this,null);
            if(_events)
            {
               _events.dispatchEvent(_loc2_);
            }
            if(!_loc2_.isWindowOperationPrevented())
            {
               if(procedure != null)
               {
                  procedure(_loc2_,this);
               }
            }
            if(!_loc2_.isWindowOperationPrevented() && this.linkTarget != LinkTarget.const_1213)
            {
               openWebPage(TextEvent(param1).text,this.linkTarget);
            }
            param1.stopImmediatePropagation();
            _loc2_.recycle();
         }
         else
         {
            super.immediateClickHandler(param1);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         if(this.var_791 != PropertyDefaults.HTML_LINK_TARGET_VALUE)
         {
            _loc1_.push(new PropertyStruct(PropertyDefaults.const_873,this.var_791,PropertyStruct.const_53,true,PropertyDefaults.const_936));
         }
         else
         {
            _loc1_.push(PropertyDefaults.const_1970);
         }
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.key == PropertyDefaults.const_873)
            {
               this.var_791 = _loc2_.value as String;
               break;
            }
            if(_loc2_.key == "html_stylesheet")
            {
               this.htmlStyleSheetString = _loc2_.value as String;
               break;
            }
         }
         super.properties = param1;
      }
   }
}
