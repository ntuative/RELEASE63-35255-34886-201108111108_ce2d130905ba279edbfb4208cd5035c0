package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   
   public class AvatarImageBodyPartCache
   {
       
      
      private var var_286:Map;
      
      private var var_932:IActiveActionData;
      
      private var var_3055:int;
      
      private var _disposed:Boolean;
      
      public function AvatarImageBodyPartCache()
      {
         super();
         this.var_286 = new Map();
      }
      
      public function setAction(param1:IActiveActionData, param2:int) : void
      {
         if(this.var_932 == null)
         {
            this.var_932 = param1;
         }
         var _loc3_:AvatarImageActionCache = this.getActionCache(this.var_932);
         if(_loc3_ != null)
         {
            _loc3_.setLastAccessTime(param2);
         }
         this.var_932 = param1;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(this.var_286 == null)
            {
               return;
            }
            Logger.log("[dispose]");
            if(this.var_286)
            {
               this.disposeActions(0,int.MAX_VALUE);
               this.var_286.dispose();
               this.var_286 = null;
            }
            this._disposed = true;
         }
      }
      
      public function disposeActions(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         if(this.var_286 == null || this._disposed)
         {
            return;
         }
         var _loc5_:Array = this.var_286.getKeys();
         for each(_loc6_ in _loc5_)
         {
            _loc4_ = this.var_286.getValue(_loc6_) as AvatarImageActionCache;
            if(_loc4_ != null)
            {
               _loc3_ = _loc4_.getLastAccessTime();
               if(param2 - _loc3_ >= param1)
               {
                  Logger.log("[Disposing inactive: " + _loc6_ + "]");
                  _loc4_.dispose();
                  this.var_286.remove(_loc6_);
               }
            }
         }
      }
      
      public function getAction() : IActiveActionData
      {
         return this.var_932;
      }
      
      public function setDirection(param1:int) : void
      {
         this.var_3055 = param1;
      }
      
      public function getDirection() : int
      {
         return this.var_3055;
      }
      
      public function getActionCache(param1:IActiveActionData = null) : AvatarImageActionCache
      {
         if(!this.var_932)
         {
            return null;
         }
         if(param1 == null)
         {
            param1 = this.var_932;
         }
         return this.var_286.getValue(param1.id) as AvatarImageActionCache;
      }
      
      public function updateActionCache(param1:IActiveActionData, param2:AvatarImageActionCache) : void
      {
         this.var_286.add(param1.id,param2);
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}
