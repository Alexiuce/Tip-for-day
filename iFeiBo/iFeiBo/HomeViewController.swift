//
//  HomeViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire


let reusedKey = "homeCell"
let friendReusedKey = "friendCell"

class HomeViewController: NSViewController {
    
    @IBOutlet weak var friendsTableView: NSTableView!

    @IBOutlet weak var homeTableView: NSTableView!         // NSTableView
    @IBOutlet weak var scrollView: XCPullRefreshScrollView!
    
    

    var statuses : [WBStatus] = []
    var friends : [WBStatusUser] = []
    
    var currentSelectView : HomeCellView?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewResize), name: .NSViewFrameDidChange, object: homeTableView)
        
        // 下拉刷新
        scrollView.xc_headerRefreshTarget(self, action: #selector(reloadHeader))
        // 上拉加载更多
        scrollView.xc_footerRefreshTarget(self, action: #selector(loadMoreFooter))
        
        HTTPManager.getWBStatus { (dict) in
            self.statuses = WBStatus.statusesFromDicts(dict?["statuses"] as! [[String : Any]])
            self.homeTableView.reloadData()
        }
        
        
    }
    
    func handleTableViewResize(){
      
            let indexes = IndexSet(integersIn: 0..<homeTableView.numberOfRows)
            NSAnimationContext.beginGrouping()
            NSAnimationContext.current().duration = 0
            homeTableView.noteHeightOfRows(withIndexesChanged: indexes)
            NSAnimationContext.endGrouping()
    }
}

// MARK: - NSTableViewDataSource
extension HomeViewController : NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableView == homeTableView ? statuses.count : friends.count
    }
    
}
// MARK: -  NSTableViewDelegate
extension HomeViewController : NSTableViewDelegate{

    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // friend tableView
        if tableView == friendsTableView {
            let cell = tableView.make(withIdentifier: friendReusedKey, owner: self) as! FridendsCellView
            return cell
        }
        // home tableView
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeCellView
        cell.status = statuses[row]
        return cell

    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        // friend
        if tableView == friendsTableView {return 60}
        // home
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeCellView
        
        cell.status = statuses[row]
        
        cell.frame.size.width = tableView.bounds.size.width
        
        cell.needsLayout = true
        cell.layoutSubtreeIfNeeded()
        
        return cell.fittingSize.height
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let tableView = notification.object as? NSTableView {
            if tableView == friendsTableView {
                
                return
            }
        }
        
        guard let selectView = homeTableView.view(atColumn: 0, row: homeTableView.selectedRow, makeIfNecessary: false) as? HomeCellView else {return}
        if let currentSelectView = currentSelectView {
            currentSelectView.backgroundStyle = .light
        }
        selectView.backgroundStyle = .dark
        currentSelectView = selectView
    }
}

// MARK: Refresh method
extension HomeViewController{
    func reloadHeader() {

       guard let loadID = statuses.first?.id  else { return  }
        
        HTTPManager.getWBStatus(loadID) { (dict) in
            let newWBStatus = WBStatus.statusesFromDicts(dict?["statuses"] as! [[String : Any]] )
            self.statuses = newWBStatus + self.statuses
            self.homeTableView.reloadData()
            self.scrollView.stopHeaderRefresh()
        }
    }
    
    func loadMoreFooter()  {
        XCPring("footer more")
    }
}

