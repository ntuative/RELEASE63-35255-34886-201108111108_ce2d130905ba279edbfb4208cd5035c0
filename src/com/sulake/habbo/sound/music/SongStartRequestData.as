package com.sulake.habbo.sound.music
{
   import flash.utils.getTimer;
   
   public class SongStartRequestData
   {
       
      
      private var var_1543:int;
      
      private var var_2090:Number;
      
      private var var_2948:Number;
      
      private var var_2947:int;
      
      private var var_2949:Number;
      
      private var var_2946:Number;
      
      public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number = 2.0, param5:Number = 1.0)
      {
         super();
         this.var_1543 = param1;
         this.var_2090 = param2;
         this.var_2948 = param3;
         this.var_2949 = param4;
         this.var_2946 = param5;
         this.var_2947 = getTimer();
      }
      
      public function get songId() : int
      {
         return this.var_1543;
      }
      
      public function get startPos() : Number
      {
         if(this.var_2090 < 0)
         {
            return 0;
         }
         return this.var_2090 + (getTimer() - this.var_2947) / 1000;
      }
      
      public function get playLength() : Number
      {
         return this.var_2948;
      }
      
      public function get fadeInSeconds() : Number
      {
         return this.var_2949;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return this.var_2946;
      }
   }
}
