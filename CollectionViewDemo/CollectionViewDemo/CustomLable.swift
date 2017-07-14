//
//  CustomLable.swift
//  CollectionViewDemo
//
//  Created by alexiuce  on 2017/7/13.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class CustomLable: NSTextField {

     var multiline: Bool = false {
        didSet {
            let cell = self.cell as! NSTextFieldCell
            cell.wraps      = multiline
            cell.isScrollable = !multiline
        }}
    override init(frame: NSRect) {
        super.init(frame: frame)
      
        self.prepareAutosizingTextField()
    }
    
    required init(coder: NSCoder)  {
        super.init(coder: coder)!
        self.prepareAutosizingTextField()
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
        multiline = true
    }
    
    func prepareAutosizingTextField() {
        self.isBordered           = false
        self.lineBreakMode      = .byTruncatingMiddle
        self.translatesAutoresizingMaskIntoConstraints = false
        NotificationCenter.default.addObserver(self, selector: #selector(CustomLable.geometryDidChange(_:)), name: NSNotification.Name.NSViewFrameDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomLable.geometryDidChange(_:)), name: NSNotification.Name.NSViewBoundsDidChange, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSViewFrameDidChange, object: self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSViewBoundsDidChange, object: self)
    }
    
    // Autolayout
    
    func geometryDidChange(_: NSNotification!) {
    
        if multiline {
            self.preferredMaxLayoutWidth =  NSWidth(self.bounds)
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func textDidChange(_ notification: Notification)  {

        super.textDidChange(notification)
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: NSSize {
        var size: NSSize
        let bounds = self.bounds
     
        if let fieldEditor = self.currentEditor() as? NSTextView {
            let fieldEditorSuperview = fieldEditor.superview!
            
            if multiline {

                
                let superBounds = fieldEditorSuperview.bounds
                var frame       = fieldEditor.frame
            
                if NSWidth(frame) > NSWidth(superBounds) {
                    frame.size.width = NSWidth(superBounds)
                    
                    fieldEditor.frame = frame
                }
            }
            
            let textContainer   = fieldEditor.textContainer
            let layoutManager   = fieldEditor.layoutManager
            
            let usedRect        = layoutManager?.usedRect(for: textContainer!)
            let clipRect        = self.convert(fieldEditorSuperview.bounds, from: fieldEditor.superview)
            
            let clipDelta       = NSSize(width: NSWidth(bounds) - NSWidth(clipRect), height:NSHeight(bounds) - NSHeight(clipRect))
            
            if multiline {
                let minHeight   = layoutManager?.defaultLineHeight(for: self.font!)
                
                size          = NSSize(width: NSViewNoIntrinsicMetric, height: max(NSHeight(usedRect!), minHeight!) + clipDelta.height)
                
            } else {
                size            = NSSize(width: ceil(NSWidth(usedRect!) + clipDelta.width), height: NSHeight(usedRect!) + clipDelta.height)
            }
        } else {
            let cell = self.cell as? NSTextFieldCell
            
            if multiline {
                size        = (cell?.cellSize(forBounds: NSMakeRect(0, 0, NSWidth(bounds), CGFloat.greatestFiniteMagnitude)))!
                size.width  = NSViewNoIntrinsicMetric
                size.height = ceil(size.height)
            } else {
                size        = (cell?.cellSize(forBounds: NSMakeRect(0, 0, CGFloat.greatestFiniteMagnitude, CGFloat.greatestFiniteMagnitude)))!
                size.width  = ceil(size.width)
                size.height = ceil(size.height)
            }
        }
        
        return size
    }
    
}
