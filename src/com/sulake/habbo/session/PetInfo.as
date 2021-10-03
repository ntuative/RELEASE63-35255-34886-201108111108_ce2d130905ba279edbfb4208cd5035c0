package com.sulake.habbo.session
{
   public class PetInfo implements IPetInfo
   {
       
      
      private var var_2051:int;
      
      private var var_1354:int;
      
      private var var_2616:int;
      
      private var var_2613:int;
      
      private var var_2615:int;
      
      private var _energy:int;
      
      private var var_2619:int;
      
      private var _nutrition:int;
      
      private var var_2612:int;
      
      private var var_2617:int;
      
      private var _ownerName:String;
      
      private var var_2847:int;
      
      private var var_548:int;
      
      public function PetInfo()
      {
         super();
      }
      
      public function get petId() : int
      {
         return this.var_2051;
      }
      
      public function get level() : int
      {
         return this.var_1354;
      }
      
      public function get levelMax() : int
      {
         return this.var_2616;
      }
      
      public function get experience() : int
      {
         return this.var_2613;
      }
      
      public function get experienceMax() : int
      {
         return this.var_2615;
      }
      
      public function get energy() : int
      {
         return this._energy;
      }
      
      public function get energyMax() : int
      {
         return this.var_2619;
      }
      
      public function get nutrition() : int
      {
         return this._nutrition;
      }
      
      public function get nutritionMax() : int
      {
         return this.var_2612;
      }
      
      public function get ownerId() : int
      {
         return this.var_2617;
      }
      
      public function get ownerName() : String
      {
         return this._ownerName;
      }
      
      public function get respect() : int
      {
         return this.var_2847;
      }
      
      public function get age() : int
      {
         return this.var_548;
      }
      
      public function set petId(param1:int) : void
      {
         this.var_2051 = param1;
      }
      
      public function set level(param1:int) : void
      {
         this.var_1354 = param1;
      }
      
      public function set levelMax(param1:int) : void
      {
         this.var_2616 = param1;
      }
      
      public function set experience(param1:int) : void
      {
         this.var_2613 = param1;
      }
      
      public function set experienceMax(param1:int) : void
      {
         this.var_2615 = param1;
      }
      
      public function set energy(param1:int) : void
      {
         this._energy = param1;
      }
      
      public function set energyMax(param1:int) : void
      {
         this.var_2619 = param1;
      }
      
      public function set nutrition(param1:int) : void
      {
         this._nutrition = param1;
      }
      
      public function set nutritionMax(param1:int) : void
      {
         this.var_2612 = param1;
      }
      
      public function set ownerId(param1:int) : void
      {
         this.var_2617 = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         this._ownerName = param1;
      }
      
      public function set respect(param1:int) : void
      {
         this.var_2847 = param1;
      }
      
      public function set age(param1:int) : void
      {
         this.var_548 = param1;
      }
   }
}
