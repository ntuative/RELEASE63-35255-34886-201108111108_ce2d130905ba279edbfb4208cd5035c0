package com.sulake.habbo.help
{
   public class WelcomeNotification
   {
       
      
      private var var_2587:String;
      
      private var var_318:String;
      
      public function WelcomeNotification(param1:String, param2:String)
      {
         super();
         this.var_2587 = param1;
         this.var_318 = param2;
      }
      
      public function get targetIconId() : String
      {
         return this.var_2587;
      }
      
      public function get localizationKey() : String
      {
         return this.var_318;
      }
   }
}
