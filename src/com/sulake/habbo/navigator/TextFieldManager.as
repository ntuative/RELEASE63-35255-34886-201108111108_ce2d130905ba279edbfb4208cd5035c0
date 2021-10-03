package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   
   public class TextFieldManager
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_69:ITextFieldWindow;
      
      private var var_686:Boolean;
      
      private var var_1692:String = "";
      
      private var var_1933:int;
      
      private var var_1934:Function;
      
      private var var_2710:String = "";
      
      private var var_112:IWindowContainer;
      
      private var _orgTextBackground:Boolean;
      
      private var var_2709:uint;
      
      private var _orgTextColor:uint;
      
      public function TextFieldManager(param1:HabboNavigator, param2:ITextFieldWindow, param3:int = 1000, param4:Function = null, param5:String = null)
      {
         super();
         this._navigator = param1;
         this.var_69 = param2;
         this.var_1933 = param3;
         this.var_1934 = param4;
         if(param5 != null)
         {
            this.var_686 = true;
            this.var_1692 = param5;
            this.var_69.text = param5;
         }
         Util.setProcDirectly(this.var_69,this.onInputClick);
         this.var_69.addEventListener(WindowKeyboardEvent.const_198,this.checkEnterPress);
         this.var_69.addEventListener(WindowEvent.const_114,this.checkMaxLen);
         this._orgTextBackground = this.var_69.textBackground;
         this.var_2709 = this.var_69.textBackgroundColor;
         this._orgTextColor = this.var_69.textColor;
      }
      
      public function dispose() : void
      {
         if(this.var_69)
         {
            this.var_69.dispose();
            this.var_69 = null;
         }
         if(this.var_112)
         {
            this.var_112.dispose();
            this.var_112 = null;
         }
         this._navigator = null;
      }
      
      public function checkMandatory(param1:String) : Boolean
      {
         if(!this.isInputValid())
         {
            this.displayError(param1);
            return false;
         }
         this.restoreBackground();
         return true;
      }
      
      public function restoreBackground() : void
      {
         this.var_69.textBackground = this._orgTextBackground;
         this.var_69.textBackgroundColor = this.var_2709;
         this.var_69.textColor = this._orgTextColor;
      }
      
      public function displayError(param1:String) : void
      {
         this.var_69.textBackground = true;
         this.var_69.textBackgroundColor = 4294021019;
         this.var_69.textColor = 4278190080;
         if(this.var_112 == null)
         {
            this.var_112 = IWindowContainer(this._navigator.getXmlWindow("nav_error_popup"));
            this._navigator.refreshButton(this.var_112,"popup_arrow_down",true,null,0);
            IWindowContainer(this.var_69.parent).addChild(this.var_112);
         }
         var _loc2_:ITextWindow = ITextWindow(this.var_112.findChildByName("error_text"));
         _loc2_.text = param1;
         _loc2_.width = _loc2_.textWidth + 5;
         this.var_112.findChildByName("border").width = _loc2_.width + 15;
         this.var_112.width = _loc2_.width + 15;
         var _loc3_:Point = new Point();
         this.var_69.getLocalPosition(_loc3_);
         this.var_112.x = _loc3_.x;
         this.var_112.y = _loc3_.y - this.var_112.height + 3;
         var _loc4_:IWindow = this.var_112.findChildByName("popup_arrow_down");
         _loc4_.x = this.var_112.width / 2 - _loc4_.width / 2;
         this.var_112.x += (this.var_69.width - this.var_112.width) / 2;
         this.var_112.visible = true;
      }
      
      public function goBackToInitialState() : void
      {
         this.clearErrors();
         if(this.var_1692 != null)
         {
            this.var_69.text = this.var_1692;
            this.var_686 = true;
         }
         else
         {
            this.var_69.text = "";
            this.var_686 = false;
         }
      }
      
      public function getText() : String
      {
         if(this.var_686)
         {
            return this.var_2710;
         }
         return this.var_69.text;
      }
      
      public function setText(param1:String) : void
      {
         this.var_686 = false;
         this.var_69.text = param1;
      }
      
      public function clearErrors() : void
      {
         this.restoreBackground();
         if(this.var_112 != null)
         {
            this.var_112.visible = false;
         }
      }
      
      public function get input() : ITextFieldWindow
      {
         return this.var_69;
      }
      
      private function isInputValid() : Boolean
      {
         return !this.var_686 && Util.trim(this.getText()).length > 2;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_353)
         {
            return;
         }
         if(!this.var_686)
         {
            return;
         }
         this.var_69.text = this.var_2710;
         this.var_686 = false;
         this.restoreBackground();
      }
      
      private function checkEnterPress(param1:WindowKeyboardEvent) : void
      {
         if(param1.charCode == Keyboard.ENTER)
         {
            if(this.var_1934 != null)
            {
               this.var_1934();
            }
         }
      }
      
      private function checkMaxLen(param1:WindowEvent) : void
      {
         var _loc2_:String = this.var_69.text;
         if(_loc2_.length > this.var_1933)
         {
            this.var_69.text = _loc2_.substring(0,this.var_1933);
         }
      }
   }
}
