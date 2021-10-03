package com.sulake.habbo.avatar
{
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
       
      
      private var var_1577:String;
      
      private var var_203:String;
      
      private var var_3040:String;
      
      private var var_1971:String;
      
      private var _color:IPartColor;
      
      private var _frames:Array;
      
      private var _action:IActionDefinition;
      
      private var var_1707:Boolean;
      
      private var _isBlendable:Boolean;
      
      private var var_3041:ColorTransform;
      
      private var var_2346:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:String, param4:IPartColor, param5:Array, param6:IActionDefinition, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         this.var_1577 = param1;
         this.var_203 = param2;
         this.var_1971 = param3;
         this._color = param4;
         this._frames = param5;
         this._action = param6;
         this.var_1707 = param7;
         this.var_2346 = param8;
         this.var_3040 = param9;
         this._isBlendable = param10;
         this.var_3041 = new ColorTransform(1,1,1,param11);
         if(this._frames == null)
         {
            Logger.log("Null frame list");
         }
         if(this.var_203 == "ey")
         {
            this.var_1707 = false;
         }
      }
      
      public function getFrameIndex(param1:int) : int
      {
         return this._frames[param1 % this._frames.length];
      }
      
      public function get frames() : Array
      {
         return this._frames;
      }
      
      public function get bodyPartId() : String
      {
         return this.var_1577;
      }
      
      public function get include() : String
      {
         return this.var_203;
      }
      
      public function get partId() : String
      {
         return this.var_1971;
      }
      
      public function get color() : IPartColor
      {
         return this._color;
      }
      
      public function get action() : IActionDefinition
      {
         return this._action;
      }
      
      public function set isColorable(param1:Boolean) : void
      {
         this.var_1707 = param1;
      }
      
      public function get isColorable() : Boolean
      {
         return this.var_1707;
      }
      
      public function get paletteMapId() : int
      {
         return this.var_2346;
      }
      
      public function get flippedPartType() : String
      {
         return this.var_3040;
      }
      
      public function get isBlendable() : Boolean
      {
         return this._isBlendable;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return this.var_3041;
      }
   }
}
