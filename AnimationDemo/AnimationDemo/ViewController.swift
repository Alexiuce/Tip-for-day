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
        demoLabel.rotate(byDegrees: 45)
    }

}

