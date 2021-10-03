package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   
   public class CatalogIndexMessageParser implements IMessageParser
   {
       
      
      private var _root:NodeData;
      
      private var var_1652:Boolean;
      
      public function CatalogIndexMessageParser()
      {
         super();
      }
      
      public function get root() : NodeData
      {
         return this._root;
      }
      
      public function get newAdditionsAvailable() : Boolean
      {
         return this.var_1652;
      }
      
      public function flush() : Boolean
      {
         this._root = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._root = new NodeData(param1);
         this.var_1652 = param1.readBoolean();
         return true;
      }
   }
}
