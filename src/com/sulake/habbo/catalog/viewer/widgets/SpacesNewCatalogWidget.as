package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.catalog.viewer.IGridItem;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, ICatalogWidget, IItemGrid
   {
       
      
      private var _groupNames:Array;
      
      private var var_213:Array;
      
      private var var_481:int = 0;
      
      private var var_739:Array;
      
      private var var_484:ISelectorWindow;
      
      private var var_119:Array;
      
      public function SpacesNewCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager)
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         this._groupNames = ["wallpaper","floor","landscape"];
         this.var_213 = new Array();
         this.var_739 = [0,0,0];
         this.var_119 = ["group.walls","group.floors","group.views"];
         super(param1,param2);
         this.var_484 = _window.findChildByName("groups") as ISelectorWindow;
         if(this.var_484)
         {
            _loc3_ = 0;
            while(_loc3_ < this.var_484.numSelectables)
            {
               _loc4_ = this.var_484.getSelectableAt(_loc3_);
               if(_loc4_ is ISelectableWindow)
               {
                  _loc4_.addEventListener(WindowEvent.const_47,this.onSelectGroup);
               }
               _loc3_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         super.dispose();
         for each(_loc1_ in this.var_213)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.dispose();
            }
         }
         this.var_213 = null;
      }
      
      override public function init() : Boolean
      {
         Logger.log("Init Item Group Catalog Widget (Spaces New)");
         this.createOfferGroups();
         if(!super.init())
         {
            return false;
         }
         events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED,this.onWidgetsInitialized);
         this.switchCategory(this.var_119[this.var_481]);
         this.updateRoomPreview();
         return true;
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent) : void
      {
         var _loc2_:int = this.var_739[this.var_481];
         var _loc3_:Offer = this.var_213[this.var_481][_loc2_];
         this.select(_loc3_.productContainer as IGridItem);
      }
      
      public function selectIndex(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 > -1 && param1 < var_516.numGridItems)
         {
            _loc2_ = this.var_213[this.var_481][param1];
            this.select(_loc2_.productContainer as IGridItem);
         }
      }
      
      override public function select(param1:IGridItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.select(param1);
         var _loc2_:Offer = (param1 as ProductContainer).offer;
         if(_loc2_ == null)
         {
            return;
         }
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc2_.productContainer.firstProduct.extraParam));
         this.var_739[this.var_481] = (this.var_213[this.var_481] as Array).indexOf(_loc2_);
         this.updateRoomPreview();
      }
      
      private function updateRoomPreview() : void
      {
         var _loc1_:int = this.var_739[0];
         var _loc2_:int = this.var_739[1];
         var _loc3_:int = this.var_739[2];
         var _loc4_:Offer = this.var_213[0][_loc1_];
         var _loc5_:Offer = this.var_213[1][_loc2_];
         var _loc6_:Offer = this.var_213[2][_loc3_];
         if(!_loc5_ || !_loc4_ || !_loc6_)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc5_.productContainer.firstProduct.extraParam,_loc4_.productContainer.firstProduct.extraParam,_loc6_.productContainer.firstProduct.extraParam,64));
      }
      
      private function createOfferGroups() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         for each(_loc1_ in page.offers)
         {
            if(!(_loc1_.pricingModel == Offer.const_400 || _loc1_.pricingModel == Offer.const_403))
            {
               continue;
            }
            _loc2_ = _loc1_.productContainer.firstProduct;
            if(_loc2_ == null)
            {
               continue;
            }
            _loc3_ = _loc2_.productClassId;
            if(!(_loc2_.productType == ProductTypeEnum.const_65 || _loc2_.productType == ProductTypeEnum.const_71))
            {
               continue;
            }
            if(_loc2_.furnitureData == null)
            {
               continue;
            }
            _loc4_ = _loc2_.furnitureData.name;
            _loc5_ = this._groupNames.indexOf(_loc4_);
            if(this._groupNames.indexOf(_loc4_) == -1)
            {
               this._groupNames.push(_loc4_);
            }
            while(this.var_213.length < this._groupNames.length)
            {
               this.var_213.push(new Array());
            }
            switch(_loc4_)
            {
               case "floor":
                  (this.var_213[_loc5_] as Array).push(_loc1_);
                  break;
               case "wallpaper":
                  (this.var_213[_loc5_] as Array).push(_loc1_);
                  break;
               case "landscape":
                  (this.var_213[_loc5_] as Array).push(_loc1_);
                  break;
               default:
                  Logger.log("[SpacesCatalogWidget] : " + _loc4_);
                  break;
            }
         }
         page.replaceOffers([],false);
         return true;
      }
      
      private function onSelectGroup(param1:WindowEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ISelectableWindow = param1.target as ISelectableWindow;
         if(_loc2_)
         {
            _loc3_ = this.var_484.getSelectableIndex(_loc2_);
            Logger.log("select: " + [_loc2_.name,_loc3_]);
            this.switchCategory(_loc2_.name);
         }
      }
      
      private function switchCategory(param1:String) : void
      {
         var _loc3_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!this.var_484)
         {
            return;
         }
         this.var_484.setSelected(this.var_484.getSelectableByName(param1));
         var _loc2_:int = -1;
         switch(param1)
         {
            case "group.walls":
               _loc2_ = 0;
               break;
            case "group.floors":
               _loc2_ = 1;
               break;
            case "group.views":
               _loc2_ = 2;
               break;
            default:
               _loc2_ = -1;
         }
         if(_loc2_ > -1)
         {
            if(var_235 != null)
            {
               var_235.deActivate();
            }
            var_235 = null;
            this.var_481 = _loc2_;
            if(var_516)
            {
               var_516.destroyGridItems();
            }
            page.replaceOffers(this.var_213[this.var_481],false);
            resetTimer();
            populateItemGrid();
            loadItemGridGraphics();
            if(var_228)
            {
               var_228.start();
            }
            _loc3_ = this.var_739[this.var_481];
            this.selectIndex(_loc3_);
         }
      }
   }
}
