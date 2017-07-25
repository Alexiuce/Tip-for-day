//
//  ViewController.swift
//  TimeAnywhere
//
//  Created by alexiuce  on 2017/7/25.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        for runningApp in NSWorkspace.shared().runningApplications {
            if let appName = runningApp.localizedName {
                print(appName)
            }
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

