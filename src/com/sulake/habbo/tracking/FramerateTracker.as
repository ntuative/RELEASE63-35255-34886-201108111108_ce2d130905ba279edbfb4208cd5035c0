package com.sulake.habbo.tracking
{
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   
   public class FramerateTracker
   {
       
      
      private var var_2037:int;
      
      private var var_2857:int;
      
      private var var_801:int;
      
      private var var_588:Number;
      
      private var var_2858:Boolean;
      
      private var var_2856:int;
      
      private var var_2036:int;
      
      public function FramerateTracker()
      {
         super();
      }
      
      public function get frameRate() : int
      {
         return Math.round(1000 / this.var_588);
      }
      
      public function configure(param1:IHabboConfigurationManager) : void
      {
         this.var_2857 = int(param1.getKey("tracking.framerate.reportInterval.seconds","300")) * 1000;
         this.var_2856 = int(param1.getKey("tracking.framerate.maximumEvents","5"));
         this.var_2858 = true;
      }
      
      public function trackUpdate(param1:uint, param2:IHabboTracking, param3:int) : void
      {
         var _loc4_:Number = NaN;
         ++this.var_801;
         if(this.var_801 == 1)
         {
            this.var_588 = param1;
            this.var_2037 = param3;
         }
         else
         {
            _loc4_ = Number(this.var_801);
            this.var_588 = this.var_588 * (_loc4_ - 1) / _loc4_ + Number(param1) / _loc4_;
         }
         if(this.var_2858 && param3 - this.var_2037 >= this.var_2857)
         {
            this.var_801 = 0;
            if(this.var_2036 < this.var_2856)
            {
               param2.trackGoogle("performance","averageFramerate",this.frameRate);
               ++this.var_2036;
               this.var_2037 = param3;
            }
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
