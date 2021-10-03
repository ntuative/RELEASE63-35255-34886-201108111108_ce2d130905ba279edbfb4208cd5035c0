package com.sulake.habbo.inventory.purse
{
   public class Purse
   {
       
      
      private var var_2145:int = 0;
      
      private var var_2144:int = 0;
      
      private var var_2769:int = 0;
      
      private var var_2770:Boolean = false;
      
      private var var_2371:Boolean = false;
      
      private var var_2768:Boolean = false;
      
      public function Purse()
      {
         super();
      }
      
      public function set clubDays(param1:int) : void
      {
         this.var_2145 = Math.max(0,param1);
      }
      
      public function set clubPeriods(param1:int) : void
      {
         this.var_2144 = Math.max(0,param1);
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         this.var_2769 = Math.max(0,param1);
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         this.var_2770 = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         this.var_2371 = param1;
      }
      
      public function set clubIsExpiring(param1:Boolean) : void
      {
         this.var_2768 = param1;
      }
      
      public function get clubDays() : int
      {
         return this.var_2145;
      }
      
      public function get clubPeriods() : int
      {
         return this.var_2144;
      }
      
      public function get clubPastPeriods() : int
      {
         return this.var_2769;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return this.var_2770;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2371;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return this.var_2768;
      }
   }
}
