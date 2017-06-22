# Tip-for-day
![](https://img.shields.io/badge/platform-iOS%7CMacOSX-%20lightgrey.svg). 

a demo code project for myself, write down for develop tip

## Demo project All in one 
### iOS 
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

### Mac 
