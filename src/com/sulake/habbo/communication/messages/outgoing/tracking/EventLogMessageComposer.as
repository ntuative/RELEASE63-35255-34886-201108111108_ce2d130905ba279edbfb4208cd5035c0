package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class EventLogMessageComposer implements IMessageComposer
   {
       
      
      private var _category:String;
      
      private var _type:String;
      
      private var _action:String;
      
      private var var_2677:String;
      
      private var var_2676:int;
      
      public function EventLogMessageComposer(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0)
      {
         super();
         if(param1 == null || param2 == null || param3 == null)
         {
         }
         this._category = !!param1 ? param1 : "";
         this._type = !!param2 ? param2 : "";
         this._action = !!param3 ? param3 : "";
         this.var_2677 = !!param4 ? param4 : "";
         this.var_2676 = !!param5 ? int(param5) : 0;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [this._category,this._type,this._action,this.var_2677,this.var_2676];
      }
   }
}
