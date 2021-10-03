package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LatencyPingReportMessageComposer implements IMessageComposer
   {
       
      
      private var var_2853:int;
      
      private var var_2852:int;
      
      private var var_2854:int;
      
      public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.var_2853 = param1;
         this.var_2852 = param2;
         this.var_2854 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2853,this.var_2852,this.var_2854];
      }
      
      public function dispose() : void
      {
      }
   }
}
