//
//  MYWindowController.swift
//  TimeAnywhere
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class MYWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level =  Int(CGShieldingWindowLevel())
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }


}
