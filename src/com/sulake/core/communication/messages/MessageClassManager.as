package com.sulake.core.communication.messages
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class MessageClassManager implements IMessageClassManager
   {
       
      
      private var var_1112:Dictionary;
      
      private var var_891:Dictionary;
      
      public function MessageClassManager()
      {
         super();
         this.var_1112 = new Dictionary();
         this.var_891 = new Dictionary();
      }
      
      public function registerMessages(param1:IMessageConfiguration) : Boolean
      {
         var _loc2_:* = null;
         for(_loc2_ in param1.events)
         {
            this.registerMessageEvent(parseInt(_loc2_),param1.events[_loc2_]);
         }
         for(_loc2_ in param1.composers)
         {
            this.registerMessageComposer(parseInt(_loc2_),param1.composers[_loc2_]);
         }
         return true;
      }
      
      private function registerMessageComposer(param1:int, param2:Class) : Boolean
      {
         var _loc6_:* = null;
         var _loc3_:XML = describeType(param2);
         var _loc4_:Boolean = false;
         var _loc5_:String = getQualifiedClassName(IMessageComposer);
         for each(_loc6_ in _loc3_..implementsInterface)
         {
            if(_loc6_.@type == _loc5_)
            {
               _loc4_ = true;
               break;
            }
         }
         if(_loc4_)
         {
            this.var_1112[param1] = param2;
            return true;
         }
         throw new Error("Invalid Message Composer class defined for message id: " + param1 + "!");
      }
      
      private function registerMessageEvent(param1:int, param2:Class) : Boolean
      {
         var _loc5_:* = null;
         var _loc3_:XML = describeType(param2);
         var _loc4_:String = getQualifiedClassName(IMessageEvent);
         if(_loc3_..implementsInterface.@type == _loc4_)
         {
            Logger.log("Message Event ID: " + param1 + " implements IMessageEvent");
            if(this.var_891[param1] == null)
            {
               this.var_891[param1] = [param2];
            }
            else
            {
               _loc5_ = this.var_891[param1];
               _loc5_.push(param2);
            }
            return true;
         }
         throw new Error("Invalid Message Event class defined for message id: " + param1 + " does not implement IMessageEvent");
      }
      
      public function getMessageComposerID(param1:IMessageComposer) : int
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = -1;
         for(_loc3_ in this.var_1112)
         {
            _loc4_ = this.var_1112[_loc3_] as Class;
            if(param1 is _loc4_)
            {
               _loc2_ = parseInt(_loc3_);
               break;
            }
         }
         return _loc2_;
      }
      
      public function getMessageEventClasses(param1:int) : Array
      {
         var _loc2_:Array = this.var_891[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         return [];
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         var _loc2_:* = "";
         _loc1_ += "Registered Message Composer Classes: \n";
         for(_loc2_ in this.var_1112)
         {
            _loc1_ += _loc2_ + " -> " + this.var_1112[_loc2_] + "\n";
         }
         _loc1_ += "Registered Message Event Classes: \n";
         for(_loc2_ in this.var_891)
         {
            _loc1_ += _loc2_ + " -> " + this.var_891[_loc2_] + "\n";
         }
         return _loc1_;
      }
   }
}
