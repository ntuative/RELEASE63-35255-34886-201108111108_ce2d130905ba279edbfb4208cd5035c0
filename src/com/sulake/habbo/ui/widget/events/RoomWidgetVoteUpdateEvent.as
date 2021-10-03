package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_154:String = "RWPUE_VOTE_QUESTION";
      
      public static const const_151:String = "RWPUE_VOTE_RESULT";
       
      
      private var var_1317:String;
      
      private var var_1481:Array;
      
      private var var_1221:Array;
      
      private var var_1931:int;
      
      public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array = null, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.var_1317 = param2;
         this.var_1481 = param3;
         this.var_1221 = param4;
         if(this.var_1221 == null)
         {
            this.var_1221 = [];
         }
         this.var_1931 = param5;
      }
      
      public function get question() : String
      {
         return this.var_1317;
      }
      
      public function get choices() : Array
      {
         return this.var_1481.slice();
      }
      
      public function get votes() : Array
      {
         return this.var_1221.slice();
      }
      
      public function get totalVotes() : int
      {
         return this.var_1931;
      }
   }
}
