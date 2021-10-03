package com.sulake.habbo.catalog.purse
{
   import flash.utils.Dictionary;
   
   public class Purse implements IPurse
   {
       
      
      private var var_2190:int = 0;
      
      private var var_1676:Dictionary;
      
      private var var_2145:int = 0;
      
      private var var_2144:int = 0;
      
      private var var_2371:Boolean = false;
      
      private var var_2369:int = 0;
      
      private var var_2368:int = 0;
      
      private var var_2768:Boolean = false;
      
      public function Purse()
      {
         this.var_1676 = new Dictionary();
         super();
      }
      
      public function get credits() : int
      {
         return this.var_2190;
      }
      
      public function set credits(param1:int) : void
      {
         this.var_2190 = param1;
      }
      
      public function get clubDays() : int
      {
         return this.var_2145;
      }
      
      public function set clubDays(param1:int) : void
      {
         this.var_2145 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return this.var_2144;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         this.var_2144 = param1;
      }
      
      public function get hasClubLeft() : Boolean
      {
         return this.var_2145 > 0 || this.var_2144 > 0;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2371;
      }
      
      public function get isExpiring() : Boolean
      {
         return this.var_2768;
      }
      
      public function set isExpiring(param1:Boolean) : void
      {
         this.var_2768 = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         this.var_2371 = param1;
      }
      
      public function get pastClubDays() : int
      {
         return this.var_2369;
      }
      
      public function set pastClubDays(param1:int) : void
      {
         this.var_2369 = param1;
      }
      
      public function get pastVipDays() : int
      {
         return this.var_2368;
      }
      
      public function set pastVipDays(param1:int) : void
      {
         this.var_2368 = param1;
      }
      
      public function get activityPoints() : Dictionary
      {
         return this.var_1676;
      }
      
      public function set activityPoints(param1:Dictionary) : void
      {
         this.var_1676 = param1;
      }
      
      public function getActivityPointsForType(param1:int) : int
      {
         return this.var_1676[param1];
      }
   }
}
