//
//  ViewController.swift
//  GitHubApiDemo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa
import WebKit
import Alamofire
import SwiftyJSON


class ViewController: NSViewController {

    @IBOutlet weak var topBox: NSView!
    @IBOutlet weak var webView: WebView!
    
    @IBOutlet weak var leftTable: NSTableView!
    
    @IBOutlet weak var searchBar : NSSearchField!
  
    @IBOutlet weak var outlineView : MYOutlineView!
    
    @IBOutlet weak var favButton : NSButton!
    
    var currentRequestName  = ""
    
    

    
    weak var currentSelectedCell : RespositoryCell?   // 记录当前选中的cell
    
    var isSelectedFavorite = false  // 是否收藏
    
    var currentLanguage = ""    // 当前开发语言
    var cellModels : [RespositoryModel]?    // 模型数组
    var caculateCell : RespositoryCell?     // 用于计算行高的cell
    
    lazy var topModel : [RootModel] = {
        var temp = [RootModel]()
        let  rm = RootModel()
        rm.name = "Language"
        rm.childeren = ["OC","Swifit"]
        temp.append(rm)
        
        let rm1 = RootModel()
        rm1.name = "Favorite"
        rm1.childeren = ["AFNetworking","Kingfisher","SwiftyJson"]
        temp.append(rm1)
        
        let rm2 = RootModel()
        rm2.name = "My Respository"
        temp.append(rm2)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(startWebviewLoading(_:)), name: NSNotification.Name.WebViewProgressStarted, object: webView)
        NotificationCenter.default.addObserver(self, selector: #selector(changingWebviewLoadingProcess(_:)), name: NSNotification.Name.WebViewProgressEstimateChanged, object: webView)
    
        
        let server = "https://github.com"
        let url = URL(string: server)!
        let requet = URLRequest(url: url)
        webView.mainFrame.load(requet)
        webView.frameLoadDelegate = self
       
//        let webScroll = webView.webFrame.frameView  //.documentView //as? NSScrollView
//        print(webScroll)
        
        let cellNib = NSNib(nibNamed:"RespositoryCell", bundle: nil)
        leftTable.register(cellNib, forIdentifier: "respositoryCell")
    
        outlineView.rowHeight = 35
       
        
        cellModels = []
        
//        var bookmarkIsStale = false
//        guard let bookmarkData = UserDefaults.standard.value(forKey: "recentUrl") as? Data else {
//            return
//        }
//        guard let recentUrl = try? URL.init(resolvingBookmarkData: bookmarkData, options: URL.BookmarkResolutionOptions.withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &bookmarkIsStale) else {
//            return
//        }
//       _ =  recentUrl?.startAccessingSecurityScopedResource()
//        XCPrint(recentUrl?.path)
//        GitHelper().exeCmd("cd \(recentUrl!.path); ls \(recentUrl!.path)")
        
      
//        XCPrint(view.layer)
    }

    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            XCPrint("dlefaeladsf")
        }
        
     
    
        
    }
    
    
    @IBAction func beginSearch(_ sender : NSButton){
        self.searchRespositories(searchBar.stringValue)
    }
    
    @IBAction func clickFavButton(_ sender : NSButton){
        XCPrint("fav click")
        isSelectedFavorite = !isSelectedFavorite
        let favImgName = isSelectedFavorite ? "fav":"unfav"
        sender.image = NSImage(named: favImgName)
    }
    
    // 选择文档路径
    @IBAction func selectFilePath(_ sender : NSButton){
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        
        openPanel.beginSheetModal(for: view.window!) { (result) in
            if result == NSModalResponseOK {
                let selectUrl = openPanel.url!
                guard let urlBookMark = try? selectUrl.bookmarkData(options: URL.BookmarkCreationOptions.withSecurityScope , includingResourceValuesForKeys: nil, relativeTo: nil) else{
                    return
                }
                UserDefaults.standard.setValue(urlBookMark, forKey: "recentUrl")
                UserDefaults.standard.synchronize()
                
            }
        }
    }
}

// MARK: WebViewDelegate
extension ViewController : WebPolicyDelegate{
    func webView(_ webView: WebView!, decidePolicyForNavigationAction actionInformation: [AnyHashable : Any]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
        
        guard  let host = request.url?.host else {
            listener.use()
            return
        }
        currentRequestName = request.url!.absoluteString
        if host.isEqual("alexiuce.github.io") {
            XCPrint("alexicuce")
            listener.ignore()
        }else{
            listener.use()
        }
    }

}

extension ViewController : WebFrameLoadDelegate{
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        
        
        if !currentRequestName.hasSuffix("README.md") {
            XCProgressHUD.defaultHud.hideHud()
            return
        }
        
    
        let divHeaderClassname = "position-relative js-header-wrapper"
        let reponavDivClassname = "pagehead repohead instapaper_ignore readability-menu experiment-repo-nav"
        let fileNavDivClassname = "file-navigation js-zeroclipboard-container"
        let commitDivClassname = "commit-tease"
        let fileInfoDivClassname = "file-header"
        let divsName = [divHeaderClassname,reponavDivClassname,fileNavDivClassname,commitDivClassname,fileInfoDivClassname]
    
        for classname in divsName {
            let jsCode = "var targetDiv = document.getElementsByClassName('\(classname)')[0]; targetDiv.parentNode.removeChild(targetDiv);"
            webView.stringByEvaluatingJavaScript(from: jsCode)
        }
        XCProgressHUD.defaultHud.hideHud()
    }
}


// MARK: NSTableViewDataSource
extension ViewController : NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        XCPrint(cellModels?.count)
        return cellModels == nil ? 0 : cellModels!.count
    }
}
// MARK: NSTableViewDelegate
extension ViewController : NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "respositoryCell", owner: nil) as! RespositoryCell
        cell.cellModel = cellModels?[row]
       
        return cell
    }
   
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if caculateCell == nil {
            caculateCell = (tableView.make(withIdentifier: "respositoryCell", owner: nil) as! RespositoryCell)
        }
        let model = cellModels?[row]
        caculateCell?.cellModel = model
        return (model?.cellHeight)!
    }

    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
        if tableView == leftTable,edge == .trailing {
             // 从右向左滑动cell ，在cell的尾部（最右边）显示
            let rightAction = NSTableViewRowAction(style: .regular, title: "Demo") { (rowAction, index) in
                XCPrint("click demo ")
            }
            return [rightAction]
        }

       return [NSTableViewRowAction()]   // 从左向右滑动cell ，不显示内容时，传[NSTableViewRowAction()]数组
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
       let selectCell = leftTable.view(atColumn: 0, row: leftTable.selectedRow, makeIfNecessary: true) as? RespositoryCell
        if selectCell == currentSelectedCell {return}
        currentSelectedCell?.selected = false
        selectCell?.selected = true
        currentSelectedCell = selectCell
        let model = cellModels![leftTable.selectedRow]
//        let url = URL(string: model.homeUrl + "/blob/master/README.md")!
        XCProgressHUD.defaultHud.showInView(webView)
        
        let mdUrl = model.homeUrl + "/blob/master/README.md"
        currentRequestName = mdUrl
        guard let cacheHtml = XCCache.share.xc_getCacheValue(key: mdUrl as AnyObject) as? String else {
            // 没有缓存,发送请求,获取内容
            Alamofire.request(model.homeUrl + "/blob/master/README.md", method: .get).responseData { (result) in
                if result.data != nil{
                    guard let resutString = String(data: result.data!, encoding: .utf8) else{
                        return
                    }
                    XCPrint("loading html")
                    self.webView.mainFrame.loadHTMLString(resutString, baseURL: URL(string: ""))
                    XCCache.share.xc_cache(mdUrl as AnyObject, value: resutString as AnyObject)
                }
            }
            
            return
        }
        XCPrint("load cache html")
        webView.mainFrame.loadHTMLString(cacheHtml, baseURL: URL(string: ""))

      
        
//        let requet = URLRequest(url: url)
//        if webView.isLoading {
//            webView.stopLoading(nil)
//        }
//        webView.mainFrame.load(requet)
    }
   
}
// MARK: NSOutlineViewDataSource & NSOutlineViewDelegate
extension ViewController : NSOutlineViewDataSource{
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let item = item as? RootModel {
            return item.childeren.count
        }
        return topModel.count
      }
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? RootModel {
            return item.childeren[index]       // 这里返回的是String类型
        }
        return topModel[index]                // 这里返回的是RootModel类型
    }
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let item = item as? RootModel {
            return item.childeren.count > 0
        }
        return false
    }
}
extension ViewController : NSOutlineViewDelegate{
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var cell : NSTableCellView?
        if item is RootModel {
            cell = outlineView.make(withIdentifier: "HeaderCell", owner: self) as? NSTableCellView
            cell?.textField?.stringValue = (item as! RootModel).name
        }else{
            cell = outlineView.make(withIdentifier: "DataCell", owner: self) as? NSTableCellView
            cell?.textField?.stringValue = item as! String
        }
        return cell
    }
    func outlineViewSelectionDidChange(_ notification: Notification) {
       
        if let text = outlineView.item(atRow: outlineView.selectedRow) as? String {
            let languageModel = topModel.first!
            if languageModel.childeren.contains(text) {
                currentLanguage = text
            }
        }
        XCPrint(currentLanguage)
    }
}

extension ViewController{
    fileprivate func searchRespositories(_ keywork: String){
        let baseURL = "https://api.github.com"
        let apiName = "/search/repositories"
        let para = ["q":keywork]
    
     Alamofire.request(baseURL + apiName, method: .get, parameters: para).responseJSON { (response) in
            if let data = response.data {
                let json = JSON.init(data: data)
                let repos = json["items"].arrayValue
                self.cellModels?.removeAll()
                for item in repos {
                    let repoModel = RespositoryModel()
                    repoModel.title =  item["name"].stringValue
                    repoModel.language = item["language"].stringValue
                    repoModel.desc = item["description"].stringValue
                    repoModel.imageUrl = item["owner"]["avatar_url"].stringValue
                    repoModel.homeUrl = item["html_url"].stringValue
                    self.cellModels?.append(repoModel)
                }
               self.leftTable.reloadData()
            }
        }
    }
}

// MARK: Notification Listion 
extension ViewController{
    func startWebviewLoading(_ notification : Notification) {
        XCPrint("start   \(notification)")
        XCProgressHUD.defaultHud.showInView(webView)
        
    }
    func changingWebviewLoadingProcess(_ notification : Notification)  {
        XCPrint("change process \(webView.estimatedProgress)")
        XCProgressHUD.defaultHud.loadProgress = CGFloat(webView.estimatedProgress)
       
    }
    
}


