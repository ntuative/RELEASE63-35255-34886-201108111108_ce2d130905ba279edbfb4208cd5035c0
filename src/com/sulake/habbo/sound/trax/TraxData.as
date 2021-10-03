package com.sulake.habbo.sound.trax
{
   import com.sulake.core.utils.Map;
   
   public class TraxData
   {
       
      
      private var var_1306:Array;
      
      private var var_1305:Map;
      
      public function TraxData(param1:String)
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         this.var_1305 = new Map();
         super();
         this.var_1306 = [];
         var _loc3_:Array = param1.split(":");
         var _loc4_:String = String(_loc3_[_loc3_.length - 1]);
         if(_loc4_.indexOf("meta") != -1)
         {
            _loc6_ = _loc4_.split(";");
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc8_ = String(_loc6_[_loc7_]).split(",")[0];
               _loc9_ = String(_loc6_[_loc7_]).split(",")[1];
               this.var_1305.add(_loc8_,_loc9_);
               _loc7_++;
            }
            _loc2_ = _loc3_.slice(0,_loc3_.length - 1);
         }
         else
         {
            _loc2_ = _loc3_;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length / 2)
         {
            if(_loc2_[_loc5_ * 2].toString().length > 0)
            {
               _loc10_ = int(_loc2_[_loc5_ * 2]);
               _loc11_ = _loc2_[_loc5_ * 2 + 1].toString().split(";");
               _loc12_ = new TraxChannel(_loc10_);
               _loc13_ = 0;
               while(_loc13_ < _loc11_.length)
               {
                  _loc14_ = _loc11_[_loc13_].toString().split(",");
                  if(_loc14_.length != 2)
                  {
                     Logger.log("Trax load error: invalid song data string");
                     return;
                  }
                  _loc15_ = int(_loc14_[0]);
                  _loc16_ = int(_loc14_[1]);
                  _loc12_.addChannelItem(new TraxChannelItem(_loc15_,_loc16_));
                  _loc13_++;
               }
               this.var_1306.push(_loc12_);
            }
            _loc5_++;
         }
      }
      
      public function get channels() : Array
      {
         return this.var_1306;
      }
      
      public function getSampleIds() : Array
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc1_:* = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.var_1306.length)
         {
            _loc3_ = this.var_1306[_loc2_] as TraxChannel;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.itemCount)
            {
               _loc5_ = _loc3_.getItem(_loc4_);
               if(_loc1_.indexOf(_loc5_.id) == -1)
               {
                  _loc1_.push(_loc5_.id);
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get hasMetaData() : Boolean
      {
         return this.var_1305["meta"] != null;
      }
      
      public function get metaCutMode() : Boolean
      {
         return this.var_1305["c"] == "1";
      }
      
      public function get metaTempo() : int
      {
         return this.var_1305["t"] as int;
      }
   }
}
