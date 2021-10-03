package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PerformanceLogMessageComposer implements IMessageComposer
   {
       
      
      private var var_2358:int = 0;
      
      private var var_1632:String = "";
      
      private var var_2072:String = "";
      
      private var var_2684:String = "";
      
      private var var_2687:String = "";
      
      private var var_1920:int = 0;
      
      private var var_2683:int = 0;
      
      private var var_2686:int = 0;
      
      private var var_1634:int = 0;
      
      private var var_2685:int = 0;
      
      private var var_1635:int = 0;
      
      public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
      {
         super();
         this.var_2358 = param1;
         this.var_1632 = param2;
         this.var_2072 = param3;
         this.var_2684 = param4;
         this.var_2687 = param5;
         if(param6)
         {
            this.var_1920 = 1;
         }
         else
         {
            this.var_1920 = 0;
         }
         this.var_2683 = param7;
         this.var_2686 = param8;
         this.var_1634 = param9;
         this.var_2685 = param10;
         this.var_1635 = param11;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2358,this.var_1632,this.var_2072,this.var_2684,this.var_2687,this.var_1920,this.var_2683,this.var_2686,this.var_1634,this.var_2685,this.var_1635];
      }
   }
}
