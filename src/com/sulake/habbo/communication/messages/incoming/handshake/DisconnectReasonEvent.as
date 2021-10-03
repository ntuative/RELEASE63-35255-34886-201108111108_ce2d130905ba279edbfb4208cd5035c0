package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;
   
   public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_2214:int = 0;
      
      public static const const_1789:int = 1;
      
      public static const const_1776:int = 2;
      
      public static const const_2359:int = 3;
      
      public static const const_2167:int = 4;
      
      public static const const_2160:int = 5;
      
      public static const const_1844:int = 10;
      
      public static const const_2346:int = 11;
      
      public static const const_2292:int = 12;
      
      public static const const_2307:int = 13;
      
      public static const const_2202:int = 16;
      
      public static const const_2352:int = 17;
      
      public static const const_2227:int = 18;
      
      public static const const_2349:int = 19;
      
      public static const const_2372:int = 20;
      
      public static const const_2181:int = 22;
      
      public static const const_2192:int = 23;
      
      public static const const_2344:int = 24;
      
      public static const const_2268:int = 25;
      
      public static const const_2176:int = 26;
      
      public static const const_2182:int = 27;
      
      public static const const_2306:int = 28;
      
      public static const const_2277:int = 29;
      
      public static const const_2327:int = 100;
      
      public static const const_2223:int = 101;
      
      public static const const_2270:int = 102;
      
      public static const const_2208:int = 103;
      
      public static const const_2241:int = 104;
      
      public static const const_2328:int = 105;
      
      public static const const_2281:int = 106;
      
      public static const const_2180:int = 107;
      
      public static const const_2154:int = 108;
      
      public static const const_2190:int = 109;
      
      public static const const_2265:int = 110;
      
      public static const const_2177:int = 111;
      
      public static const const_2337:int = 112;
      
      public static const const_2376:int = 113;
      
      public static const const_2245:int = 114;
      
      public static const const_2355:int = 115;
      
      public static const const_2297:int = 116;
      
      public static const const_2317:int = 117;
      
      public static const const_2321:int = 118;
      
      public static const const_2348:int = 119;
       
      
      public function DisconnectReasonEvent(param1:Function)
      {
         super(param1,DisconnectReasonParser);
      }
      
      public function get reason() : int
      {
         return (this.var_9 as DisconnectReasonParser).reason;
      }
      
      public function get reasonString() : String
      {
         switch(this.reason)
         {
            case const_1789:
            case const_1844:
               return "banned";
            case const_1776:
               return "concurrentlogin";
            default:
               return "logout";
         }
      }
   }
}
