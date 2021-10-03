package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomVisualizationSettingsParser implements IMessageParser
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_2121:Boolean = false;
      
      private var var_1560:Number = 1;
      
      private var var_1129:Number = 1;
      
      public function RoomVisualizationSettingsParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get wallsHidden() : Boolean
      {
         return this.var_2121;
      }
      
      public function get wallThicknessMultiplier() : Number
      {
         return this.var_1560;
      }
      
      public function get floorThicknessMultiplier() : Number
      {
         return this.var_1129;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         this.var_2121 = false;
         this.var_1560 = 1;
         this.var_1129 = 1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.var_2121 = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         if(_loc2_ < -2)
         {
            _loc2_ = -2;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         if(_loc3_ < -2)
         {
            _loc3_ = -2;
         }
         else if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         this.var_1560 = Math.pow(2,_loc2_);
         this.var_1129 = Math.pow(2,_loc3_);
         return true;
      }
   }
}
