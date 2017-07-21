//
//  MYOutlineView.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/12.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

class MYOutlineView: NSOutlineView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
   // 自定义outlineView的三角指示箭头
    override func make(withIdentifier identifier: String, owner: Any?) -> NSView? {
        let view = super.make(withIdentifier: identifier, owner: owner)
        if identifier == NSOutlineViewDisclosureButtonKey, let btn = view as? NSButton{
            btn.image = NSImage(named: "rightArrow")   // 未展开时image
            btn.alternateImage = NSImage(named: "downArrow")  // 展开时image
            return btn
        }
        return view
    }
  

}
