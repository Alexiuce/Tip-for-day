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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
func XCPrint(_ message:Any?...,file:String=#file, row:Int=#line){
    
    #if DEBUG
    
    let filename = (file as NSString).lastPathComponent
    
    print("[\(filename)-\(row)]:\(message)")

#endif

}
