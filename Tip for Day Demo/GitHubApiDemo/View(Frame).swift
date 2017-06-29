//
//  View(Frame).swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/6/29.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

extension NSView{
    var x : CGFloat {
        return frame.origin.x
    }
    var y : CGFloat{
       return frame.origin.y
    }
    var width : CGFloat {
        return frame.size.width
    }
    var height : CGFloat{
        return frame.size.height
    }
    func setX(_ pointX : CGFloat){
        frame.origin.x = pointX
    }
    func setY(_ pointY : CGFloat){
        frame.origin.y = pointY
    }
    func setWidth(_ newWidth : CGFloat){
        frame.size.width = newWidth
    }
    func setHeight(_ newHeight : CGFloat){
        frame.size.width = newHeight
    }
    
    
    
}
