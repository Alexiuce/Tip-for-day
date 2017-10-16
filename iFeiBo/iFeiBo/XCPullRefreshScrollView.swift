//
//  XCPullRefreshScrollView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/20.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa



class XCPullRefreshScrollView: NSScrollView {

    fileprivate var headerView : NSView?                // 头部视图
    fileprivate weak var xc_target : AnyObject?            //
    fileprivate var xc_action : Selector?                  //
    fileprivate var headerHeight : CGFloat = 44         //
    fileprivate var isRefreshing = false                //
    
    
    fileprivate var footerView : NSView?                // 底部视图
    fileprivate var isFooterRefreshing = false          // 是否在刷新
    fileprivate weak var xc_footerTarget : AnyObject?
    fileprivate var xc_footerAction : Selector?
    fileprivate var footerHeight : CGFloat = 44
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

 
    override func scrollWheel(with event: NSEvent) {
        if isRefreshing{return}
        if event.phase == .ended {
            
            let currentPoint = event.locationInWindow
            XCPring("\(currentPoint)")
            XCPring("\(contentView.frame)")
            if showHeaderView() {
                startRefreshing()
                return
            }
        }
        super.scrollWheel(with: event)
    }
}


// MARK: setup UI
extension XCPullRefreshScrollView{
    fileprivate func setupHeader(){
        if headerView != nil{return}
        
        let rect = contentView.frame
        headerView = NSView(frame: NSMakeRect(0, -headerHeight, NSWidth(rect), headerHeight))
        headerView?.wantsLayer = true
        contentView.addSubview(headerView!)
        headerView?.layer?.backgroundColor = NSColor.red.cgColor
        headerView?.autoresizingMask = [.viewWidthSizable]
        
    }
    
    fileprivate func setupFooter(){
        if footerView != nil {return}
        
        footerView = NSView(frame: NSZeroRect)
        footerView?.wantsLayer = true
        contentView.addSubview(footerView!)
        footerView?.layer?.backgroundColor = NSColor.green.cgColor
        footerView?.translatesAutoresizingMaskIntoConstraints = false
        guard let docView = documentView else { return  }
        
        let footerCons = [
            footerView!.topAnchor.constraint(equalTo: docView.bottomAnchor, constant: 0),
            footerView!.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            footerView!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            footerView!.heightAnchor.constraint(equalToConstant: footerHeight)
        ]
//        footerView?.autoresizingMask = [.viewWidthSizable]
        NSLayoutConstraint.activate(footerCons)
        
    }
}


extension XCPullRefreshScrollView{
    fileprivate func showHeaderView() -> Bool{
        guard headerView != nil else { return false }
        let scrollY = contentView.bounds.origin.y
        let minScrollY = -headerHeight
        return scrollY <= minScrollY
    }
    
    fileprivate func startRefreshing(){
       
        isRefreshing = true
        documentView?.frame.origin.y = headerHeight
        headerView?.frame.origin.y = 0
        contentView.scroll(to: NSZeroPoint)
        guard let target = xc_target else { return  }
        guard let action = xc_action else { return  }
        _ = target.perform(action)
    }
    
    func stopHeaderRefresh()  {
        isRefreshing = false
        
        headerView?.frame.origin.y = -headerHeight
        documentView?.frame.origin.y = 0
        

    }
    // 结束底部加载更多
    func stopFooterLoadMore()  {
        
    }
    
    func xc_headerRefreshTarget(_ target: AnyObject? ,action : Selector) {
        xc_action = action
        xc_target = target
        setupHeader()
    }
    
    func xc_footerRefreshTarget(_ target : AnyObject?, action : Selector? )  {
        xc_footerAction = action
        xc_footerTarget = target
        setupFooter()
    }
}

