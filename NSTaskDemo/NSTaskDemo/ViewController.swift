//
//  ViewController.swift
//  NSTaskDemo
//
//  Created by alexiuce  on 2017/7/27.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Cocoa

let kSelectedFilePath = "userSelectedPath"


class ViewController: NSViewController {

    @IBOutlet weak var repoPath: NSTextField!           // git 仓库path
    @IBOutlet weak var savePath: NSTextField!           // 本地保存路径
    
    var isLoadingRepo  = false                                 // 记录是否正在加载中..
    
    var outputPipe = Pipe()
    var task : Process?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func selectPath(_ sender: NSButton) {
        // 1. 创建打开文档面板对象
        let openPanel = NSOpenPanel()
        // 2. 设置确认按钮文字
        openPanel.prompt = "Select"
        // 3. 设置禁止选择文件
        openPanel.canChooseFiles = true
        // 4. 设置可以选择目录
        openPanel.canChooseDirectories = true
        // 5. 弹出面板框
        openPanel.beginSheetModal(for: self.view.window!) { (result) in
            // 6. 选择确认按钮
            if result == NSModalResponseOK {
                // 7. 获取选择的路径
                self.savePath.stringValue = (openPanel.directoryURL?.path)!
                UserDefaults.standard.setValue(openPanel.url?.path, forKey: kSelectedFilePath)
                UserDefaults.standard.synchronize()
            }
            // 8. 恢复按钮状态
            sender.state = NSOffState
        }
    }
    @IBAction func startPull(_ sender: NSButton) {
        guard  let executePath = UserDefaults.standard.value(forKey: kSelectedFilePath) as? String else {
            print("no selected path")
            return
        }
        guard self.repoPath.stringValue.characters.count != 0 else {
            return
        }
        if isLoadingRepo {return}   // 如果正在执行,则返回
        isLoadingRepo = true   // 设置正在执行标记
        task = Process()     // 创建NSTask对象
        
        task?.launchPath = "/bin/bash"    // 执行路径(这里是需要执行命令的绝对路径)
        task?.arguments = ["-c","cd \(executePath); git clone \(self.repoPath.stringValue)"]
        
        // 获取输出
        outputPipe = Pipe()
        task?.standardOutput = outputPipe
       
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading, queue: nil) { (notification) in
            let outputData = self.outputPipe.fileHandleForReading.availableData
            guard let outputString = String(data: outputData, encoding: .utf8) , outputString != "" else{return}
            print(outputString);
        }
    
        task?.terminationHandler = { proce in              // 执行结束的闭包(回调)
            self.isLoadingRepo = false    // 恢复执行标记
            print("finished")
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSFileHandleDataAvailable, object: self.outputPipe.fileHandleForReading)
        }
        task?.launch()                // 开启执行
        print("end")
        // 获取运行结果
//        let resultData = outputPipe.fileHandleForReading.readDataToEndOfFile()
//        let text = String(data: resultData, encoding: String.Encoding.utf8)
//        print(text ?? "non")
//        task?.waitUntilExit()       // 阻塞直到执行完毕
        
    }
}

