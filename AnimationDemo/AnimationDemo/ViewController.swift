//
//  ViewController.swift
//  AnimationDemo
//
//  Created by alexiuce  on 2017/7/21.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    @IBOutlet weak var demoLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
       
       
        
        _ = demoLabel.moveXTo(0, duration:5.0,delay:0.5 ,timing: JDTimingFunction.linear)
//        _ = demoLabel.moveYTo(0, duration:2, spring: true, springConfig: .JDSpringConfigDefault(), delay:1, timing: .easeOut)
      
    }

}

