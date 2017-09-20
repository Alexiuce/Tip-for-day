//
//  XCRefresh.swift
//  XCRefresh
//
//  Created by alexiuce  on 2017/9/20.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Foundation
import AppKit


fileprivate let XC_HeaderHeight : CGFloat  = 30
fileprivate let XC_HeaderTag = 20170920
fileprivate struct XCRuntimeKey {
    static let XCHeaderViewKey = UnsafeRawPointer.init(bitPattern: "XCHeaderViewKey".hashValue)
    static let XCTargetKey = UnsafeRawPointer.init(bitPattern: "XCTargetKey".hashValue)
    static let XCActionKey = UnsafeRawPointer.init(bitPattern: "XCActionKey".hashValue)
}

extension NSScrollView{
    
    var xc_headerView : NSView? {
        set{
            guard let new = newValue else { return }
            objc_setAssociatedObject(self, XCRuntimeKey.XCHeaderViewKey, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, XCRuntimeKey.XCHeaderViewKey) as? NSView
        }
    }
    
    var xc_target : AnyObject? {
        set {
            objc_setAssociatedObject(self, XCRuntimeKey.XCTargetKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return objc_getAssociatedObject(self, XCRuntimeKey.XCTargetKey) as AnyObject
        }
    }
    
    var xc_action : Selector? {
        set{
            objc_setAssociatedObject(self, XCRuntimeKey.XCActionKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return objc_getAssociatedObject(self, XCRuntimeKey.XCActionKey) as? Selector
        }
    }
    
    
    func xc_HeaderRefresh(_ target:AnyObject?, action: Selector? ) {
    
        // 1. 添加HeaderView
        if let hv = xc_headerView {
            hv.removeFromSuperview()
        }
        let contentFrame = contentView.frame
        let headerView = NSView(frame: NSMakeRect(0, -XC_HeaderHeight, NSWidth(contentFrame), XC_HeaderHeight))
    
        headerView.wantsLayer = true
        headerView.layer?.backgroundColor = NSColor.red.cgColor
        contentView.addSubview(headerView)
        xc_headerView = headerView
        
        // 2. 监听bounds
        
      
        // 3. 事件回调
        xc_target = target
        xc_action = action
    }
    
    
    
    
    
}
