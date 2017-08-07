//
//  XCPlayButton.swift
//  XCPlayButton
//
//  Created by alexiuce  on 2017/8/7.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit

let _width : CGFloat = 5


class XCPlayButton: UIButton {
    
    var pointA =  CGPoint.zero
    
    var pointB = CGPoint.zero
    
    var pointD = CGPoint(x: _width, y: 0)
    
    
    var originalPath  = UIBezierPath()
    var rightPath = UIBezierPath()
    
    
    lazy var newPath : UIBezierPath = {
        let newPointC  = CGPoint(x: 20, y: self.layer.bounds.size.height - 10)
        let newPointD = CGPoint(x: 20, y: 10)
        let np = UIBezierPath()
         np.move(to: self.pointA)
        np.addLine(to: self.pointB)
        np.addLine(to: newPointC)
        np.addLine(to: newPointD)
        np.close()
        return np
    }()
    
    
    lazy var rightNewPath : UIBezierPath =  {
        let rp = UIBezierPath()
        
        return rp
    }()
    
    
    lazy var leftLayer : CAShapeLayer = {
        let shaper = CAShapeLayer()
        shaper.strokeColor = UIColor.red.cgColor
        shaper.fillColor = UIColor.green.cgColor
        return shaper
    }()
    
    lazy var rightLayer : CAShapeLayer = {
        let shaper = CAShapeLayer()
        shaper.strokeColor = UIColor.red.cgColor
        shaper.fillColor = UIColor.green.cgColor
        return shaper
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                // 开启动画
                let pathAnimation = CABasicAnimation(keyPath: "path")
                pathAnimation.duration = 2
               
                pathAnimation.toValue = newPath.cgPath
                pathAnimation.fillMode = kCAFillModeForwards
                pathAnimation.isRemovedOnCompletion = false
                leftLayer.add(pathAnimation, forKey: nil)
                
                
                let rightPositionAnimation = CABasicAnimation(keyPath: "position")
                
                rightPositionAnimation.duration = 2
                
                rightPositionAnimation.toValue = CGPoint(x:  -20, y: 0)
                rightPositionAnimation.fillMode = kCAFillModeForwards
                rightPositionAnimation.isRemovedOnCompletion = false

              
                
                rightLayer.add(rightPositionAnimation, forKey: nil)
                
            
            }else{
                // 还原动画
                print("old path")
                
                let pathAnimation = CABasicAnimation(keyPath: "path")
                pathAnimation.duration = 2
                pathAnimation.toValue = originalPath.cgPath
                pathAnimation.fillMode = kCAFillModeForwards
                pathAnimation.isRemovedOnCompletion = false
                leftLayer.add(pathAnimation, forKey: nil)
                
                let rightPositionAnimation = CABasicAnimation(keyPath: "position")
                
                rightPositionAnimation.duration = 2
                rightPositionAnimation.fromValue = CGPoint(x: -20, y: 0)
                rightPositionAnimation.toValue = CGPoint.zero
                rightPositionAnimation.fillMode = kCAFillModeForwards
                rightPositionAnimation.isRemovedOnCompletion = false
                
                
                
                rightLayer.add(rightPositionAnimation, forKey: nil)
            }
        }
    }

}



extension XCPlayButton{
    fileprivate func configUI(){
    
        pointB = CGPoint(x: 0, y: layer.bounds.size.height)
        let pointC = CGPoint(x: _width, y: layer.bounds.size.height)
        
        originalPath.move(to: pointA)
        originalPath.addLine(to: pointB)
        originalPath.addLine(to: pointC)
        originalPath.addLine(to: pointD)
        originalPath.close()

        leftLayer.path = originalPath.cgPath
        layer.addSublayer(leftLayer)
        
        
        
        
       
        
        let rightPointA = CGPoint(x: layer.bounds.size.width, y: 0)
        let rightPointB = CGPoint(x: layer.bounds.size.width, y: layer.bounds.size.height)
        let rightPointC = CGPoint(x: layer.bounds.size.width - _width, y: layer.bounds.size.height)
        let rightPointD = CGPoint(x: layer.bounds.size.width - _width, y: 0)

        if !rightPath.contains(rightPointA) {
            rightPath.move(to: rightPointA)
            rightPath.addLine(to: rightPointB)
            rightPath.addLine(to: rightPointC)
            rightPath.addLine(to: rightPointD)
            rightPath.close()
            rightLayer.path = rightPath.cgPath
            layer.addSublayer(rightLayer)
            
        }
        
        
        
    }
}
