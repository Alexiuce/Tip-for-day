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


    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

}

extension ViewController{
    fileprivate func handleImage(_ targetImage : UIImage){
    
        guard let inputImage = targetImage.cgImage else {return}            // UIImage -> CGImage
        let imgWidth = inputImage.width
        let imgHeight = inputImage.height
        let bytesPerPixel = 4                 // 每像素用4个字节(32位  表示 RGBA的颜色空间）
        let bitPerCompent = 8              // RGBA中每个部分用 8 个bit
        let bytesPerRow = bytesPerPixel * imgWidth   // 每行的字节数
        let pixels = calloc(imgHeight * imgWidth, sizeof(uint))     // 申请内存空间，尺寸为图片的size，单个单元的大小为UInt（也就是32）位
        
        
    }
}

