//
//  Node.swift
//  TreeDemo
//
//  Created by alexiuce  on 2017/9/4.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

class Node: NSObject {
    
    var title = "TopNode"
    
    var children : [Node] = []
    
    
    override init() {
        super.init()
    }
    
    init(_ title : String){
        self.title = title
    }

}
