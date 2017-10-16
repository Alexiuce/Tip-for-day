//
//  ViewController.swift
//  XCRefresh
//
//  Created by alexiuce  on 2017/9/20.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textScrollView: NSScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textScrollView.xc_HeaderRefresh(nil, action: nil)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

