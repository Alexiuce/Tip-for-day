//
//  ViewController.swift
//  TreeDemo
//
//  Created by alexiuce  on 2017/9/4.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet var treeController: NSTreeController!
    
   lazy var nodes : [Node] = {
        let n1 = Node("One")
        let n11 = Node("One-1")
        let n12 = Node("One-2")
        n1.children = [n11,n12]
        
        let n2 = Node("Two")
        let n21 = Node("Two-1")
        n2.children = [n21]
        
        let n3 = Node("Three")
        
        return [n1, n2,n3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

