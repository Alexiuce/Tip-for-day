//
//  RootModel.swift
//  NSOutlineViewDemo
//
//  Created by alexiuce  on 2017/7/10.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class RootModel: NSObject {
    var name = ""
    var isLeaf = false
    var children = [LeafModel]()
}
