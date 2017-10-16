//
//  AppDelegate.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBOutlet weak var statusMenu: NSMenu!                  // status menu for Home interface
    
    @IBOutlet weak var loginMenu: NSMenu!                   // status menu for login interface
    
    @IBOutlet weak var loginItem: NSMenuItem!               // status item for loing interface
    
    
    
    
    lazy var statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    weak var currentWindow : NSWindow?
    
    var windowController : NSWindowController!{
        didSet{
            let isHome = windowController.isKind(of:HomeWindowController.self)
            preferenceItem.target = isHome ? self : nil
            preferenceItem.action = isHome ? #selector(showPreferenceWindow) : nil
            statusItem.menu = isHome ? statusMenu : loginMenu
        }
    }
    
    
    @IBOutlet weak var preferenceItem: NSMenuItem!
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        // regist Apple Event Handler for get URL
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(handlerURL(_:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        
    }
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let isLogin = UAToolManager.defaultManager.isLogin
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        if isLogin {
            
            let idString = isLogin ? kFBHomeControllerID : kFBLoginConttollerID
            
            windowController = storyboard.instantiateController(withIdentifier: idString) as! NSWindowController
            
            windowController.showWindow(nil)
        }else{
            let webLoginStroyboard = NSStoryboard(name: "WebLogin", bundle: nil)
            windowController = webLoginStroyboard.instantiateController(withIdentifier: "weblogin") as! NSWindowController
            windowController.showWindow(nil)
        }
        
        
        
        
        
        let statusImage = NSImage(named: "statusIcon")
        statusImage?.isTemplate = true
        statusItem.image = statusImage
        
        let loginItemController = storyboard.instantiateController(withIdentifier: kFBStatusLoginItemID) as! NSViewController
        loginItem.view = loginItemController.view
        
    }

    @IBAction func logoutAccount(_ sender: NSMenuItem) {
        

        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let loginController = storyboard.instantiateController(withIdentifier: kFBLoginConttollerID) as! LoginWindowController
        loginController.window?.makeKeyAndOrderFront(nil)
    }
}


extension AppDelegate{
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            currentWindow?.makeKeyAndOrderFront(nil)
            return !flag
        }
        return flag
    }
    /** response for URL handler when user active app by a URL Scheme */
    func handlerURL(_ theEvent : NSAppleEventDescriptor ) {
    
        print(theEvent.paramDescriptor(forKeyword: keyDirectObject)?.stringValue ?? "no param")
    }
    
    /** preference window  */
    func showPreferenceWindow() {
        
    }
    
    
}

func XCPring(_ message:Any...,file:String = #file,row:Int = #line){
    #if DEBUG
        let filename = (file as NSString).lastPathComponent
        Swift.print("[\(filename)-\(row)]:\(message)")
    #endif
}

