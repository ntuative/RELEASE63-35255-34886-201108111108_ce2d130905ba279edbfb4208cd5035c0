package com.sulake.core.communication.connection
{
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.messages.IMessageClassManager;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.communication.messages.MessageClassManager;
   import com.sulake.core.communication.messages.MessageDataWrapper;
   import com.sulake.core.communication.protocol.IProtocol;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.ErrorReportStorage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class SocketConnection extends EventDispatcher implements IConnection, IDisposable
   {
      
      public static const const_1936:int = 10000;
       
      
      private var _disposed:Boolean = false;
      
      private var var_83:Socket;
      
      private var var_544:ByteArray;
      
      private var var_1214:IEncryption;
      
      private var var_789:IProtocol;
      
      private var _id:String;
      
      private var var_1215:IMessageClassManager;
      
      private var var_268:ICoreCommunicationManager;
      
      private var var_543:IConnectionStateListener;
      
      private var var_214:Timer;
      
      private var var_788:int;
      
      private var var_1838:Boolean = false;
      
      public function SocketConnection(param1:String, param2:ICoreCommunicationManager, param3:IConnectionStateListener)
      {
         super();
         this._id = param1;
         this.var_268 = param2;
         this.var_544 = new ByteArray();
         this.var_1215 = new MessageClassManager();
         this.var_83 = new Socket();
         this.var_214 = new Timer(const_1936,1);
         this.var_214.addEventListener(TimerEvent.TIMER,this.onTimeOutTimer);
         this.var_83.addEventListener(Event.CONNECT,this.onConnect);
         this.var_83.addEventListener(Event.COMPLETE,this.onComplete);
         this.var_83.addEventListener(Event.CLOSE,this.onClose);
         this.var_83.addEventListener(ProgressEvent.SOCKET_DATA,this.onRead);
         this.var_83.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this.var_83.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.var_543 = param3;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set protocol(param1:IProtocol) : void
      {
         this.var_789 = param1;
      }
      
      public function get protocol() : IProtocol
      {
         return this.var_789;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this._disposed = true;
         if(this.var_83)
         {
            this.var_83.removeEventListener(Event.CONNECT,this.onConnect);
            this.var_83.removeEventListener(Event.COMPLETE,this.onComplete);
            this.var_83.removeEventListener(Event.CLOSE,this.onClose);
            this.var_83.removeEventListener(ProgressEvent.SOCKET_DATA,this.onRead);
            this.var_83.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
            this.var_83.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            if(this.var_1838)
            {
               this.var_83.close();
            }
         }
         this.var_83 = null;
         if(this.var_214)
         {
            this.var_214.stop();
            this.var_214.removeEventListener(TimerEvent.TIMER,this.onTimeOutTimer);
         }
         this.var_214 = null;
         this.var_544 = null;
         this.var_543 = null;
         this.var_1214 = null;
         this.var_789 = null;
         this._id = null;
         this.var_1215 = null;
         this.var_268 = null;
         this.var_543 = null;
      }
      
      public function init(param1:String, param2:uint = 0) : Boolean
      {
         this.logConnection("Connecting to " + param1 + ":" + param2);
         if(this.var_543)
         {
            this.var_543.connectionInit(param1,param2);
         }
         Security.loadPolicyFile("xmlsocket://" + param1 + ":" + param2);
         this.var_214.start();
         this.var_788 = getTimer();
         this.var_83.connect(param1,param2);
         return true;
      }
      
      public function set timeout(param1:int) : void
      {
         this.var_214.delay = param1;
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(this.disposed)
         {
            return;
         }
         this.var_268.addConnectionMessageEvent(this._id,param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(this.disposed)
         {
            return;
         }
         this.var_268.removeConnectionMessageEvent(this._id,param1);
      }
      
      public function send(param1:IMessageComposer, param2:int = -1) : Boolean
      {
         if(this.disposed)
         {
            return false;
         }
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = this.var_1215.getMessageComposerID(param1);
         if(_loc4_ < 0)
         {
            this.logConnection("Could not find registered message composer for " + param1);
            return false;
         }
         var _loc5_:Array = param1.getMessageArray();
         var _loc6_:ByteArray = this.var_789.encoder.encode(_loc4_,_loc5_,param2);
         if(this.var_543)
         {
            this.var_543.messageSent(String(_loc4_),_loc6_.toString());
         }
         if(this.var_1214 != null)
         {
            _loc3_ = this.var_1214.encipher(_loc6_);
         }
         else
         {
            _loc3_ = _loc6_;
         }
         if(this.var_83.connected)
         {
            this.var_83.writeBytes(_loc3_);
            this.var_83.flush();
            return true;
         }
         this.logConnection("[SOCKET] Not connected.");
         return false;
      }
      
      public function setEncryption(param1:IEncryption) : void
      {
         this.var_1214 = param1;
      }
      
      public function registerMessageClasses(param1:IMessageConfiguration) : void
      {
         this.var_1215.registerMessages(param1);
      }
      
      override public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ += "Socket Connection: \n";
         _loc1_ += "Protocol Encoder: " + this.var_789.encoder + "\n";
         _loc1_ += "Protocol Decoder: " + this.var_789.decoder + "\n";
         return _loc1_ + ("Encryption: " + this.var_1214 + "\n");
      }
      
      public function processReceivedData() : void
      {
         var id:int = 0;
         var message:Array = null;
         var data:ByteArray = null;
         var eventClasses:Array = null;
         var events:Array = null;
         var eventClass:Class = null;
         var eventsForClass:Array = null;
         var parserInstance:IMessageParser = null;
         var parserClassCurrent:Class = null;
         var dataClone:ByteArray = null;
         var messageEventInstance:IMessageEvent = null;
         var parserClass:Class = null;
         var dataWrapper:IMessageDataWrapper = null;
         var wasParsed:Boolean = false;
         var temp:ByteArray = null;
         if(this.disposed)
         {
            return;
         }
         var receivedMessages:Array = new Array();
         var offset:uint = this.var_789.getMessages(this.var_544,receivedMessages);
         try
         {
            for each(message in receivedMessages)
            {
               id = message[0] as int;
               data = message[1] as ByteArray;
               if(this.var_543)
               {
                  this.var_543.messageReceived(String(id),data.toString());
               }
               eventClasses = this.var_1215.getMessageEventClasses(id);
               events = new Array();
               for each(eventClass in eventClasses)
               {
                  eventsForClass = this.var_268.getMessageEvents(this,eventClass);
                  events = events.concat(eventsForClass);
               }
               parserInstance = null;
               parserClassCurrent = null;
               for each(messageEventInstance in events)
               {
                  parserClass = messageEventInstance.parserClass;
                  if(parserClass != null)
                  {
                     wasParsed = false;
                     if(parserClass != parserClassCurrent)
                     {
                        dataClone = new ByteArray();
                        dataClone.writeBytes(data);
                        dataClone.position = data.position;
                        dataWrapper = new MessageDataWrapper(dataClone,this.protocol.decoder);
                        parserInstance = this.var_268.getMessageParser(parserClass);
                        if(!parserInstance.flush())
                        {
                           this.logConnection(">>[SocketConnection] Message Event Parser wasn\'t flushed: " + [id,parserClass,parserInstance]);
                        }
                        else if(parserInstance.parse(dataWrapper))
                        {
                           parserClassCurrent = parserClass;
                           wasParsed = true;
                        }
                     }
                     else
                     {
                        wasParsed = true;
                     }
                     if(wasParsed)
                     {
                        messageEventInstance.connection = this;
                        messageEventInstance.parser = parserInstance;
                        messageEventInstance.callback.call(null,messageEventInstance);
                     }
                     else
                     {
                        parserClassCurrent = null;
                        parserInstance = null;
                     }
                  }
               }
            }
            if(offset == this.var_544.length)
            {
               this.var_544 = new ByteArray();
            }
            else if(offset > 0)
            {
               temp = new ByteArray();
               temp.writeBytes(this.var_544,offset);
               this.var_544 = temp;
               this.logConnection("[SOCKET REST] offset: " + offset + " rest: " + this.var_544.toString());
            }
         }
         catch(e:Error)
         {
            if(!disposed)
            {
               ErrorReportStorage.addDebugData("SocketConnection","Crashed while processing incoming message with id=\"" + id + "\"!");
               throw e;
            }
         }
      }
      
      public function get connected() : Boolean
      {
         if(this.var_83 == null)
         {
            return false;
         }
         return this.var_83.connected;
      }
      
      private function onRead(param1:ProgressEvent) : void
      {
         if(this.var_83 == null)
         {
            return;
         }
         while(this.var_83.bytesAvailable > 0)
         {
            this.var_544.writeByte(this.var_83.readUnsignedByte());
         }
      }
      
      private function onConnect(param1:Event) : void
      {
         this.logConnection("[SocketConnection] Connected");
         this.var_214.stop();
         this.var_1838 = true;
         ErrorReportStorage.addDebugData("ConnectionTimer","Connected in " + (getTimer() - this.var_788));
         dispatchEvent(param1);
      }
      
      private function onClose(param1:Event) : void
      {
         this.var_214.stop();
         this.logConnection("[SocketConnection] Closed");
         this.var_1838 = false;
         ErrorReportStorage.addDebugData("ConnectionTimer","Closed in " + (getTimer() - this.var_788));
         dispatchEvent(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.var_214.stop();
         this.logConnection("[SocketConnection] Complete");
         ErrorReportStorage.addDebugData("ConnectionTimer","Completed in " + (getTimer() - this.var_788));
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.var_214.stop();
         this.logConnection("[SocketConnection] Security Error: " + param1.text);
         ErrorReportStorage.addDebugData("ConnectionTimer","SecurityError in " + (getTimer() - this.var_788));
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.var_214.stop();
         this.logConnection("[SocketConnection] IO Error: " + param1.text);
         ErrorReportStorage.addDebugData("ConnectionTimer","IOError in " + (getTimer() - this.var_788));
         switch(param1.type)
         {
            case IOErrorEvent.IO_ERROR:
               break;
            case IOErrorEvent.DISK_ERROR:
               break;
            case IOErrorEvent.NETWORK_ERROR:
               break;
            case IOErrorEvent.VERIFY_ERROR:
         }
         dispatchEvent(param1);
      }
      
      private function onTimeOutTimer(param1:TimerEvent) : void
      {
         this.var_214.stop();
         this.logConnection("[SocketConnection] TimeOut Error");
         ErrorReportStorage.addDebugData("ConnectionTimer","TimeOut in " + (getTimer() - this.var_788));
         var _loc2_:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
         _loc2_.text = "Socket Timeout (" + this.var_214.delay + " ms). Possible Firewall.";
         dispatchEvent(_loc2_);
      }
      
      private function logConnection(param1:String) : void
      {
      }
   }
}
