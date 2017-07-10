//
//  ViewController.swift
//  NSOutlineViewDemo
//
//  Created by Alexcai on 2017/7/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var outlineView: NSOutlineView!
    var rootArray = [RootModel]()      // 根节点数组
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataModel()    // 初始化模型数据

    }
    override func viewDidAppear() {
        super.viewDidAppear()
        // 展开所有节点
        outlineView.expandItem(nil, expandChildren: true)
        // 展开第一个节点
//        outlineView.expandItem(outlineView.item(atRow: 0), expandChildren: true)
        // 展开第二个节点
//         outlineView.expandItem(outlineView.item(atRow: 1), expandChildren: true)
    }
}
// MARK: NSOutlineView DataSource
extension ViewController : NSOutlineViewDataSource{
    // 通过这个方法，NSOutlineView获得每个层级需要显示的节点数，当数据为顶级节点（根节点）时，item的值为nil
    // 当NSOutlineView 需要展示数据时，第一步会调用此方法
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if  let item = item as? RootModel {
            return item.children.count
        }
        return rootArray.count
    }
    // 通过这个方法，NSOutlineView可以判断本层级节点是否可以展开（是否有子节点），本示例中，仅演示两层结构
    // 当NSOutlineView 需要展示数据时，第三步会调用此方法
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return item is RootModel
    }
    // 通过这个方法，NSOutlineView知道每个层级节点的显示数据
    // 当NSOutlineView 需要展示数据时，第二步会调用此方法
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? RootModel {
           return item.children[index]
        }
       return rootArray[index]
    }
}
// MARK: NSOutlineViewDelegate
extension ViewController : NSOutlineViewDelegate{
    // 通过这个代理方法，NSOutlineView生成每个节点的视图，这样我们才能看到效果
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var cell : NSTableCellView?
        if item is RootModel{
            cell = outlineView.make(withIdentifier: "HeaderCell", owner: self) as? NSTableCellView
            cell?.textField?.stringValue = (item as? RootModel)?.name ?? ""
        }else{
            cell = outlineView.make(withIdentifier: "DataCell", owner: self) as? NSTableCellView
            cell?.textField?.stringValue = (item as? LeafModel)?.leafName ?? ""
        }
        return cell
    }
}
// MARK:  Helper
extension ViewController{
    fileprivate func setupDataModel(){
        let leaf1 = LeafModel("Objective - C")
        let leaf2 = LeafModel("Swift")
        let leaf3 = LeafModel("Java")
        let leaf4 = LeafModel("Python")
        let root1 = RootModel()
        root1.name = "Language"
        root1.children = [leaf1,leaf2,leaf3,leaf4]
        
        let leaf5 = LeafModel("Beijing")
        let leaf6 = LeafModel("Guangzhou")
        let leaf7 = LeafModel("Shanghai")
        let leaf8 = LeafModel("Shenzhen")
        let root2 = RootModel()
        root2.name = "City"
        root2.children = [leaf5,leaf6,leaf7,leaf8]
        
        rootArray = [root1,root2]
    }
}
