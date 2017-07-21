//
//  MYFlipView.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/21.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

class MYFlipView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override var isFlipped: Bool{
        return true
    }
    
}
