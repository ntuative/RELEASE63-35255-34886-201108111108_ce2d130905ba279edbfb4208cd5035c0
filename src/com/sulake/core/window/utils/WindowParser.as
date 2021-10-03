package com.sulake.core.window.utils
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import flash.filters.BitmapFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class WindowParser implements IWindowParser
   {
      
      public static const const_1260:String = "_EXCLUDE";
      
      public static const const_2156:String = "_INCLUDE";
      
      public static const const_2371:String = "_TEMP";
      
      private static const const_1658:String = "layout";
      
      private static const name_6:String = "window";
      
      private static const const_1131:String = "variables";
      
      private static const const_1135:String = "filters";
      
      private static const const_681:String = "name";
      
      private static const const_1650:String = "style";
      
      private static const const_713:String = "params";
      
      private static const const_1652:String = "tags";
      
      private static const X:String = "x";
      
      private static const Y:String = "y";
      
      private static const name_2:String = "width";
      
      private static const name_1:String = "height";
      
      private static const const_1656:String = "visible";
      
      private static const const_1657:String = "caption";
      
      private static const ID:String = "id";
      
      private static const const_4:String = "background";
      
      private static const const_1249:String = "blend";
      
      private static const const_1659:String = "clipping";
      
      private static const COLOR:String = "color";
      
      private static const const_1653:String = "treshold";
      
      private static const const_1651:String = "children";
      
      private static const const_1134:String = "width_min";
      
      private static const WIDTH_MAX:String = "width_max";
      
      private static const const_1132:String = "height_min";
      
      private static const const_1133:String = "height_max";
      
      private static const const_714:String = "true";
      
      private static const const_189:String = "0";
      
      private static const const_1649:String = "$";
      
      private static const const_1534:String = ",";
      
      private static const const_49:String = "";
      
      private static const const_1654:RegExp = /^(\s|\n|\r|\t|\v)*/m;
      
      private static const const_1655:RegExp = /(\s|\n|\r|\t|\v)*$/;
       
      
      protected var var_1443:Dictionary;
      
      protected var var_1444:Dictionary;
      
      protected var var_1168:Dictionary;
      
      protected var var_1733:Dictionary;
      
      protected var var_2290:Map;
      
      protected var _context:IWindowContext;
      
      private var _disposed:Boolean = false;
      
      public function WindowParser(param1:IWindowContext)
      {
         super();
         this._context = param1;
         this.var_1443 = new Dictionary();
         this.var_1444 = new Dictionary();
         TypeCodeTable.fillTables(this.var_1443,this.var_1444);
         this.var_1168 = new Dictionary();
         this.var_1733 = new Dictionary();
         ParamCodeTable.fillTables(this.var_1168,this.var_1733);
         this.var_2290 = new Map();
      }
      
      private static function trimWhiteSpace(param1:String) : String
      {
         param1 = param1.replace(const_1655,const_49);
         return param1.replace(const_1654,const_49);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!this._disposed)
         {
            for(_loc1_ in this.var_1443)
            {
               delete this.var_1443[_loc1_];
            }
            for(_loc1_ in this.var_1444)
            {
               delete this.var_1444[_loc1_];
            }
            for(_loc1_ in this.var_1168)
            {
               delete this.var_1168[_loc1_];
            }
            for(_loc1_ in this.var_1733)
            {
               delete this.var_1733[_loc1_];
            }
            this.var_2290.dispose();
            this.var_2290 = null;
            this._context = null;
            this._disposed = true;
         }
      }
      
      public function parseAndConstruct(param1:XML, param2:IWindow, param3:Map) : IWindow
      {
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         if(param1.localName() == const_1658)
         {
            _loc8_ = param1.child(const_1131);
            if(_loc8_.length() > 0)
            {
               _loc10_ = _loc8_[0];
               _loc11_ = XML(_loc10_[0]).children();
               if(_loc11_.length() > 0)
               {
                  if(param3 == null)
                  {
                     param3 = new Map();
                  }
                  XMLVariableParser.parseVariableList(_loc11_,param3);
               }
            }
            _loc9_ = param1.child(const_1135).children();
            if(_loc9_.length() > 0)
            {
               _loc12_ = new Array();
               _loc13_ = 0;
               while(_loc13_ < _loc9_.length())
               {
                  _loc12_.push(this.buildBitmapFilter(_loc9_[_loc13_]));
                  _loc13_++;
               }
               param2.filters = _loc12_;
            }
            _loc4_ = param1.child(name_6);
            _loc5_ = uint(_loc4_.length());
            switch(_loc5_)
            {
               case 0:
                  return null;
               case 1:
                  param1 = _loc4_[0];
                  break;
               default:
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_)
                  {
                     _loc6_ = this.parseSingleWindowEntity(_loc4_[_loc7_],WindowController(param2),param3);
                     _loc7_++;
                  }
                  return _loc6_;
            }
         }
         if(param1.localName() == name_6)
         {
            _loc4_ = param1.children();
            _loc5_ = uint(_loc4_.length());
            if(_loc5_ > 1)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc6_ = this.parseSingleWindowEntity(_loc4_[_loc7_],WindowController(param2),param3);
                  _loc7_++;
               }
               return _loc6_;
            }
            param1 = param1.children()[0];
         }
         return param1 != null ? this.parseSingleWindowEntity(param1,WindowController(param2),param3) : null;
      }
      
      private function parseSingleWindowEntity(param1:XML, param2:WindowController, param3:Map) : IWindow
      {
         var window:WindowController = null;
         var type:uint = 0;
         var name:String = null;
         var rect:Rectangle = null;
         var node:XML = null;
         var list:XMLList = null;
         var length:uint = 0;
         var i:uint = 0;
         var tags:Array = null;
         var param:String = null;
         var filters:Array = null;
         var iterator:IIterator = null;
         var xml:XML = param1;
         var parent:WindowController = param2;
         var variables:Map = param3;
         var caption:String = const_49;
         var visible:Boolean = true;
         var clipping:Boolean = true;
         var color:String = "0x00ffffff";
         var blend:Number = 1;
         var background:Boolean = false;
         var treshold:uint = 10;
         var style:uint = parent != null ? uint(parent.style) : uint(0);
         var params:uint = 0;
         var tag:String = const_49;
         var id:int = 0;
         type = this.var_1443[xml.localName()];
         name = unescape(String(this.parseAttribute(xml,const_681,variables,"")));
         style = uint(this.parseAttribute(xml,const_1650,variables,style));
         params = uint(this.parseAttribute(xml,const_713,variables,params));
         tag = unescape(String(this.parseAttribute(xml,const_1652,variables,tag)));
         rect = new Rectangle();
         rect.x = Number(this.parseAttribute(xml,X,variables,const_189));
         rect.y = Number(this.parseAttribute(xml,Y,variables,const_189));
         rect.width = Number(this.parseAttribute(xml,name_2,variables,const_189));
         rect.height = Number(this.parseAttribute(xml,name_1,variables,const_189));
         visible = this.parseAttribute(xml,const_1656,variables,visible.toString()) == const_714;
         id = int(this.parseAttribute(xml,ID,variables,id.toString()));
         if(xml.child(const_713).length() > 0)
         {
            list = xml.child(const_713).children();
            length = list.length();
            i = 0;
            while(i < length)
            {
               node = list[i];
               param = this.parseAttribute(node,const_681,variables,"") as String;
               if(this.var_1168[param] == null)
               {
                  throw new Error("Unknown window parameter \"" + String(node.attribute(const_681)) + "\"!");
               }
               params |= this.var_1168[param];
               i++;
            }
         }
         caption = !!(params & 0) ? (!!parent ? parent.caption : const_49) : const_49;
         caption = unescape(String(this.parseAttribute(xml,const_1657,variables,caption)));
         if(tag != const_49)
         {
            tags = tag.split(const_1534);
            length = tags.length;
            i = 0;
            while(i < length)
            {
               tags[i] = WindowParser.trimWhiteSpace(tags[i]);
               i++;
            }
         }
         window = this._context.create(name,null,type,style,params,rect,null,parent is IIterable ? null : parent,id,this.parseProperties(xml.child(const_1131)[0]),tags) as WindowController;
         if(this.hasAttribute(xml,const_1134))
         {
            window.limits.minWidth = int(this.parseAttribute(xml,const_1134,variables,window.limits.minWidth));
         }
         if(this.hasAttribute(xml,WIDTH_MAX))
         {
            window.limits.maxWidth = int(this.parseAttribute(xml,WIDTH_MAX,variables,window.limits.maxWidth));
         }
         if(this.hasAttribute(xml,const_1132))
         {
            window.limits.minHeight = int(this.parseAttribute(xml,const_1132,variables,window.limits.minHeight));
         }
         if(this.hasAttribute(xml,const_1133))
         {
            window.limits.maxHeight = int(this.parseAttribute(xml,const_1133,variables,window.limits.maxHeight));
         }
         background = this.parseAttribute(xml,const_4,variables,window.background.toString()) == const_714;
         blend = Number(this.parseAttribute(xml,const_1249,variables,window.blend.toString()));
         clipping = this.parseAttribute(xml,const_1659,variables,window.clipping.toString()) == const_714;
         color = String(this.parseAttribute(xml,COLOR,variables,window.color.toString()));
         treshold = uint(this.parseAttribute(xml,const_1653,variables,window.mouseThreshold.toString()));
         if(window.caption != caption)
         {
            window.caption = caption;
         }
         if(window.blend != blend)
         {
            window.blend = blend;
         }
         if(window.visible != visible)
         {
            window.visible = visible;
         }
         if(window.clipping != clipping)
         {
            window.clipping = clipping;
         }
         if(window.background != background)
         {
            window.background = background;
         }
         if(window.mouseThreshold != treshold)
         {
            window.mouseThreshold = treshold;
         }
         var temp:uint = color.charAt(1) == X ? uint(parseInt(color,16)) : uint(uint(color));
         if(window.color != temp)
         {
            window.color = temp;
         }
         list = xml.child(const_1135).children();
         length = list.length();
         if(length > 0)
         {
            filters = new Array();
            i = 0;
            while(i < length)
            {
               filters.push(this.buildBitmapFilter(list[i]));
               i++;
            }
            window.filters = filters;
         }
         if(window != null)
         {
            if(parent != null)
            {
               if(parent is IIterable)
               {
                  if(window.x != rect.x || window.y != rect.y || window.width != rect.width || window.height != rect.height)
                  {
                     if((params & 0) == WindowParam.const_223)
                     {
                        window.x = rect.x;
                     }
                     if((params & 0) == WindowParam.const_213)
                     {
                        window.y = rect.y;
                     }
                  }
                  try
                  {
                     iterator = IIterable(parent).iterator;
                  }
                  catch(e:Error)
                  {
                  }
                  if(iterator != null)
                  {
                     iterator[iterator.length] = window;
                  }
                  else
                  {
                     parent.addChild(window);
                  }
               }
            }
         }
         list = xml.child(const_1651);
         if(list.length() > 0)
         {
            node = list[0];
            list = node.children();
            length = list.length();
            i = 0;
            while(i < length)
            {
               this.parseAndConstruct(list[i],window,variables);
               i++;
            }
         }
         return window;
      }
      
      private function hasAttribute(param1:XML, param2:String) : Boolean
      {
         return param1.attribute(param2).length() > 0;
      }
      
      private function parseAttribute(param1:XML, param2:String, param3:Map, param4:Object) : Object
      {
         var _loc5_:XMLList = param1.attribute(param2);
         if(_loc5_.length() == 0)
         {
            return param4;
         }
         var _loc6_:String = String(_loc5_);
         if(param3 != null)
         {
            if(_loc6_.charAt(0) == const_1649)
            {
               _loc6_ = param3[_loc6_.slice(1,_loc6_.length)];
               if(_loc6_ == null)
               {
                  throw new Error("Shared variable not defined: \"" + param1.attribute(param2) + "\"!");
               }
            }
         }
         return _loc6_;
      }
      
      private function parseProperties(param1:XML) : Array
      {
         return param1 != null ? XMLPropertyArrayParser.parse(param1.children()) : new Array();
      }
      
      public function windowToXMLString(param1:IWindow) : String
      {
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc12_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:Boolean = false;
         var _loc2_:* = const_49;
         var _loc3_:String = this.var_1444[param1.type];
         var _loc4_:uint = param1.param;
         var _loc5_:uint = param1.style;
         var _loc6_:IRectLimiter = param1.limits;
         var _loc7_:WindowController = param1 as WindowController;
         _loc2_ += "<" + _loc3_ + " x=\"" + param1.x + "\"" + " y=\"" + param1.y + "\"" + " width=\"" + param1.width + "\"" + " height=\"" + param1.height + "\"" + " params=\"" + param1.param + "\"" + " style=\"" + param1.style + "\"" + (param1.name != const_49 ? " name=\"" + escape(param1.name) + "\"" : const_49) + (param1.caption != const_49 ? " caption=\"" + escape(param1.caption) + "\"" : const_49) + (param1.id != 0 ? " id=\"" + param1.id.toString() + "\"" : const_49) + (param1.color != 16777215 ? " color=\"0x" + param1.alpha.toString(16) + param1.color.toString(16) + "\"" : const_49) + (param1.blend != 1 ? " blend=\"" + param1.blend.toString() + "\"" : const_49) + (param1.visible != true ? " visible=\"" + param1.visible.toString() + "\"" : const_49) + (param1.clipping != true ? " clipping=\"" + param1.clipping.toString() + "\"" : const_49) + (param1.background != false ? " background=\"" + param1.background.toString() + "\"" : const_49) + (param1.mouseThreshold != 10 ? " treshold=\"" + param1.mouseThreshold.toString() + "\"" : const_49) + (param1.tags.length > 0 ? " tags=\"" + escape(param1.tags.toString()) + "\"" : const_49) + (_loc6_.minWidth > int.MIN_VALUE ? " width_min=\"" + _loc6_.minWidth + "\"" : const_49) + (_loc6_.maxWidth < int.MAX_VALUE ? " width_max=\"" + _loc6_.maxWidth + "\"" : const_49) + (_loc6_.minHeight > int.MIN_VALUE ? " height_min=\"" + _loc6_.minHeight + "\"" : const_49) + (_loc6_.maxHeight < int.MAX_VALUE ? " height_max=\"" + _loc6_.maxHeight + "\"" : const_49) + ">\r";
         if(param1.filters && param1.filters.length > 0)
         {
            _loc2_ += "\t<filters>\r";
            for each(_loc15_ in param1.filters)
            {
               _loc2_ += "\t\t" + this.filterToXmlString(_loc15_) + "\r";
            }
            _loc2_ += "\t</filters>\r";
         }
         var _loc9_:uint = _loc7_.numChildren;
         var _loc11_:String = const_49;
         if(_loc7_ is IIterable)
         {
            _loc8_ = IIterable(_loc7_).iterator;
            _loc9_ = _loc8_.length;
            if(_loc9_ > 0)
            {
               _loc12_ = 0;
               while(_loc12_ < _loc9_)
               {
                  _loc10_ = _loc8_[_loc12_] as IWindow;
                  if(_loc10_.tags.indexOf(WindowParser.const_1260) == -1)
                  {
                     _loc11_ += this.windowToXMLString(_loc10_);
                  }
                  _loc12_++;
               }
            }
         }
         else
         {
            _loc9_ = _loc7_.numChildren;
            if(_loc9_ > 0)
            {
               _loc12_ = 0;
               while(_loc12_ < _loc9_)
               {
                  _loc10_ = _loc7_.getChildAt(_loc12_);
                  if(_loc10_.tags.indexOf(WindowParser.const_1260) == -1)
                  {
                     _loc11_ += this.windowToXMLString(_loc10_);
                  }
                  _loc12_++;
               }
            }
         }
         if(_loc11_.length > 0)
         {
            _loc2_ += "\t<children>\r" + _loc11_ + "\t</children>\r";
         }
         var _loc13_:Array = param1.properties;
         if(_loc13_ != null && _loc13_.length > 0)
         {
            _loc16_ = "\t<variables>\r";
            _loc17_ = false;
            _loc12_ = 0;
            while(_loc12_ < _loc13_.length)
            {
               _loc14_ = _loc13_[_loc12_] as PropertyStruct;
               if(_loc14_.valid)
               {
                  _loc16_ += "\t\t" + _loc14_.toXMLString() + "\r";
                  _loc17_ = true;
               }
               _loc12_++;
            }
            _loc16_ += "\t</variables>\r";
            if(_loc17_)
            {
               _loc2_ += _loc16_;
            }
         }
         return _loc2_ + ("</" + _loc3_ + ">\r");
      }
      
      private function buildBitmapFilter(param1:XML) : BitmapFilter
      {
         var _loc3_:* = null;
         var _loc2_:String = param1.localName() as String;
         switch(_loc2_)
         {
            case "DropShadowFilter":
               _loc3_ = new DropShadowFilter(Number(this.parseAttribute(param1,"distance",null,"0")),Number(this.parseAttribute(param1,"angle",null,"45")),uint(this.parseAttribute(param1,"color",null,"0")),Number(this.parseAttribute(param1,"alpha",null,"1")),Number(this.parseAttribute(param1,"blurX",null,"0")),Number(this.parseAttribute(param1,"blurY",null,"0")),Number(this.parseAttribute(param1,"strength",null,"1")),int(this.parseAttribute(param1,"quality",null,"1")),Boolean(this.parseAttribute(param1,"inner",null,"false") == "true"),Boolean(this.parseAttribute(param1,"knockout",null,"false") == "true"),Boolean(this.parseAttribute(param1,"hideObject",null,"false") == "true"));
         }
         return _loc3_;
      }
      
      private function filterToXmlString(param1:BitmapFilter) : String
      {
         var _loc2_:* = null;
         if(param1 is DropShadowFilter)
         {
            _loc2_ = "<DropShadowFilter";
            _loc2_ += DropShadowFilter(param1).distance != 0 ? " distance=\"" + DropShadowFilter(param1).distance + "\"" : "";
            _loc2_ += DropShadowFilter(param1).angle != 45 ? " angle=\"" + DropShadowFilter(param1).angle + "\"" : "";
            _loc2_ += DropShadowFilter(param1).color != 0 ? " color=\"" + DropShadowFilter(param1).color + "\"" : "";
            _loc2_ += DropShadowFilter(param1).alpha != 1 ? " alpha=\"" + DropShadowFilter(param1).alpha + "\"" : "";
            _loc2_ += DropShadowFilter(param1).blurX != 0 ? " blurX=\"" + DropShadowFilter(param1).blurX + "\"" : "";
            _loc2_ += DropShadowFilter(param1).blurY != 0 ? " blurY=\"" + DropShadowFilter(param1).blurY + "\"" : "";
            _loc2_ += DropShadowFilter(param1).strength != 1 ? " strength=\"" + DropShadowFilter(param1).strength + "\"" : "";
            _loc2_ += DropShadowFilter(param1).quality != 1 ? " quality=\"" + DropShadowFilter(param1).quality + "\"" : "";
            _loc2_ += DropShadowFilter(param1).inner != false ? " inner=\"" + DropShadowFilter(param1).inner + "\"" : "";
            _loc2_ += DropShadowFilter(param1).knockout != false ? " knockout=\"" + DropShadowFilter(param1).knockout + "\"" : "";
            _loc2_ += DropShadowFilter(param1).hideObject != false ? " hideObject=\"" + DropShadowFilter(param1).hideObject + "\"" : "";
            _loc2_ += " />";
         }
         return _loc2_;
      }
   }
}
