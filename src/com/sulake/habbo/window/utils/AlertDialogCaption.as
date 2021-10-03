package com.sulake.habbo.window.utils
{
   class AlertDialogCaption implements ICaption
   {
       
      
      private var _text:String;
      
      private var var_2232:String;
      
      private var var_323:Boolean;
      
      function AlertDialogCaption(param1:String, param2:String, param3:Boolean)
      {
         super();
         this._text = param1;
         this.var_2232 = param2;
         this.var_323 = param3;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function get toolTip() : String
      {
         return this.var_2232;
      }
      
      public function set toolTip(param1:String) : void
      {
         this.var_2232 = param1;
      }
      
      public function get visible() : Boolean
      {
         return this.var_323;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.var_323 = param1;
      }
   }
}
