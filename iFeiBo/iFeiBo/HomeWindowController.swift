//
//  HomeWindowController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class HomeWindowController: NSWindowController {

    
    lazy var appDelegate = NSApp.delegate as! AppDelegate
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.isMovableByWindowBackground = true
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.standardWindowButton(.zoomButton)?.isHidden = true
        
        appDelegate.currentWindow = window
        appDelegate.windowController = self
        
        let themeView = window?.standardWindowButton(.closeButton)?.superview
        
        let visualView = NSVisualEffectView(frame: themeView!.bounds)
        visualView.autoresizingMask = [.viewWidthSizable,.viewHeightSizable]
        themeView?.addSubview(visualView, positioned: .below, relativeTo: window?.standardWindowButton(.closeButton))
       

    }
    deinit {
        print("home deinit app windows \(NSApp.windows)")
    }
    @IBAction func showHome(_ sender: NSToolbarItem) {
       
        
    }
    @IBAction func showProfile(_ sender: NSToolbarItem) {
    }
    
    
    @IBAction func showFavourite(_ sender: NSToolbarItem) {
        print(sender.isEnabled)
    }

}
