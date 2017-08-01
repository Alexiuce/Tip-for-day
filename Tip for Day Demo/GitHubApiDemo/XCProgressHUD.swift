//
//  XCProgressHUD.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/8/1.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa


class XCProgressHUD: NSObject {
    // 1. 单利
    static let defaultHud = XCProgressHUD()
    
    // hudLayer
    lazy var hudLayer : NSVisualEffectView = {
        let layer = NSVisualEffectView()
       
        return layer
    }()
    
    // progressLayer
    lazy var progressLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    
    // loadProgress
    var loadProgress : CGFloat = 0 {
        didSet{
            
        }
    }

}


extension XCProgressHUD {
    func showInView(_ view : NSView)  {
        view.wantsLayer = true
        guard let bounce = view.layer?.bounds else {return;}
        XCPrint("add layer")
        view.addSubview(hudLayer)
        hudLayer.frame = bounce
    }
    func  showProgressHudInView(_ view : NSView) {
        showInView(view)
        
    }
   
    
    func hideHud() {
        hudLayer.removeFromSuperview()
//        progressLayer.removeFromSuperlayer()
    }
}
