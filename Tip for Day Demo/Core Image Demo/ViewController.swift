//
//  ViewController.swift
//  Core Image Demo
//
//  Created by alexiuce  on 2017/6/20.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
  
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var finalImageView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "58")!
        imageView.image = img
        handleImage(img)
    }

}

func Max8(_ x : uint) -> uint{
        return ((x) & 0xff)
}
func R(_ x : uint) -> uint{
    return Max8(x)
}
func G(_ x : uint) -> uint{
    return Max8((x) >> 8)
}
func B(_ x: uint) -> uint{
    return Max8((x) >> 16)
}

extension ViewController{
    fileprivate func handleImage(_ targetImage : UIImage){
    
        guard let inputImage = targetImage.cgImage else {return}            // UIImage -> CGImage
        let imgWidth = inputImage.width
        let imgHeight = inputImage.height
        let bytesPerPixel = 4                 // 每像素用4个字节(32位  表示 RGBA的颜色空间）
        let bitPerCompent = 8              // RGBA中每个部分用 8 个bit
        let bytesPerRow = bytesPerPixel * imgWidth   // 每行的字节数
        var pixels  = calloc(imgHeight * imgWidth, MemoryLayout<uint>.size)     // 申请内存空间，尺寸为图片的size，单个单元的大小为UInt（也就是32）位
        let colorSpace = CGColorSpaceCreateDeviceRGB()    // 创建RGB颜色空间
        let bmpAlpha = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue    // 设置位图的alpha通道信息
        let context = CGContext(data: pixels, width: imgWidth, height: imgHeight, bitsPerComponent: bitPerCompent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bmpAlpha)  // 创建绘图上下文
        context?.draw(inputImage, in: CGRect(x: 0, y: 0, width: imgWidth, height: imgHeight))  // 绘制图片到指定图形上下文中的区域
        // 遍历图片像素
        for _ in 0 ..< imgWidth {
            for _ in 0 ..< imgHeight {
                let pix = pixels!.assumingMemoryBound(to: uint.self)   // 声明指针的内存布局，与定义时要保持一直（参见51行）
//                let pixValue = pix.pointee  // 获取指针内存中的数据
                /* Core Image 中的颜色空间是ABGR： 即 透明度 蓝色 绿色 红色,如下图
                 00000000 | 00000000 | 00000000 | 0000000
                 | <-透明度-> |<-   蓝色   ->|<-   绿色   ->| <- 红色 ->|
                */
//                pix.pointee = pix.pointee & 0xff0000ff  // 只保留红色
                pix.pointee = pix.pointee & 0xff00ff00  // 只保留绿色
//                pix.pointee = pix.pointee & 0xffff0000  // 只保留蓝色
//                print((R(pixValue) + G(pixValue) + B(pixValue)) / 3,terminator:" ")
                pixels = pixels?.advanced(by:MemoryLayout<uint>.size)    // 移动指针到下个位置
            }
        }
       let newCGImage = context!.makeImage()!   // 从图形上下文中获取图片
       let newImage = UIImage(cgImage: newCGImage)  // CGImage -> UIImage
       finalImageView.image = newImage    // 显示图片（CPU执行处理）
    }
}

