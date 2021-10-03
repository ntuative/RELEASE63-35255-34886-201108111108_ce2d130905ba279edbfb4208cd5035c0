package com.sulake.habbo.help.hotelmerge
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.help.tutorial.NameSuggestionListRenderer;
   import com.sulake.habbo.help.tutorial.TutorialUI;
   
   public class HotelMergeNameChangeView
   {
      
      private static var var_1471:uint = 13232628;
      
      private static var var_1771:uint = 11129827;
       
      
      private var var_26:HotelMergeUI;
      
      private var _window:IFrameWindow;
      
      private var var_534:String;
      
      private var var_1770:String;
      
      private var var_1769:IWindowContainer;
      
      private var var_775:IWindowContainer;
      
      private var var_774:IWindowContainer;
      
      private var var_53:IWindowContainer;
      
      private var var_1472:Boolean = false;
      
      private var var_1188:NameSuggestionListRenderer;
      
      public function HotelMergeNameChangeView(param1:HotelMergeUI)
      {
         super();
         this.var_26 = param1;
      }
      
      public function get id() : String
      {
         return TutorialUI.const_343;
      }
      
      public function set checkedName(param1:String) : void
      {
         this.var_534 = param1;
         if(this.var_1770 == this.var_534)
         {
            this.showConfirmationView();
            return;
         }
         this.setNameAvailableView();
      }
      
      public function dispose() : void
      {
         this.disposeWindow();
         if(this.var_1188 != null)
         {
            this.var_1188.dispose();
            this.var_1188 = null;
         }
      }
      
      private function disposeWindow() : void
      {
         this.var_1769 = null;
         this.var_775 = null;
         this.var_774 = null;
         this.var_53 = null;
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      private function showView(param1:IWindowContainer) : void
      {
         this.var_1472 = false;
         if(this.var_53)
         {
            this.var_53.visible = false;
         }
         this.var_53 = param1;
         this.var_53.visible = true;
         if(this._window)
         {
            this._window.content.width = this.var_53.width;
            this._window.content.height = this.var_53.height;
         }
      }
      
      public function showMainView() : void
      {
         if(!this._window)
         {
            this._window = this.createWindow("hotel_merge_name_change_xml") as IFrameWindow;
            this._window.center();
            this._window.procedure = this.windowEventHandler;
            this.var_1769 = this._window.content.getChildAt(0) as IWindowContainer;
         }
         this.var_26.localization.registerParameter("hotel_merge.name_change.current","name",this.var_26.myName);
         this._window.caption = this.var_26.localization.getKey("hotel_merge.name_change.title.main");
         this.showView(this.var_1769);
      }
      
      private function showSelectionView() : void
      {
         if(!this.var_775)
         {
            this.var_775 = this.createWindow("hotel_merge_name_selection_xml") as IWindowContainer;
            if(!this.var_775)
            {
               return;
            }
            this._window.content.addChild(this.var_775);
         }
         this._window.caption = this.var_26.localization.getKey("hotel_merge.name_change.title.select");
         var _loc1_:IButtonWindow = this._window.findChildByName("select_name_button") as IButtonWindow;
         if(_loc1_)
         {
            _loc1_.disable();
         }
         this.setNormalView();
         this.showView(this.var_775);
      }
      
      private function showConfirmationView() : void
      {
         if(!this.var_774)
         {
            this.var_774 = this.createWindow("hotel_merge_name_confirmation_xml") as IWindowContainer;
            if(!this.var_774)
            {
               return;
            }
            this._window.content.addChild(this.var_774);
         }
         this._window.caption = this.var_26.localization.getKey("hotel_merge.name_change.title.confirm");
         var _loc1_:ITextWindow = this.var_774.findChildByName("final_name") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = this.var_534;
         }
         this.showView(this.var_774);
      }
      
      private function createWindow(param1:String) : IWindow
      {
         var _loc2_:XmlAsset = this.var_26.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc2_)
         {
            return null;
         }
         return this.var_26.windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      public function get view() : IWindowContainer
      {
         return this._window;
      }
      
      public function setNormalView() : void
      {
         if(this._window == null)
         {
            return;
         }
         var _loc1_:ITextWindow = this._window.findChildByName("info_text") as ITextWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.text = this.var_26.localization.getKey("help.tutorial.name.info");
         var _loc2_:IWindowContainer = this._window.findChildByName("suggestions") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = false;
      }
      
      public function setNameAvailableView() : void
      {
         if(this._window == null)
         {
            return;
         }
         this.nameCheckWaitEnd(true);
         var _loc1_:ITextWindow = this._window.findChildByName("info_text") as ITextWindow;
         if(_loc1_ == null)
         {
            return;
         }
         this.var_26.localization.registerParameter("help.tutorial.name.available","name",this.var_534);
         _loc1_.text = this.var_26.localization.getKey("help.tutorial.name.available");
         var _loc2_:ITextFieldWindow = this._window.findChildByName("input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = this.var_534;
         var _loc3_:IWindowContainer = this._window.findChildByName("suggestions") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = false;
      }
      
      public function setNameNotAvailableView(param1:int, param2:String, param3:Array) : void
      {
         var _loc8_:* = null;
         this.nameCheckWaitEnd(false);
         if(this.var_53 != this.var_775)
         {
            this.showSelectionView();
         }
         this.var_1770 = null;
         this.var_534 = null;
         if(this._window == null)
         {
            return;
         }
         var _loc4_:ITextWindow = this._window.findChildByName("info_text") as ITextWindow;
         if(_loc4_ == null)
         {
            return;
         }
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.var_945:
               this.var_26.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.taken");
               break;
            case ChangeUserNameResultMessageEvent.var_944:
               this.var_26.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.invalid");
               break;
            case ChangeUserNameResultMessageEvent.var_947:
               break;
            case ChangeUserNameResultMessageEvent.var_943:
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.long");
               break;
            case ChangeUserNameResultMessageEvent.var_946:
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.short");
               break;
            case ChangeUserNameResultMessageEvent.var_1158:
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.change_not_allowed");
               break;
            case ChangeUserNameResultMessageEvent.var_1159:
               _loc4_.text = this.var_26.localization.getKey("help.tutorial.name.merge_hotel_down");
         }
         var _loc5_:IWindowContainer = this._window.findChildByName("suggestions") as IWindowContainer;
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 == ChangeUserNameResultMessageEvent.var_1159 || param1 == ChangeUserNameResultMessageEvent.var_1158)
         {
            _loc5_.visible = false;
            return;
         }
         _loc5_.visible = true;
         this.var_1188 = new NameSuggestionListRenderer(this.var_26);
         var _loc6_:int = this.var_1188.render(param3,_loc5_);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.numChildren)
         {
            _loc8_ = _loc5_.getChildAt(_loc7_);
            _loc8_.color = var_1471;
            _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.nameSelected);
            _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.nameOver);
            _loc8_.addEventListener(WindowMouseEvent.const_25,this.nameOut);
            _loc7_++;
         }
      }
      
      private function nameSelected(param1:WindowMouseEvent) : void
      {
         this.nameCheckWaitEnd(true);
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:String = _loc2_.text;
         this.setNormalView();
         var _loc4_:ITextFieldWindow = this._window.findChildByName("input") as ITextFieldWindow;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.text = _loc3_;
      }
      
      private function nameOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = var_1771;
         }
      }
      
      private function nameOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = var_1471;
         }
      }
      
      public function nameCheckWaitBegin() : void
      {
         var _loc1_:* = null;
         if(this._window && !this._window.disposed)
         {
            _loc1_ = this._window.findChildByName("select_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = this._window.findChildByName("check_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = this._window.findChildByName("input");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = this._window.findChildByName("info_text");
            if(_loc1_)
            {
               _loc1_.caption = this.var_26.localization.getKey("help.tutorial.name.wait_while_checking");
            }
         }
         this.var_1472 = true;
      }
      
      public function nameCheckWaitEnd(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(this._window && !this._window.disposed)
         {
            if(param1)
            {
               _loc2_ = this._window.findChildByName("select_name_button");
               if(_loc2_)
               {
                  _loc2_.enable();
               }
            }
            _loc2_ = this._window.findChildByName("check_name_button");
            if(_loc2_)
            {
               _loc2_.enable();
            }
            _loc2_ = this._window.findChildByName("input");
            if(_loc2_)
            {
               _loc2_.enable();
            }
         }
         this.var_1472 = false;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(!this.var_1472)
         {
            if(param1.type == WindowEvent.const_114)
            {
               if(param2.name == "input")
               {
                  _loc3_ = this._window.findChildByName("select_name_button");
                  _loc4_ = param2 as ITextFieldWindow;
                  if(_loc3_ && _loc4_)
                  {
                     if(_loc4_.text.length > 2)
                     {
                        _loc3_.enable();
                     }
                     else
                     {
                        _loc3_.disable();
                     }
                  }
               }
            }
         }
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "change_name_button":
               this.showSelectionView();
               break;
            case "keep_name_button":
               this.var_534 = this.var_26.myName;
               this.showConfirmationView();
               break;
            case "check_name_button":
               this.var_26.checkName(this.getName());
               this.nameCheckWaitBegin();
               break;
            case "select_name_button":
               _loc5_ = this.getName();
               if(_loc5_.length < 1)
               {
                  return;
               }
               if(this.var_534 != _loc5_)
               {
                  this.var_1770 = _loc5_;
                  this.var_26.checkName(_loc5_);
                  this.nameCheckWaitBegin();
               }
               else
               {
                  this.showConfirmationView();
               }
               break;
            case "cancel_selection_button":
               this.nameCheckWaitEnd(true);
               this.showMainView();
               break;
            case "confirm_name_button":
               this.var_26.changeName(this.var_534);
               break;
            case "cancel_confirmation_button":
               this.nameCheckWaitEnd(true);
               this.showMainView();
               break;
            case "header_button_close":
               this.disposeWindow();
         }
      }
      
      private function getName() : String
      {
         var _loc1_:* = null;
         if(this._window)
         {
            _loc1_ = this._window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
   }
}
