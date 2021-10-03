package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class OpenIssuesView implements IIssueBrowserView
   {
       
      
      private var _issueManager:IssueManager;
      
      private var var_740:IssueBrowser;
      
      private var _window:IWindowContainer;
      
      private var var_2766:IssueListView;
      
      public function OpenIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowContainer)
      {
         super();
         this._issueManager = param1;
         this.var_740 = param2;
         this._window = this.var_740.createWindow("open_issues_xml") as IWindowContainer;
         param3.addChild(this._window);
         var _loc4_:IItemListWindow = this._window.findChildByName("issue_list") as IItemListWindow;
         this.var_2766 = new IssueListView(param1,param2,_loc4_,"open_issues_list_item_xml");
      }
      
      public function get view() : IWindowContainer
      {
         return this._window;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this._window.visible = param1;
      }
      
      public function update() : void
      {
         var _loc1_:Array = this._issueManager.getBundles(IssueManager.const_1313);
         this.var_2766.update(_loc1_);
      }
   }
}
