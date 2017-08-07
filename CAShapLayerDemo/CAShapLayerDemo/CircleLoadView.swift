//
//  CircleLoadView.swift
//  CAShapLayerDemo
//
//  Created by alexiuce  on 2017/7/24.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit

class CircleLoadView: UIView {
    let circlePathLayer = CAShapeLayer()
    let circleRadius : CGFloat = 20.0
    var progress : CGFloat {
        get{
            return circlePathLayer.strokeEnd
        }
        set{
            if newValue > 1 {
                circlePathLayer.strokeEnd = 1
            }else if newValue < 0 {
                circlePathLayer.strokeEnd = 0
            }else{
                circlePathLayer.strokeEnd = newValue
            }
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        configuration()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension CircleLoadView{
    
    func reavl() {
        backgroundColor = UIColor.clear
        progress = 1
        circlePathLayer.removeAnimation(forKey: "StrokeEnd")
        circlePathLayer.removeFromSuperlayer()
        superview?.layer.mask = circlePathLayer
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let finalRadius = sqrt((center.x * center.x) + (center.y * center.y))
        let radiusInset = finalRadius - circleRadius
        let outRect = circleFrame().insetBy(dx: -radiusInset, dy: -radiusInset)
        let toPath = UIBezierPath(ovalIn: outRect).cgPath
        
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        
        // 禁止隐式动画
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2 * finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        // 创建两个基础动画：（线宽和路径）
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2 * finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        // 创建动画组
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.add(groupAnimation, forKey: "strokeWidth")
    }
    
    
    fileprivate func configuration(){
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.red.cgColor
        circlePathLayer.path = circlePath().cgPath
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.lightGray
        progress = 0
    }
    fileprivate func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midY - circleFrame.midY
        return circleFrame
    }
    fileprivate func circlePath() -> UIBezierPath {
       return UIBezierPath(ovalIn: circleFrame())
   }
}
extension CircleLoadView : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}
