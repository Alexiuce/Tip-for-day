//
//  AppDelegate.swift
//  GitHubApiDemo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window : NSWindow?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window = NSApp.windows.first
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if flag == false {
            window?.makeKeyAndOrderFront(nil)
        }
        
        return true
    }


}
func XCPrint(_ message:Any?...,file:String=#file, row:Int=#line){
    
    #if DEBUG
    
    let filename = (file as NSString).lastPathComponent
    
    print("[\(filename)-\(row)]:\(message)")

#endif

}
