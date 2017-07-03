//
//  RespositoryCell.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/3.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

class RespositoryCell: NSTableCellView {

   
    @IBOutlet weak var iconImageView: NSImageView!
    
    @IBOutlet weak var titleTextField: NSTextField!
    
    @IBOutlet weak var laungageTextField: NSTextField!
    
    @IBOutlet weak var descTextField: NSTextField!
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
}
