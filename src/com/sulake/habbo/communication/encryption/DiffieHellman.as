package com.sulake.habbo.communication.encryption
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.communication.handshake.IKeyExchange;
   import com.sulake.core.utils.ErrorReportStorage;
   
   public class DiffieHellman implements IKeyExchange
   {
       
      
      private var var_1032:BigInteger;
      
      private var var_3014:BigInteger;
      
      private var var_2178:BigInteger;
      
      private var var_3022:BigInteger;
      
      private var var_1696:BigInteger;
      
      private var var_2179:BigInteger;
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         super();
         this.var_1696 = param1;
         this.var_2179 = param2;
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         ErrorReportStorage.addDebugData("DiffieHellman","Prime: " + this.var_1696.toString() + ",generator: " + this.var_2179.toString() + ",secret: " + param1);
         this.var_1032 = new BigInteger();
         this.var_1032.fromRadix(param1,param2);
         this.var_3014 = this.var_2179.modPow(this.var_1032,this.var_1696);
         return true;
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         this.var_2178 = new BigInteger();
         this.var_2178.fromRadix(param1,param2);
         this.var_3022 = this.var_2178.modPow(this.var_1032,this.var_1696);
         return this.getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return this.var_3014.toRadix(param1);
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return this.var_3022.toRadix(param1);
      }
   }
}
