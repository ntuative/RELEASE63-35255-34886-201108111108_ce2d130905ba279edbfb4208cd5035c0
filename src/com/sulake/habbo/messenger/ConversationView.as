package com.sulake.habbo.messenger
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.messenger.domain.Conversation;
   import com.sulake.habbo.messenger.domain.Message;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class ConversationView
   {
      
      private static const const_1515:int = 10;
      
      private static const const_1060:int = 100;
      
      private static const const_1516:int = 20;
       
      
      private var _messenger:HabboMessenger;
      
      private var var_2511:IScrollbarWindow;
      
      private var var_1850:IContainerButtonWindow;
      
      private var var_62:IItemListWindow;
      
      private var var_546:Conversation;
      
      public function ConversationView(param1:HabboMessenger, param2:IWindowContainer)
      {
         super();
         this._messenger = param1;
         this.var_1850 = this.initButton("follow_friend",this.onFollowButtonClick,param2);
         this.var_62 = IItemListWindow(param2.findChildByName("msg_list"));
         this.var_2511 = IScrollbarWindow(param2.findChildByName("scroller"));
         this._messenger.refreshButton(param2,"close",true,this.onCloseButtonClick,0);
         this.initButton("minimail",this.onMinimailButtonClick,param2);
      }
      
      public function addMessage(param1:Message) : void
      {
         var _loc2_:int = this.findAddIndex();
         if(_loc2_ >= const_1060 + const_1516)
         {
            this.refreshList();
            this.afterResize();
         }
         else
         {
            this.var_62.autoArrangeItems = false;
            this.refreshEntry(true,_loc2_,param1);
            this.var_62.autoArrangeItems = true;
         }
         this.var_2511.scrollV = 1;
         this.refreshScrollBarVisibility();
      }
      
      public function afterResize() : void
      {
         this.refreshListDims();
         var _loc1_:Boolean = this.refreshScrollBarVisibility();
         if(_loc1_)
         {
            this.refreshListDims();
         }
      }
      
      private function initButton(param1:String, param2:Function, param3:IWindowContainer) : IContainerButtonWindow
      {
         var _loc4_:IContainerButtonWindow = IContainerButtonWindow(param3.findChildByName("button_" + param1));
         _loc4_.procedure = param2;
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("icon"));
         _loc5_.bitmap = this._messenger.getButtonImage(param1);
         _loc5_.width = _loc5_.bitmap.width;
         _loc5_.height = _loc5_.bitmap.height;
         return _loc4_;
      }
      
      private function refreshListDims() : void
      {
         var _loc2_:* = null;
         this.var_62.autoArrangeItems = false;
         var _loc1_:int = 0;
         while(_loc1_ < this.var_62.numListItems)
         {
            _loc2_ = ITextWindow(this.var_62.getListItemAt(_loc1_));
            this.refreshTextDims(_loc2_);
            if(!_loc2_.visible)
            {
               break;
            }
            _loc1_++;
         }
         this.var_62.autoArrangeItems = true;
      }
      
      private function refreshTextDims(param1:ITextWindow) : void
      {
         param1.width = this.var_62.width;
         param1.height = param1.textHeight + const_1515;
         param1.invalidate();
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc1_:IWindowContainer = IWindowContainer(this.var_62.parent);
         var _loc2_:IWindow = _loc1_.getChildByName("scroller") as IWindow;
         var _loc3_:* = this.var_62.scrollableRegion.height > this.var_62.height;
         if(_loc2_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc2_.visible = false;
            this.var_62.width += 22;
            return true;
         }
         if(_loc3_)
         {
            _loc2_.visible = true;
            this.var_62.width -= 22;
            return true;
         }
         return false;
      }
      
      private function findAddIndex() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.var_62.numListItems)
         {
            _loc2_ = this.var_62.getListItemAt(_loc1_);
            if(!_loc2_.visible)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ + 1;
      }
      
      public function refresh() : void
      {
         var _loc1_:Conversation = this._messenger.conversations.findSelectedConversation();
         if(_loc1_ == null)
         {
            return;
         }
         if(this.var_546 == null || _loc1_.id != this.var_546.id)
         {
            this.var_546 = _loc1_;
            this.refreshList();
            this.afterResize();
         }
         this.refreshHeader();
      }
      
      public function refreshHeader() : void
      {
         if(this.var_546.followingAllowed)
         {
            this.var_1850.enable();
         }
         else
         {
            this.var_1850.disable();
         }
      }
      
      private function refreshList() : void
      {
         var _loc3_:Boolean = false;
         if(this.var_62 == null)
         {
            return;
         }
         this.var_62.autoArrangeItems = false;
         var _loc1_:int = 0;
         var _loc2_:int = Math.max(0,this.var_546.messages.length - const_1060);
         _loc1_ = 0;
         while(_loc1_ + _loc2_ < this.var_546.messages.length)
         {
            this.refreshEntry(true,_loc1_,this.var_546.messages[_loc1_ + _loc2_]);
            _loc1_++;
         }
         while(true)
         {
            _loc3_ = this.refreshEntry(false,_loc1_,null);
            if(_loc3_)
            {
               break;
            }
            _loc1_++;
         }
         this.var_62.autoArrangeItems = true;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:Message) : Boolean
      {
         var _loc4_:ITextWindow = this.var_62.getListItemAt(param2) as ITextWindow;
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = ITextWindow(this._messenger.getXmlWindow("msg_entry"));
            _loc4_.width = this.var_62.width;
            this.var_62.addListItem(_loc4_);
         }
         if(!param1)
         {
            _loc4_.height = 0;
            _loc4_.visible = false;
            return false;
         }
         _loc4_.visible = true;
         var _loc5_:String = param3.type == Message.const_840 || param3.type == Message.const_777 ? param3.time + ": " : "";
         _loc4_.text = _loc5_ + param3.messageText;
         _loc4_.color = this.getChatBgColor(param3.type);
         _loc4_.textColor = this.getChatTextColor(param3.type);
         this.refreshTextDims(_loc4_);
         return false;
      }
      
      private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Minimail clicked");
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["recipientid"] = "" + this.var_546.id;
         _loc3_["random"] = "" + Math.round(Math.random() * 100000000);
         if(this._messenger.isEmbeddedMinimailEnabled())
         {
            if(false)
            {
               ExternalInterface.call("FlashExternalInterface.openHabblet","minimail","#mail/compose/" + _loc3_["recipientid"] + "/" + _loc3_["random"] + "/");
            }
         }
         else
         {
            this._messenger.openHabboWebPage("link.format.mail.compose",_loc3_,param1);
         }
      }
      
      private function onFollowButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Follow clicked");
         this._messenger.send(new FollowFriendMessageComposer(this.var_546.id));
         this._messenger.send(new EventLogMessageComposer("Navigation","IM","go.im"));
      }
      
      private function onCloseButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close clicked");
         this._messenger.conversations.closeConversation();
         this._messenger.messengerView.refresh();
      }
      
      private function getChatBgColor(param1:int) : uint
      {
         if(param1 == Message.const_840)
         {
            return 4294967295;
         }
         if(param1 == Message.const_777)
         {
            return 4292801535;
         }
         if(param1 == Message.const_1369)
         {
            return 4294927974;
         }
         if(param1 == Message.const_983)
         {
            return 4293454056;
         }
         if(param1 == Message.const_875)
         {
            return 4293454056;
         }
         if(param1 == Message.const_1312)
         {
            return 4288269465;
         }
         return 4291611852;
      }
      
      private function getChatTextColor(param1:int) : uint
      {
         if(param1 == Message.const_983)
         {
            return 4285887861;
         }
         if(param1 == Message.const_875)
         {
            return 4285887861;
         }
         return 4278190080;
      }
   }
}
