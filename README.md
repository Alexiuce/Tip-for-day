# Tip-for-day
![](https://img.shields.io/badge/platform-iOS%7CMacOSX-%20lightgrey.svg). 

a demo code project for iOS / Mac , write down for develop tip

## Demo project All in one 
### iOS 
---
* 开发常用
> 1. **去除UITableviewCell底部横线的左边距**  
> storyboard/xib中，修改cell的<code>Separator</code>属性   
> ![](https://ws3.sinaimg.cn/large/006tNc79gy1fh92kc3e9bj30740210sp.jpg)
> 
> 2. **每次提交时，忽略已被添加到git管理中的文件**（如果没有该文件没有被添加到git中，使用.gitignore文件进行忽略提交）
> 
> ```git
> git update-index --assume-unchanged PATH    // 在PATH处输入要忽略的文件。
> ```
> 


* AVFoundation Target.  
 
  实现步骤：
  > 1.获取采集硬件设备
  
  ```swift
   let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)!
  ```
  > 2.将采集硬件设备转为采集输入设备  
  
  ```swift
   let input = try! AVCaptureDeviceInput(device: self.captureDevice)
  ```
  > 3.创建输出类型：（主要有三种：静态图，视频流，识别元数据）
  
  ``` swift
   let output = AVCaptureStillImageOutput()   // 静态图，用于拍照
   let output = AVCaptureVideoDataOutput()    // 视频流，实时捕捉
   let output = AVCaptureMetadataOutput()     // 人脸识别，二维码识别（对于AVCaptureMetadataOutput 类型的设置，需要在添加到session之后进行，否则报错）
  ```
  > 4.创建处理队列（响应视频流和元数据识别时）
  
  ```swift
   let queue = DispatchQueue(label: "myVideoSessionQueue")
  ```
  > 5.创建采集会话（重点，会话用于管理整个采集过程，从输入到输出）
  
  ```swift
   let session = AVCaptureSession() 
  ```
  > 6.添加输入设备和输出类型数据到采集会话（最好先判断一下是否能添加,可以添加多种输出和输入）
  
  ```
   // 添加输入设备到采集会话
        if session.canAddInput(self.inputDevice) {
            session.addInput(self.inputDevice)
        }
        // 添加输出到采集会话
        if session.canAddOutput(self.metaOutput) {
            session.addOutput(self.metaOutput)
            print(self.metaOutput.availableMetadataObjectTypes)
            self.metaOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
        }
        // 添加视频输出到采集会话
        if session.canAddOutput(self.videoOutput) {
            session.addOutput(self.videoOutput)
        }

  ```
  > 7.根据采集会话，创建预览图层（用于显示画面）
  
  ```swift
   let previewLayer =  AVCaptureVideoPreviewLayer(session: session)
  ```
  > 8.开始采集
  
  ```swift
  self.session .startRunning()
  ```
  > 9.完成采集后，记得结束（一般在 viewWillDisappear中执行）
  
  ```swift
    self.session.stopRunning()
  ```
  * AVCaptureMetadataOutput 仅限与人脸和条码识别，如果需要做其他只能识别（比如名片，银行卡等），需要采用其他方法（CIDetector，或openCV）
  * AVCaptureVideoDataOutput 需要注意掉帧（可能由于处理过程耗时）
* Core Image Target. 

   > 1. Core Image 默认使用ABGR颜色空间
   > 2. Core Image 默认使用GPU执行操作
   > 3. Swift 中 Core Image 需要使用指针运算
   
    ```swift
     // 遍历图片像素
        for _ in 0 ..< imgWidth {
            for _ in 0 ..< imgHeight {
                let pix = pixels!.assumingMemoryBound(to: uint.self)   // 声明指针的内存布局，与定义时要保持一直（参见51行）
                let pixValue = pix.pointee  // 获取指针内存中的数据
                /* Core Image 中的颜色空间是ABGR： 即 透明度 蓝色 绿色 红色,如下图
                                00000000 | 00000000 | 00000000 | 0000000
                                |<-透明度->|<- 蓝色  ->|<-  绿色   ->|<-红色->|
                */
        //      pix.pointee = pix.pointee & 0xff0000ff  // 只保留红色
       //       pix.pointee = pix.pointee & 0xff00ff00  // 只保留绿色
                pix.pointee = pix.pointee & 0xffff0000  // 只保留蓝色
                print((R(pixValue) + G(pixValue) + B(pixValue)) / 3,terminator:" ")
                pixels = pixels?.advanced(by:MemoryLayout<uint>.size)    // 移动指针到下个位置
            }
        }
      
    ```
      
   
* OpenCV Target  

  详细内容，阅读OpenCV章节  
  [OpenCV Target Details](https://github.com/Alexiuce/Tip-for-day/blob/master/OpenCV.md)

* BaiduMap Target

  [BaiduMap.md](https://github.com/Alexiuce/Tip-for-day/blob/master/BaiduMap.md)
* RxSwift Demo  
  关于详情请参看：[RxSwift Readme](https://github.com/Alexiuce/Tip-for-day/blob/master/RxSwift%20Readme.md)

* ReamAndCharts Target  
  详细参看[readme](https://github.com/Alexiuce/Tip-for-day/blob/master/RealmAndCharts.md)
  
* CallDemo 网络电话  

  使用第三方SDK，详细代码参考[Readme](https://github.com/Alexiuce/Tip-for-day/blob/master/CallDemo/Readme%20.md)
### Mac 
---
* 开发点滴
  
  * 翻转视图的坐标系
     > osx中,视图默认的起始坐标是以左下角为坐标原点（0，0），如果需要已左上角为坐标原点，需要设置isFlipped值 
     
     ```swift
     // 方式1: 集成NSView，重载isFlipped属性
		     override var isFlipped: Bool{
		        return true
		    }
     
     // 方式2 KVC
        yourView.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
     // 示例代码
        topBox.setValue(true, forKey: "isFlipped")
     
     ```
  
  
  
  * 去除视图选中时的系统默认蓝色边框  
 
    ```swift
       view.focusRingType = None
    ```
   * NSTableView 使用和自定义NSTableCellView  
     * 获取NSTableView 当前选中的cell方法 
     
     ```swift
      let selectCell = tableView.view(atColumn: 0, row:tableView.selectedRow, makeIfNecessary: true)
      
     ```
     * NSTableView 支持鼠标左右滑动cell显示功能按钮  
     
     ```swift 
       // 实现NSTableView的代理方法
        func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
        if edge == .trailing {   // 从右向左滑动cell ，在cell的尾部（最右边）显示
            let rightAction = NSTableViewRowAction(style: .regular, title: "Demo") { (rowAction, index) in
                XCPrint("click demo ")
            }
            return [rightAction]
        }
       return [NSTableViewRowAction()]   // 从左向右滑动cell ，不显示内容时，传[NSTableViewRowAction()]数组
    }
     ```
     
     具体内容详参GitHubApi  ：[readme](https://github.com/Alexiuce/Tip-for-day/blob/master/GitHubApi.md) 
     
   * NSOutlieView 使用介绍：
   > 自定义箭头样式: 继承NSOutlineView，重写下面的方法
     
     
       ```
     // 重写方法
     override func make(withIdentifier identifier: String, owner: Any?) -> NSView? {
        let view = super.make(withIdentifier: identifier, owner: owner)
        if identifier == NSOutlineViewDisclosureButtonKey, let btn = view as? NSButton{
            btn.image = NSImage(named: "rightArrow")   // 图片尺寸不要超过btn的size，否则可能显示不出来
            btn.alternateImage = NSImage(named: "downArrow")   // 图片尺寸同上
            return btn
        }
        return view
        }
        ```
        
     详细内容，参看 [readme](https://github.com/Alexiuce/Tip-for-day/blob/master/GitHubApi.md)
     
   * NSTableCellView 鼠标的移进和移出监听
   
     ```swift
     // 1. 添加监听区域类 NSTrackingArea *trackingArea;
      trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
        if (![[self trackingAreas] containsObject:trackingArea]) {
        [self addTrackingArea:trackingArea];
        }
     // 2. 重写鼠标对应的方法
      - (void)mouseEntered:(NSEvent *)theEvent {
         // 鼠标移入
        }
      - (void)mouseExited:(NSEvent *)theEvent {
        // 鼠标移出
       }
     
     ```  
   具体详情参考:[HoverTableDemo](https://github.com/Alexiuce/Tip-for-day/tree/master/HoverTableDemo)  
   * OSX AutoLayout 动画
     > 需要导入框架 *`#import <Quartz/Quartz.h>`*
     
       ```swift
     [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration =  0.25f;   // 设置动画时间
        context.allowsImplicitAnimation = YES;     // 允许隐式动画
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];   // 动画节奏（时间的曲线函数）
        // 注意，这里的Autoloay不是直接赋值到constraint的constant上，而是constraint的animator的constant
        // 动画之后的autolayout 值
        self.topBoxTopConstraint.animator.constant = _barDisplayed ? 0 : -44; 
         } completionHandler:nil];
       ```
    > 第三方动画框架JDAnimationKit（基于Pop）
    [JDAnimationKit](https://github.com/Alexiuce/Tip-for-day/blob/master/AnimationDemo/JDAnimationKit%20(Swift%20for%20OSX).md) 

* XibLoadViewDemo
  
  > xib方式加载自定义view
  细节请参考[MyXib Readme](https://github.com/Alexiuce/Tip-for-day/blob/master/MyXibView%20Demo.md)
  
* Doucment Demo

 > 基于文档的应用demo 详情请参考 [document readme](https://github.com/Alexiuce/Tip-for-day/blob/master/MDocument%20Demo.md)
 
* GitHubApiDemo  
> 关于GitHub api的一个工程  
> [readme](https://github.com/Alexiuce/Tip-for-day/blob/master/GitHubApi.md) 

### 逆向工具

#### class_dump使用
 > 用于导出工程的头文件 ，输入内容为Mach-O文件（即xxxx.app,这里注意不是xxxx.ipa）  
 官网下载地址[class_dump](http://stevenygard.com/projects/class-dump/)
 
 >  复制到/usr/local/bin目录下，在终端中输入class-dump，显示class-dump的版本后，就可以正常使用class-dump的命令了
 
 ```
 class-dump -H 应用.app的路径 -o 输出头文件的路径文件名  
 ```

#### Cycript 使用 
> 用于动态调试app的工具（非常强大）  

  * 工程中集成Cycript
    
    ```
    // 1 添加Cycript.framework到项目中
    // 2 添加依赖库：libstdc++.6.0.9.tbd libsqlite3.tbd JavaScriptCore.framework
    // 3 设置Standard_LIBRARY = compiler-default
    // 4 设置Other Link Flag ：   -lstdc++

    ```
    
  * Cycript 导入脚本  
  > 使用命令行调测UI界面
  
  > 导入脚本的感念与Objective-C中的import类似，相当于可以使用脚本定义的方法，但貌似Cycript不会自动执行脚本。。想实现自动化操作应该怎么办呢？（这个问题待解决:已根作者写邮件寻求解答，尚未获得回复） 
  > 最新版本的Cycript SDK 集成时会报CYError编辑错误，要使用老版本的cycript替换SDK中的cycript文件
      
  ```
  ./cycript -r IP地址:端口 demo.cy; ./cycript -r ip地址:端口
  
  ```
  
  
  * 连接真机（项目中自己集成Cycript时）
  
  ```
  ./cycript -r (模拟器或真机)ip地址:端口
  ```

  * 打印视图层级

  ```swift
  UIApp.keyWindow.recursiveDescription.toString()
  ```
  
  * 进程注入
  
  ```swift
  // 1. 获取进程id
  ps -e (或者ax) | grep 应用名
  // 2. 注入脚本
  cycript - p 进程id
  ```
  
  * 查看对象
  
  ```
  // 根据内存地址来获取对象
  #内存地址
  // 使用new Instance获取内存地址对象
  new Instance(内存地址)
  ```
  
#### iOSOpenDev 逆向开发的Xcode环境插件
> 下载iOSOpenDev[目前最新版本为1.6-2](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/iosopendev/iOSOpenDev-1.6-2.pkg)
   
> 安装最后的失败处理：下载修复脚本[iOSOpenDev-Install.sh](https://gist.github.com/jridgewell/5298903)
   
   ```
      // cd到下载的iOSOpenDev-Install.sh所在目录
     ./iOSOpenDev-Install.sh base
   ```
   
#### yololib 对dylib进行注入
> 对二进制文件(通常是Mach-O文件)进行dylib的注入。   
> 下载地址[yololib](https://github.com/KJCracks/yololib)
* 使用Xcode编译项目，获得yololib可执行文件

```
// 使用格式
   yololib binary dylib file
   
// 例子
./yololib WeChat.app/WeChat hook.dylib   
```
#### MachOView 查看整个MachO文件结构
> 下载地址[MachOView](https://github.com/gdbinit/MachOView)
 
#### iOS-deploy 真机部署 x.app
> * github地址[ios-deploy](https://github.com/phonegap/ios-deploy)
> 
> * 安装
> 
> ```
> sudo npm install -g ios-deploy --unsafe-perm=true
> ```
> * 部署
> 
> ```
> ios-deploy -d -b your.app
> ```