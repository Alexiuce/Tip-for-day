//
//  PreferencesController.swift
//  FTTXDemo
//
//  Created by alexiuce  on 2017/9/8.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class PreferencesController: NSWindowController {
    
    
    var rects : [NSRect] = []

    override func windowDidLoad() {
        super.windowDidLoad()

        let r1 = NSRect(x: 510, y: 510, width: 650, height: 680)
        let r2 = NSRect(x: 510, y: 510, width: 250, height: 180)
        let r3 = NSRect(x: 510, y: 510, width: 250, height: 280)
        let r4 = NSRect(x: 510, y: 510, width: 350, height: 380)
        let r5 = NSRect(x: 510, y: 510, width: 450, height: 480)
        
        rects += [r1,r2,r3,r4,r5]
        
    }
    
    
    @IBAction func selectedItem(_ sender: NSToolbarItem) {
       
        let oldFrame = window!.frame
       
        
        
        switch sender.itemIdentifier {
        case "caution":
            let rect = NSMakeRect(NSMinX(oldFrame), NSMinY(oldFrame), NSWidth(rects[0]), NSHeight(rects[0]))
            let newFrame = window!.frameRect(forContentRect:rect)
            print("new : \(newFrame)")
            let endFrame = NSOffsetRect(newFrame, 0, NSMaxY(oldFrame) - NSMaxY(newFrame))
            window?.setFrame(endFrame, display: true, animate: true)
            print("end : \(endFrame)")
        case "user" :
            let rect = NSMakeRect(NSMinX(oldFrame), NSMinY(oldFrame), NSWidth(rects[1]), NSHeight(rects[1]))
            let newFrame = window!.frameRect(forContentRect:rect)

            print("new : \(newFrame)")
            let endFrame = NSOffsetRect(newFrame, 0, NSMaxY(oldFrame) - NSMaxY(newFrame))
            window?.setFrame(endFrame, display: true, animate: true)
            print("end : \(endFrame)")
            
        case "trash" :
            let rect = NSMakeRect(NSMinX(oldFrame), NSMinY(oldFrame), NSWidth(rects[2]), NSHeight(rects[2]))
            let newFrame = window!.frameRect(forContentRect:rect)

            print("new : \(newFrame)")
            let endFrame = NSOffsetRect(newFrame, 0, NSMaxY(oldFrame) - NSMaxY(newFrame))
            window?.setFrame(endFrame, display: true, animate: true)
            print("end : \(endFrame)")
        case "group" :
            let rect = NSMakeRect(NSMinX(oldFrame), NSMinY(oldFrame), NSWidth(rects[3]), NSHeight(rects[3]))
            let newFrame = window!.frameRect(forContentRect:rect)

            print("new : \(newFrame)")
            let endFrame = NSOffsetRect(newFrame, 0, NSMaxY(oldFrame) - NSMaxY(newFrame))
            window?.setFrame(endFrame, display: true, animate: true)
            print("end : \(endFrame)")
            
        default:
            let rect = NSMakeRect(NSMinX(oldFrame), NSMinY(oldFrame), NSWidth(rects[4]), NSHeight(rects[4]))
            let newFrame = window!.frameRect(forContentRect:rect)

            print("new : \(newFrame)")
            let endFrame = NSOffsetRect(newFrame, 0, NSMaxY(oldFrame) - NSMaxY(newFrame))
            window?.setFrame(endFrame, display: true, animate: true)
            print("end : \(endFrame)")
        }
        
    }
    

}



