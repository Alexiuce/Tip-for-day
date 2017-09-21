//
//  ViewController.swift
//  FTTXDemo
//
//  Created by alexiuce  on 2017/9/8.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

import PreferencePanes

class ViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        scrollView.scrollerKnobStyle = .light
        scrollView.scrollerStyle = .overlay
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

