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
    
    weak var fatherView : NSView?
    
    // hudBackView
    lazy var hudBackView : NSVisualEffectView = {
        let view = NSVisualEffectView()
        view.wantsLayer = true
        return view
    }()
    
    // progressLayer
     var progressLayer  = CAShapeLayer()
    
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
        if hudBackView.alphaValue > 0 {   // 已显示
            hudBackView.removeFromSuperview()
            progressLayer.removeFromSuperlayer()
        }
        view.addSubview(hudBackView)
        hudBackView.alphaValue = 1
        hudBackView.frame = bounce
        progressLayer = CAShapeLayer()
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
         fatherView = hudBackView.superview
        if fatherView == nil{return}
        progressLayer.removeFromSuperlayer()
        hudBackView.removeFromSuperview()
        fatherView?.layer?.mask = progressLayer
        
      
        let fromPath = progressLayer.path
        let finalWH = max(fatherView!.frame.size.width, fatherView!.frame.size.height)
        let toCircleFrame = NSRect(x: 0, y: 0, width:finalWH, height: finalWH)
        let toPath = convertCGPath(NSBezierPath(ovalIn: toCircleFrame))
        
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = progressLayer.lineWidth
        lineWidthAnimation.toValue = finalWH
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.duration = 0.75
        groupAnimation.animations = [lineWidthAnimation,pathAnimation]
        groupAnimation.delegate = self
        progressLayer.add(groupAnimation, forKey: "StorkWidth")
        
//        NSAnimationContext.runAnimationGroup({ (context) in
//            context.duration = 0.5
//            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//            self.hudBackView.animator().alphaValue = 0
//        }) {
//             self.loadProgress = 0
//             self.hudBackView.removeFromSuperview()
//        }
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

extension XCProgressHUD : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        fatherView?.layer?.mask = nil
    }
}


