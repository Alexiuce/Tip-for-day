//
//  WindowController.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/6/29.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import AppKit
import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titlebarAppearsTransparent = true
//        window!.styleMask = NSWindowStyleMask(rawValue: window!.styleMask.rawValue | NSWindowStyleMask.fullSizeContentView.rawValue)
        
    }
}
