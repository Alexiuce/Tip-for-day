//
//  PictureController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/10/3.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class PictureController: NSViewController {

    var picture : NSImage?
    var pictureURL : URL?
    
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        guard let picURL = pictureURL else { return  }
        imageView.kf.setImage(with: picURL)
    }
    
}
