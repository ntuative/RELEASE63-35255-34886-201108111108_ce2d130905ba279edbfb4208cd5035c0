package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendRequestData
   {
       
      
      private var var_1372:int;
      
      private var var_2965:String;
      
      private var var_2966:int;
      
      private var var_2819:String;
      
      public function FriendRequestData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1372 = param1.readInteger();
         this.var_2965 = param1.readString();
         this.var_2819 = param1.readString();
         this.var_2966 = this.var_1372;
      }
      
      public function get requestId() : int
      {
         return this.var_1372;
      }
      
      public function get requesterName() : String
      {
         return this.var_2965;
      }
      
      public function get requesterUserId() : int
      {
         return this.var_2966;
      }
      
      public function get figureString() : String
      {
         return this.var_2819;
      }
   }
}
