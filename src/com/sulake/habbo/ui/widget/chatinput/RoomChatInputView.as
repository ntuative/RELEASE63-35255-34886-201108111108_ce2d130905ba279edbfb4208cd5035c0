package com.sulake.habbo.ui.widget.chatinput
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class RoomChatInputView
   {
      
      private static const const_1661:int = 250;
      
      private static const const_1660:int = 0;
      
      private static const BOTTOM_MARGIN:int = 55;
      
      private static const const_1662:String = "${widgets.chatinput.say}";
       
      
      private var _widget:RoomChatInputWidget;
      
      private var _window:IWindowContainer;
      
      private var var_27:ITextFieldWindow;
      
      private var var_2073:IWindow;
      
      private var _button:IWindow;
      
      private var var_2074:IWindow;
      
      private var var_1638:IWindow;
      
      private var var_2907:String;
      
      private var var_1330:String;
      
      private var var_2906:String;
      
      private var var_1637:Boolean = false;
      
      private var var_715:Boolean = false;
      
      private var var_1636:Boolean = false;
      
      private var var_410:Timer;
      
      private var var_486:Timer;
      
      private var var_714:String = "";
      
      public function RoomChatInputView(param1:RoomChatInputWidget)
      {
         super();
         this._widget = param1;
         this.var_1330 = param1.localizations.getKey("widgets.chatinput.mode.whisper",":tell");
         this.var_2907 = param1.localizations.getKey("widgets.chatinput.mode.shout",":shout");
         this.var_2906 = param1.localizations.getKey("widgets.chatinput.mode.speak",":speak");
         this.var_410 = new Timer(1000,1);
         this.var_410.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTypingTimerComplete);
         this.var_486 = new Timer(10000,1);
         this.var_486.addEventListener(TimerEvent.TIMER_COMPLETE,this.onIdleTimerComplete);
         this.createWindow();
      }
      
      public function get window() : IWindowContainer
      {
         return this._window;
      }
      
      public function dispose() : void
      {
         this._widget = null;
         this.var_27 = null;
         this.var_2073 = null;
         this._button = null;
         this.var_2074 = null;
         this.var_1638 = null;
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_410 != null)
         {
            this.var_410.reset();
            this.var_410.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTypingTimerComplete);
            this.var_410 = null;
         }
         if(this.var_486 != null)
         {
            this.var_486.reset();
            this.var_486.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onIdleTimerComplete);
            this.var_486 = null;
         }
      }
      
      private function createWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         var _loc1_:XmlAsset = this._widget.assets.getAssetByName("chatinput_window") as XmlAsset;
         if(_loc1_ == null || _loc1_.content == null)
         {
            return;
         }
         this._window = this._widget.windowManager.buildFromXML(_loc1_.content as XML,0) as IWindowContainer;
         this._window.x = (this._window.desktop.width - this._window.width) / 2;
         this._window.y = this._window.desktop.height - this._window.height - BOTTOM_MARGIN;
         this._window.tags.push("room_widget_chatinput");
         this.var_27 = this._window.findChildByName("chat_input") as ITextFieldWindow;
         this.var_2073 = this._window.findChildByName("input_border");
         this._button = this._window.findChildByName("send_button");
         this.var_2074 = this._window.findChildByName("send_button_text");
         this.var_1638 = this._window.findChildByName("block_text");
         this.var_2074.caption = const_1662;
         this.var_27.setParamFlag(HabboWindowParam.const_46,true);
         this.var_27.addEventListener(WindowMouseEvent.const_43,this.windowMouseEventProcessor);
         this.var_27.addEventListener(WindowKeyboardEvent.const_198,this.windowKeyEventProcessor);
         this.var_27.addEventListener(WindowKeyboardEvent.const_336,this.keyUpHandler);
         this.var_27.addEventListener(WindowEvent.const_114,this.method_9);
         this._window.findChildByName("send_button").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onSend);
         this.var_1637 = true;
         this.var_714 = "";
         this._window.addEventListener(WindowEvent.const_505,this.updatePosition);
         this._window.addEventListener(WindowEvent.const_503,this.updatePosition);
      }
      
      private function updatePosition(param1:WindowEvent = null) : void
      {
         var _loc2_:Point = new Point();
         this._window.getGlobalPosition(_loc2_);
         var _loc3_:int = _loc2_.x - this._window.x;
         var _loc4_:int = (this._window.desktop.width - this.var_2073.width) / 2 - _loc3_;
         var _loc5_:int = this._window.desktop.width - this._window.width - const_1661 - _loc3_;
         this._window.x = Math.max(Math.min(_loc4_,_loc5_),const_1660);
      }
      
      private function onSend(param1:WindowMouseEvent) : void
      {
         if(!this.var_1637)
         {
            this.sendChatFromInputField();
         }
      }
      
      public function hideFloodBlocking() : void
      {
         this.var_27.visible = true;
         this.var_1638.visible = false;
         if(this._button != null)
         {
            this._button.enable();
         }
      }
      
      public function showFloodBlocking() : void
      {
         this.var_27.visible = false;
         this.var_1638.visible = true;
         if(this._button != null)
         {
            this._button.disable();
         }
      }
      
      public function updateBlockText(param1:int) : void
      {
         this._widget.localizations.registerParameter("chat.input.alert.flood","time",param1.toString());
      }
      
      public function displaySpecialChatMessage(param1:String, param2:String = "") : void
      {
         if(this._window == null || this.var_27 == null)
         {
            return;
         }
         this.var_27.enable();
         this.var_27.selectable = true;
         this.var_27.text = "";
         this.setInputFieldFocus();
         this.var_27.text += param1 + " ";
         if(param2.length > 0)
         {
            this.var_27.text += param2 + " ";
         }
         this.var_27.setSelection(this.var_27.text.length,this.var_27.text.length);
         this.var_714 = this.var_27.text;
      }
      
      private function windowMouseEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         this.setInputFieldFocus();
      }
      
      private function windowKeyEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         var _loc3_:* = 0;
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(this._window == null || this._widget == null || this._widget.floodBlocked)
         {
            return;
         }
         if(this.anotherFieldHasFocus())
         {
            return;
         }
         this.setInputFieldFocus();
         if(param1 is WindowKeyboardEvent)
         {
            _loc5_ = param1 as WindowKeyboardEvent;
            _loc3_ = uint(_loc5_.charCode);
            _loc4_ = _loc5_.shiftKey;
         }
         if(param1 is KeyboardEvent)
         {
            _loc6_ = param1 as KeyboardEvent;
            _loc3_ = uint(_loc6_.charCode);
            _loc4_ = _loc6_.shiftKey;
         }
         if(_loc6_ == null && _loc5_ == null)
         {
            return;
         }
         if(_loc3_ == Keyboard.SPACE)
         {
            this.checkSpecialKeywordForInput();
         }
         if(_loc3_ == Keyboard.ENTER)
         {
            this.sendChatFromInputField(_loc4_);
            this.setButtonPressedState(true);
         }
         if(_loc3_ == Keyboard.BACKSPACE)
         {
            if(this.var_27 != null)
            {
               _loc7_ = this.var_27.text;
               _loc8_ = _loc7_.split(" ");
               if(_loc8_[0] == this.var_1330 && _loc8_.length == 3 && _loc8_[2] == "")
               {
                  this.var_27.text = "";
                  this.var_714 = "";
               }
            }
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.setButtonPressedState(false);
         }
      }
      
      private function setButtonPressedState(param1:Boolean) : void
      {
         if(this._button)
         {
            this._button.setStateFlag(WindowState.const_98,param1);
         }
      }
      
      private function method_9(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         this.var_486.reset();
         var _loc3_:* = _loc2_.text.length == 0;
         if(_loc3_)
         {
            this.var_715 = false;
            this.var_410.start();
         }
         else
         {
            if(_loc2_.text.length > this.var_714.length + 1)
            {
               if(this._widget.allowPaste)
               {
                  this._widget.setLastPasteTime();
               }
               else
               {
                  _loc2_.text = "";
               }
            }
            this.var_714 = _loc2_.text;
            if(!this.var_715)
            {
               this.var_715 = true;
               this.var_410.reset();
               this.var_410.start();
            }
            this.var_486.start();
         }
      }
      
      private function checkSpecialKeywordForInput() : void
      {
         if(this.var_27 == null || this.var_27.text == "")
         {
            return;
         }
         var _loc1_:String = this.var_27.text;
         var _loc2_:String = this._widget.selectedUserName;
         if(_loc1_ == this.var_1330)
         {
            if(_loc2_.length > 0)
            {
               this.var_27.text += " " + this._widget.selectedUserName;
               this.var_27.setSelection(this.var_27.text.length,this.var_27.text.length);
               this.var_714 = this.var_27.text;
            }
         }
      }
      
      private function onIdleTimerComplete(param1:TimerEvent) : void
      {
         if(this.var_715)
         {
            this.var_1636 = false;
         }
         this.var_715 = false;
         this.sendTypingMessage();
      }
      
      private function onTypingTimerComplete(param1:TimerEvent) : void
      {
         if(this.var_715)
         {
            this.var_1636 = true;
         }
         this.sendTypingMessage();
      }
      
      private function sendTypingMessage() : void
      {
         if(this._widget == null)
         {
            return;
         }
         if(this._widget.floodBlocked)
         {
            return;
         }
         var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(this.var_715);
         this._widget.messageListener.processWidgetMessage(_loc1_);
      }
      
      private function setInputFieldFocus() : void
      {
         if(this.var_27 == null)
         {
            return;
         }
         if(this.var_1637)
         {
            this.var_27.text = "";
            this.var_27.textColor = 0;
            this.var_27.italic = false;
            this.var_1637 = false;
            this.var_714 = "";
         }
         this.var_27.focus();
      }
      
      private function sendChatFromInputField(param1:Boolean = false) : void
      {
         if(this.var_27 == null || this.var_27.text == "")
         {
            return;
         }
         var _loc2_:int = !!param1 ? 0 : int(RoomWidgetChatMessage.const_141);
         var _loc3_:String = this.var_27.text;
         var _loc4_:Array = _loc3_.split(" ");
         var _loc5_:String = "";
         var _loc6_:* = "";
         switch(_loc4_[0])
         {
            case this.var_1330:
               _loc2_ = 0;
               _loc5_ = _loc4_[1];
               _loc6_ = this.var_1330 + " " + _loc5_ + " ";
               _loc4_.shift();
               _loc4_.shift();
               break;
            case this.var_2907:
               _loc2_ = 0;
               _loc4_.shift();
               break;
            case this.var_2906:
               _loc2_ = 0;
               _loc4_.shift();
         }
         _loc3_ = _loc4_.join(" ");
         if(this._widget != null)
         {
            if(this.var_410.running)
            {
               this.var_410.reset();
            }
            if(this.var_486.running)
            {
               this.var_486.reset();
            }
            this._widget.sendChat(_loc3_,_loc2_,_loc5_);
            this.var_715 = false;
            if(this.var_1636)
            {
               this.sendTypingMessage();
            }
            this.var_1636 = false;
         }
         this.var_27.text = _loc6_;
         this.var_714 = _loc6_;
      }
      
      private function anotherFieldHasFocus() : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this.var_27 != null)
         {
            if(this.var_27.focused)
            {
               return false;
            }
         }
         var _loc1_:DisplayObject = this._window.context.getDesktopWindow().getDisplayObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.stage;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.focus;
               if(_loc3_ == null)
               {
                  return false;
               }
               if(_loc3_ is TextField)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
