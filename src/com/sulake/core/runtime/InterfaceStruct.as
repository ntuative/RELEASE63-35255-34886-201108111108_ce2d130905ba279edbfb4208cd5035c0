package com.sulake.core.runtime
{
   import flash.utils.getQualifiedClassName;
   
   final class InterfaceStruct implements IDisposable
   {
       
      
      private var var_1465:IID;
      
      private var var_1760:String;
      
      private var var_120:IUnknown;
      
      private var var_771:uint;
      
      function InterfaceStruct(param1:IID, param2:IUnknown)
      {
         super();
         this.var_1465 = param1;
         this.var_1760 = getQualifiedClassName(this.var_1465);
         this.var_120 = param2;
         this.var_771 = 0;
      }
      
      public function get iid() : IID
      {
         return this.var_1465;
      }
      
      public function get iis() : String
      {
         return this.var_1760;
      }
      
      public function get unknown() : IUnknown
      {
         return this.var_120;
      }
      
      public function get references() : uint
      {
         return this.var_771;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_120 == null;
      }
      
      public function dispose() : void
      {
         this.var_1465 = null;
         this.var_1760 = null;
         this.var_120 = null;
         this.var_771 = 0;
      }
      
      public function reserve() : uint
      {
         return ++this.var_771;
      }
      
      public function release() : uint
      {
         return this.references > 0 ? uint(--this.var_771) : uint(0);
      }
   }
}
