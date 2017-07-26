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
      
        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(ViewController.updateWorkspace(_:)), name: .NSWorkspaceActiveSpaceDidChange, object: nil)
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTopAppInfo), userInfo: nil, repeats: true)
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController{
    
    @objc fileprivate func updateWorkspace(_ notification : NSNotification){

      self.view.window?.makeKeyAndOrderFront(nil)
    
        print(notification)
        
    }
    
   @objc fileprivate func updateTopAppInfo(){
    
      print(NSWorkspace.shared().frontmostApplication ?? "no no")
    }
}

