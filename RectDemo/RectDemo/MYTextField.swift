//
//  MYTextField.swift
//  RectDemo
//
//  Created by alexiuce  on 2017/9/30.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class MYTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override var alignmentRectInsets: EdgeInsets{
   
        return NSEdgeInsetsMake(0, 0, 10, 0)
    }
    
}
