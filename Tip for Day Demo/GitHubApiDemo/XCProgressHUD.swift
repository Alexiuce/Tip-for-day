//
//  XCProgressHUD.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/8/1.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

let _circleRadius: CGFloat = 50


class XCProgressHUD: NSObject {
    // 1. 单利
    static let defaultHud = XCProgressHUD()
    
    // hudBackView
    lazy var hudBackView : NSVisualEffectView = {
        let view = NSVisualEffectView()
        view.wantsLayer = true
        return view
    }()
    
    // progressLayer
    lazy var progressLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    
    // loadProgress
    var loadProgress : CGFloat = 0 {
        
        didSet{
            if loadProgress > 1 {
                progressLayer.strokeEnd = 1
            }else if loadProgress < 0 {
                progressLayer.strokeEnd = 0
            }else{
                progressLayer.strokeEnd = loadProgress
            }
        }
    }
}


extension XCProgressHUD {
    func showInView(_ view : NSView)  {
        guard let bounce = view.layer?.bounds else {return;}
        view.addSubview(hudBackView)
        hudBackView.frame = bounce
        hudBackView.layer?.addSublayer(progressLayer)
        progressLayer.frame = bounce
        progressLayer.lineWidth = 5
        progressLayer.fillColor = NSColor.clear.cgColor
        progressLayer.strokeColor = NSColor.gray.cgColor
        
        var circleFrame = NSRect(x: 0, y: 0, width: 2 * _circleRadius, height: 2 * _circleRadius)
        circleFrame.origin.x = NSMidX(bounce) - _circleRadius
        circleFrame.origin.y = NSMidY(bounce) - _circleRadius
        let bezierPath = NSBezierPath(ovalIn: circleFrame)
        
        progressLayer.path = convertCGPath(bezierPath)
        loadProgress = 0

    }

   
    // 隐藏hud
    func hideHud() {
       
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.25
            context.allowsImplicitAnimation = true
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.hudBackView.animator().alphaValue = 0
        }) { 
             self.hudBackView.removeFromSuperview()
        }
    
    }
}
extension XCProgressHUD {
    fileprivate func convertCGPath(_ bezier : NSBezierPath ) -> CGPath{
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< bezier.elementCount {
            let type = bezier.element(at: i, associatedPoints: &points)
            switch type {
            case .moveToBezierPathElement: path.move(to: points[0])
            case .lineToBezierPathElement: path.addLine(to: points[0])
            case .curveToBezierPathElement: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement: path.closeSubpath()
            }
        }
        return path
    }
}

