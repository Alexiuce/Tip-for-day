### MDocument Demo
![](https://img.shields.io/badge/platform-MacOSX-yellow.svg)
---
osx 中基于文档的应用示例程序

1. 创建Xcode 工程时，勾选 Create Doucment-based Application
2. 在NSDocument子类中实现这两个方法

   ```swift
    // 保存文件时，系统调用此方法
    override func data(ofType typeName: String) throws -> Data {
        let saveText = contextController.textView.string ?? ""
        return saveText.data(using: .utf8)!
    }
    // 打开文件时，系统调用此方法读取数据
    override func read(from data: Data, ofType typeName: String) throws {
        readText = String(data: data, encoding: .utf8)
    }

   ``` 
3. 在makeWindowControllers方法中，处理UI相关的赋值或者取值操作

   ```swfit
    override func makeWindowControllers() {
   
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
        contextController = windowController.contentViewController as! ViewController
        if readText != nil {
            contextController.textView.string = readText
        }
        
    }
   ```