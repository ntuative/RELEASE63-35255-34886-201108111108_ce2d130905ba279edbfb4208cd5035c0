package com.sulake.habbo.communication.messages.incoming.sound
{
   public class SongInfoEntry extends PlayListEntry
   {
       
      
      private var var_2058:String = "";
      
      public function SongInfoEntry(param1:int, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3,param4);
         this.var_2058 = param5;
      }
      
      public function get data() : String
      {
         return this.var_2058;
      }
   }
}
