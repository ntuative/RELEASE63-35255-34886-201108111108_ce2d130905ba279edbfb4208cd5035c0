package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
   import flash.utils.Dictionary;
   
   public class AvatarSearchResults
   {
       
      
      private var var_471:IAvatarSearchDeps;
      
      private var var_252:Array;
      
      private var var_1925:Array;
      
      private var var_2163:Dictionary;
      
      public function AvatarSearchResults(param1:IAvatarSearchDeps)
      {
         this.var_2163 = new Dictionary();
         super();
         this.var_471 = param1;
      }
      
      public function getResult(param1:int) : HabboSearchResultData
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(_loc2_ in this.var_252)
         {
            if(_loc2_.avatarId == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc3_ in this.var_1925)
         {
            if(_loc3_.avatarId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function searchReceived(param1:Array, param2:Array) : void
      {
         this.var_252 = param1;
         this.var_1925 = param2;
         this.var_471.view.refreshList();
      }
      
      public function get friends() : Array
      {
         return this.var_252;
      }
      
      public function get others() : Array
      {
         return this.var_1925;
      }
      
      public function setFriendRequestSent(param1:int) : void
      {
         this.var_2163[param1] = "yes";
      }
      
      public function isFriendRequestSent(param1:int) : Boolean
      {
         return this.var_2163[param1] != null;
      }
   }
}
