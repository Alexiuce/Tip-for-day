# Tip-for-day
![](https://img.shields.io/badge/platform-iOS%7CMacOSX-%20lightgrey.svg). 

a demo code project for myself, write down for develop tip

## Demo project All in one 
### iOS 
* AVFoundation Target
* Core Image Target. 

   > 1. Core Image 默认使用ABGR颜色空间
   
   > 2. Core Image 默认使用GPU执行操作
   
   > 3. Swift 中 Core Image 需要使用指针运算
   
   > ```objc
     // 遍历图片像素
        for _ in 0 ..< imgWidth {
            for _ in 0 ..< imgHeight {
                let pix = pixels!.assumingMemoryBound(to: uint.self)   // 声明指针的内存布局，与定义时要保持一直（参见51行）
//                let pixValue = pix.pointee  // 获取指针内存中的数据
                /* Core Image 中的颜色空间是ABGR： 即 透明度 蓝色 绿色 红色,如下图
                 00000000 | 00000000 | 00000000 | 0000000
                |<-透明度->|<- 蓝色  ->|<-  绿色   ->| <- 红色 ->|
                */
//                pix.pointee = pix.pointee & 0xff0000ff  // 只保留红色
                  pix.pointee = pix.pointee & 0xff00ff00  // 只保留绿色
//                pix.pointee = pix.pointee & 0xffff0000  // 只保留蓝色
//                print((R(pixValue) + G(pixValue) + B(pixValue)) / 3,terminator:" ")
                pixels = pixels?.advanced(by:MemoryLayout<uint>.size)    // 移动指针到下个位置
            }
        }

      
   > ```
      
   
* OpenCV Target

### Mac 
