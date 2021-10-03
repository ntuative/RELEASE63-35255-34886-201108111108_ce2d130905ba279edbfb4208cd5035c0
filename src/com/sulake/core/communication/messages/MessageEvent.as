package com.sulake.core.communication.messages
{
   import com.sulake.core.communication.connection.IConnection;
   
   public class MessageEvent implements IMessageEvent
   {
       
      
      protected var var_315:Function;
      
      protected var _connection:IConnection;
      
      private var _parserClass:Class;
      
      protected var var_9:IMessageParser;
      
      public function MessageEvent(param1:Function, param2:Class)
      {
         super();
         this.var_315 = param1;
         this._parserClass = param2;
      }
      
      public function dispose() : void
      {
         this.var_315 = null;
         this._parserClass = null;
         this._connection = null;
         this.var_9 = null;
      }
      
      public function get callback() : Function
      {
         return this.var_315;
      }
      
      public function set connection(param1:IConnection) : void
      {
         this._connection = param1;
      }
      
      public function get connection() : IConnection
      {
         return this._connection;
      }
      
      public function get parserClass() : Class
      {
         return this._parserClass;
      }
      
      public function set parser(param1:IMessageParser) : void
      {
         this.var_9 = param1;
      }
   }
}
