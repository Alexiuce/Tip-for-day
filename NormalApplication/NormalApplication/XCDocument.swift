//
//  XCDocument.swift
//  NormalApplication
//
//  Created by alexiuce  on 2017/6/27.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

class XCDocument: NSDocument {

    var readText = ""
    weak var editController : ViewController!
    /*
    override var windowNibName: String? {
        // Override returning the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
        return "XCDocument"
    }
    */
    // 加载窗口控制器
    override func makeWindowControllers() {
        // 获取Main.storyboard
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        // 获取window控制器
        let controller = storyboard.instantiateController(withIdentifier: "NormalWindowsController") as! NSWindowController
        // 添加窗口控制器到文档（产生关联）
        self.addWindowController(controller)
        // 获取内容控制器（通常是与用户交互的视图控制器）
        editController = controller.contentViewController as! ViewController
        // 对编辑控件进行初始化赋值
        editController.editTextView.string = readText
    }
   
    override func windowControllerDidLoadNib(_ aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    // 保存文件时，系统会调用此方法进行数据存储
    override func data(ofType typeName: String) throws -> Data {
        let text = editController.editTextView.string ?? ""
        return text.data(using: .utf8)!
    }
    // 打开文件时，系统会调用此方法进行数据读取
    override func read(from data: Data, ofType typeName: String) throws {
      readText = String(data: data, encoding: .utf8) ?? ""
    }
    // 是否需要自动保存编辑内容
    override class func autosavesInPlace() -> Bool {
        return true
    }

}
