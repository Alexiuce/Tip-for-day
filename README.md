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
  


### Mac 
---
* 开发点滴
  * 去除视图选中时的系统默认蓝色边框  
 
    ```swift
       view.focusRingType = None
    ```
   * NSTableView 使用和自定义NSTableCellView  
     详参GitHubApi  ：[readme](https://github.com/Alexiuce/Tip-for-day/blob/master/GitHubApi.md) 
     

* XibLoadViewDemo
  
  > xib方式加载自定义view
  细节请参考[MyXib Readme](https://github.com/Alexiuce/Tip-for-day/blob/master/MyXibView%20Demo.md)
  
* Doucment Demo

 > 基于文档的应用demo 详情请参考 [document readme](https://github.com/Alexiuce/Tip-for-day/blob/master/MDocument%20Demo.md)
 
* GitHubApiDemo  
> 关于GitHub api的一个工程  
> [readme](https://github.com/Alexiuce/Tip-for-day/blob/master/GitHubApi.md) 

 