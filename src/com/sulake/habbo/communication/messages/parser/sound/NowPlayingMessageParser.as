package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class NowPlayingMessageParser implements IMessageParser
   {
       
      
      private var var_1979:int;
      
      private var _currentPosition:int;
      
      private var var_1977:int;
      
      private var var_1976:int;
      
      private var var_1978:int;
      
      public function NowPlayingMessageParser()
      {
         super();
      }
      
      public function get currentSongId() : int
      {
         return this.var_1979;
      }
      
      public function get currentPosition() : int
      {
         return this._currentPosition;
      }
      
      public function get nextSongId() : int
      {
         return this.var_1977;
      }
      
      public function get nextPosition() : int
      {
         return this.var_1976;
      }
      
      public function get syncCount() : int
      {
         return this.var_1978;
      }
      
      public function flush() : Boolean
      {
         this.var_1979 = -1;
         this._currentPosition = -1;
         this.var_1977 = -1;
         this.var_1976 = -1;
         this.var_1978 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1979 = param1.readInteger();
         this._currentPosition = param1.readInteger();
         this.var_1977 = param1.readInteger();
         this.var_1976 = param1.readInteger();
         this.var_1978 = param1.readInteger();
         return true;
      }
   }
}
