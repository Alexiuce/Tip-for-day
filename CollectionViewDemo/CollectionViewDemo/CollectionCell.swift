//
//  CollectionCell.swift
//  CollectionViewDemo
//
//  Created by Alexcai on 2017/7/12.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class CollectionCell: NSCollectionViewItem {
    
    
    @IBOutlet weak var topButtonView: NSButton!
    
    @IBOutlet weak var titleLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.stringValue = "Text Demo"
        
        // Do view setup here.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.sizeToFit()
      
    }
    override var isSelected: Bool{
        
        didSet{
            super.isSelected = isSelected
            if isSelected {
                
                titleLabel.backgroundColor = NSColor.blue
                topButtonView.layer?.backgroundColor = NSColor.orange.cgColor
            }else{
                topButtonView.layer?.backgroundColor = NSColor.clear.cgColor
                titleLabel.backgroundColor = NSColor.clear
                
            }
        }
   
    }
}
