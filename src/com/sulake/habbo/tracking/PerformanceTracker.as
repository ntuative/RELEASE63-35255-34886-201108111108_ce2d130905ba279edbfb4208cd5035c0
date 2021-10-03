package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.debug.GarbageMonitor;
   import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   
   public class PerformanceTracker
   {
       
      
      private var _connection:IConnection = null;
      
      private var _configuration:IHabboConfigurationManager = null;
      
      private var var_623:int = 0;
      
      private var var_588:Number = 0;
      
      private var var_3123:Array;
      
      private var var_1632:String = "";
      
      private var var_2072:String = "";
      
      private var var_2684:String = "";
      
      private var var_2687:String = "";
      
      private var var_1920:Boolean = false;
      
      private var var_2071:GarbageMonitor = null;
      
      private var var_1634:int = 0;
      
      private var var_2901:Boolean;
      
      private var var_2069:int = 1000;
      
      private var var_1635:int = 0;
      
      private var _reportInterval:int = 60;
      
      private var var_2037:int = 0;
      
      private var var_2070:int = 10;
      
      private var var_1633:int = 0;
      
      private var var_2903:Number = 0.15;
      
      private var var_2902:Boolean = true;
      
      private var var_2904:Number = 0;
      
      public function PerformanceTracker()
      {
         this.var_3123 = [];
         super();
         this.var_2072 = Capabilities.version;
         this.var_2684 = Capabilities.os;
         this.var_1920 = Capabilities.isDebugger;
         this.var_1632 = !true ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
         if(this.var_1632 == null)
         {
            this.var_1632 = "unknown";
         }
         this.var_2071 = new GarbageMonitor();
         this.updateGarbageMonitor();
         this.var_2037 = getTimer();
      }
      
      public function get flashVersion() : String
      {
         return this.var_2072;
      }
      
      public function get averageUpdateInterval() : int
      {
         return this.var_588;
      }
      
      public function set slowUpdateLimit(param1:int) : void
      {
         this.var_2069 = param1;
      }
      
      public function set reportInterval(param1:int) : void
      {
         this._reportInterval = param1;
      }
      
      public function set reportLimit(param1:int) : void
      {
         this.var_2070 = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         this._connection = param1;
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         this._configuration = param1;
         this._reportInterval = int(this._configuration.getKey("performancetest.interval","60"));
         this.var_2069 = int(this._configuration.getKey("performancetest.slowupdatelimit","1000"));
         this.var_2070 = int(this._configuration.getKey("performancetest.reportlimit","10"));
         this.var_2903 = Number(this._configuration.getKey("performancetest.distribution.deviancelimit.percent","10"));
         this.var_2902 = Boolean(int(this._configuration.getKey("performancetest.distribution.enabled","1")));
         this.var_2901 = Boolean(this._configuration.getKey("monitor.garbage.collection","0") == "1");
      }
      
      public function dispose() : void
      {
      }
      
      private function updateGarbageMonitor() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Array = this.var_2071.list;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _loc2_ = new GarbageTester("tester");
            this.var_2071.insert(_loc2_,"tester");
            return _loc2_;
         }
         return null;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         if(this.var_2901)
         {
            _loc4_ = this.updateGarbageMonitor();
            if(_loc4_ != null)
            {
               ++this.var_1634;
               Logger.log("Garbage collection");
            }
         }
         var _loc3_:Boolean = false;
         if(param1 > this.var_2069)
         {
            ++this.var_1635;
            _loc3_ = true;
         }
         else
         {
            ++this.var_623;
            if(this.var_623 <= 1)
            {
               this.var_588 = param1;
            }
            else
            {
               _loc5_ = Number(this.var_623);
               this.var_588 = this.var_588 * (_loc5_ - 1) / _loc5_ + Number(param1) / _loc5_;
            }
         }
         if(param2 - this.var_2037 > this._reportInterval * 1000 && this.var_1633 < this.var_2070)
         {
            _loc6_ = 0;
            Logger.log("*** Performance tracker: average frame rate " + 1000 / this.var_588 + "/s, system memory usage : " + _loc6_ + " bytes");
            _loc7_ = true;
            if(this.var_2902 && this.var_1633 > 0)
            {
               _loc8_ = this.differenceInPercents(this.var_2904,this.var_588);
               if(_loc8_ < this.var_2903)
               {
                  _loc7_ = false;
               }
            }
            this.var_2037 = param2;
            if(_loc7_ || _loc3_)
            {
               this.var_2904 = this.var_588;
               if(this.sendReport(param2))
               {
                  ++this.var_1633;
               }
            }
         }
      }
      
      private function sendReport(param1:int) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._connection != null)
         {
            _loc2_ = null;
            _loc3_ = param1 / 1000;
            _loc4_ = -1;
            _loc5_ = 0;
            _loc2_ = new PerformanceLogMessageComposer(_loc3_,this.var_1632,this.var_2072,this.var_2684,this.var_2687,this.var_1920,_loc5_,_loc4_,this.var_1634,this.var_588,this.var_1635);
            this._connection.send(_loc2_);
            this.var_1634 = 0;
            this.var_588 = 0;
            this.var_623 = 0;
            this.var_1635 = 0;
            return true;
         }
         return false;
      }
      
      private function differenceInPercents(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return 0;
         }
         var _loc3_:Number = param1;
         var _loc4_:Number = param2;
         if(param2 > param1)
         {
            _loc3_ = param2;
            _loc4_ = param1;
         }
         return 100 * (1 - _loc4_ / _loc3_);
      }
   }
}
