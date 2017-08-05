//
//  RespositoryCell.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/3.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa
import Kingfisher

class RespositoryCell: NSTableCellView {

   
    @IBOutlet weak var iconImageView: NSImageView!
    
    @IBOutlet weak var titleTextField: NSTextField!
    
    @IBOutlet weak var laungageTextField: NSTextField!
    
    @IBOutlet weak var descTextField: NSTextField!
    @IBOutlet weak var indicateView: NSBox!
    
    var cellModel : RespositoryModel? = nil {
        didSet{
            if cellModel == nil {return;}
            titleTextField.stringValue = cellModel!.title
            laungageTextField.stringValue = cellModel!.language
            descTextField.stringValue = cellModel!.desc
            let imgUrl = URL(string: cellModel!.imageUrl)
            iconImageView.kf.setImage(with: imgUrl)
            cellModel?.cellHeight = self.fittingSize.height
        }
    }
    var selected : Bool = false {
        didSet{
            self.layer?.backgroundColor = selected ?  NSColor.orange.cgColor : NSColor.clear.cgColor
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
     
        // Drawing code here.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        descTextField.maximumNumberOfLines = 0
    }
    
  
    
}
