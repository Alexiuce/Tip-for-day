//
//  WBTextField.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/29.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class WBTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override var alignmentRectInsets: EdgeInsets{
        let bottomMargin : CGFloat = stringValue.characters.count > 0 ? -10 : 0
        
        return NSEdgeInsetsMake(0, 0, bottomMargin, 0)
    }
    
}
