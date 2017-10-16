//
//  LoginWindowController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController {

    lazy var appDelegate = NSApp.delegate as! AppDelegate
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.standardWindowButton(.zoomButton)?.isHidden = true
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window?.styleMask = [(window?.styleMask)!,.fullSizeContentView]
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.delegate = self
        window?.isMovableByWindowBackground = true
        
        appDelegate.currentWindow = window
        appDelegate.windowController = self
    }
    deinit {
        
        print("login deinit , app windows \(NSApp.windows)")
    }
 
}

// MARK: - IBAction method

// MARK: - NSWindowDelegate method
extension LoginWindowController : NSWindowDelegate{
    func windowWillClose(_ notification: Notification) {
        
        if UAToolManager.defaultManager.isLogin {
            return
        }
        
        NSApp.terminate(nil)
    }
}
// MARK: - Custom method


