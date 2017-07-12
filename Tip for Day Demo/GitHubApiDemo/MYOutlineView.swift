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
   
    override func make(withIdentifier identifier: String, owner: Any?) -> NSView? {
        let view = super.make(withIdentifier: identifier, owner: owner)
        if identifier == NSOutlineViewDisclosureButtonKey, let btn = view as? NSButton{
            btn.image = NSImage(named: "rightArrow")
            btn.alternateImage = NSImage(named: "downArrow")
            return btn
        }
        return view
    }
  

}
