//
//  LeafModel.swift
//  NSOutlineViewDemo
//
//  Created by alexiuce  on 2017/7/10.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class LeafModel: NSObject {
    var leafName = ""            // 叶子节点名称
    var hasChildren = false   // 该叶子节点是否有字节点（本示例中仅为两级结构，因此叶子节点下没有子节点）
    init(_ name : String) {
        self.leafName = name
    }
}
