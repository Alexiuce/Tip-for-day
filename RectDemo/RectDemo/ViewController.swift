//
//  ViewController.swift
//  RectDemo
//
//  Created by alexiuce  on 2017/9/30.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label1: MYTextField!
    @IBOutlet weak var label2: MYTextField!
    @IBOutlet weak var label3: MYTextField!

    @IBOutlet weak var label4: MYTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func changeLabel2(_ sender: Any) {
        label2.stringValue = label2.stringValue == "" ? "a;kdjf;aiefjal;eijf;weojifadsfasdfsdffasdfdfa;efja;\n oweijfa;efija;woefija;dkfjaiefjai;efj" : ""
       
    }
    @IBAction func changeLabel3(_ sender: Any) {
       print("\(NSStringFromRect(label2.frame))")
    }
    @IBAction func resetDefault(_ sender: Any) {
    }
    
}

