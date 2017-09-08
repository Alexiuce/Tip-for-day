//
//  AppDelegate.swift
//  FTTXDemo
//
//  Created by alexiuce  on 2017/9/8.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var perf : PreferencesController = PreferencesController(windowNibName: "PreferencesController")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func showPreference(_ sender: Any) {
        
        perf.showWindow(self)
    }

}

