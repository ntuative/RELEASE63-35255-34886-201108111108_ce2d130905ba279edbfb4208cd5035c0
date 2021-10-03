package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.logic.ObjectLogicBase;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class MovingObjectLogic extends ObjectLogicBase
   {
      
      public static const const_771:int = 500;
      
      private static var var_749:Vector3d = new Vector3d();
       
      
      private var var_508:Vector3d;
      
      private var var_104:Vector3d;
      
      private var var_1146:Number = 0.0;
      
      private var _lastUpdateTime:int = 0;
      
      private var var_3051:int;
      
      private var var_1145:int = 500;
      
      public function MovingObjectLogic()
      {
         this.var_508 = new Vector3d();
         this.var_104 = new Vector3d();
         super();
      }
      
      protected function get lastUpdateTime() : int
      {
         return this._lastUpdateTime;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_104 = null;
         this.var_508 = null;
      }
      
      override public function set object(param1:IRoomObjectController) : void
      {
         super.object = param1;
         if(param1 != null)
         {
            this.var_104.assign(param1.getLocation());
         }
      }
      
      protected function set moveUpdateInterval(param1:int) : void
      {
         if(param1 <= 0)
         {
            param1 = 1;
         }
         this.var_1145 = param1;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         super.processUpdateMessage(param1);
         if(param1.loc != null)
         {
            this.var_104.assign(param1.loc);
         }
         var _loc2_:RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
         if(_loc2_ == null)
         {
            return;
         }
         if(object != null)
         {
            if(param1.loc != null)
            {
               _loc3_ = _loc2_.targetLoc;
               this.var_3051 = this._lastUpdateTime;
               this.var_508.assign(_loc3_);
               this.var_508.sub(this.var_104);
            }
         }
      }
      
      protected function getLocationOffset() : IVector3d
      {
         return null;
      }
      
      override public function update(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:IVector3d = this.getLocationOffset();
         var _loc3_:IRoomObjectModelController = object.getModelController();
         if(_loc3_ != null)
         {
            if(_loc2_ != null)
            {
               if(this.var_1146 != _loc2_.z)
               {
                  this.var_1146 = _loc2_.z;
                  _loc3_.setNumber(RoomObjectVariableEnum.const_1019,this.var_1146);
               }
            }
            else if(this.var_1146 != 0)
            {
               this.var_1146 = 0;
               _loc3_.setNumber(RoomObjectVariableEnum.const_1019,this.var_1146);
            }
         }
         if(this.var_508.length > 0 || _loc2_ != null)
         {
            _loc4_ = param1 - this.var_3051;
            if(_loc4_ == this.var_1145 >> 1)
            {
               _loc4_++;
            }
            if(_loc4_ > this.var_1145)
            {
               _loc4_ = this.var_1145;
            }
            if(this.var_508.length > 0)
            {
               var_749.assign(this.var_508);
               var_749.mul(_loc4_ / Number(this.var_1145));
               var_749.add(this.var_104);
            }
            else
            {
               var_749.assign(this.var_104);
            }
            if(_loc2_ != null)
            {
               var_749.add(_loc2_);
            }
            if(object != null)
            {
               object.setLocation(var_749);
            }
            if(_loc4_ == this.var_1145)
            {
               this.var_508.x = 0;
               this.var_508.y = 0;
               this.var_508.z = 0;
            }
         }
         this._lastUpdateTime = param1;
      }
   }
}
