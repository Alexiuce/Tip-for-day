//
//  ActiveSpaceWindow.swift
//  TimeAnywhere
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class ActiveSpaceWindow: NSWindow {

    override func makeKeyAndOrderFront(_ sender: Any?) {
//        let originalBehavior = self.collectionBehavior
        self.collectionBehavior = .moveToActiveSpace
        super.makeKeyAndOrderFront(sender)
//        self.collectionBehavior = originalBehavior
    }
 
    
}
