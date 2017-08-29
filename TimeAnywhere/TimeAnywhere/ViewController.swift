//
//  ViewController.swift
//  TimeAnywhere
//
//  Created by alexiuce  on 2017/7/25.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa


class ViewController: NSViewController {


    
    @IBOutlet weak var imgBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(ViewController.updateWorkspace(_:)), name: .NSWorkspaceActiveSpaceDidChange, object: nil)
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTopAppInfo), userInfo: nil, repeats: true)
       
        // Do any additional setup after loading the view.
        
        
//        /** 创建手势识别 */
//        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(clcikedMouse(_:)))
//        /** 将手势识别器添加到imageView */
//        imageView.addGestureRecognizer(clickGesture)
        
    
        
        // 去除点击时的灰色效果
    imgBtn.isTransparent = true
        
        
    }
   
    
    override func viewDidAppear() {
        super.viewDidAppear()
       let win = view.window
//        print(view.window)
//        win?.backgroundColor = NSColor.red
//        win?.styleMask
        
//        win?.dockTile.showsApplicationBadge = false
//        NSApp.dockTile.badgeLabel = "12"
//        print(win!.dockTile.badgeLabel)
//        win?.isMovableByWindowBackground = true
        
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//         win?.dockTile.badgeLabel = "20"
        win?.makeKeyAndOrderFront(nil)
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

// MARK: handle event listion
extension ViewController{
    @objc fileprivate func clcikedMouse(_ gesuter: NSClickGestureRecognizer){
        print("clicked mouse")
        
    }
}

