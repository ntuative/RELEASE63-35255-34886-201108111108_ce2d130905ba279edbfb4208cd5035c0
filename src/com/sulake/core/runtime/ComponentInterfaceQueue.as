package com.sulake.core.runtime
{
   class ComponentInterfaceQueue implements IDisposable
   {
       
      
      private var var_1895:IID;
      
      private var var_1173:Boolean;
      
      private var var_1243:Array;
      
      function ComponentInterfaceQueue(param1:IID)
      {
         super();
         this.var_1895 = param1;
         this.var_1243 = new Array();
         this.var_1173 = false;
      }
      
      public function get identifier() : IID
      {
         return this.var_1895;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      public function get receivers() : Array
      {
         return this.var_1243;
      }
      
      public function dispose() : void
      {
         if(!this.var_1173)
         {
            this.var_1173 = true;
            this.var_1895 = null;
            while(this.var_1243.length > 0)
            {
               this.var_1243.pop();
            }
            this.var_1243 = null;
         }
      }
   }
}
