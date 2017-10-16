//
//  HomeStatusView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Kingfisher

class HomeStatusView: NSView {
    
    var status : WBStatus? {
        didSet{
            guard let name = status?.user?.name else {return}
            nameLabel.stringValue = name
            guard let time = status?.created_at else {return}
            timeLabel.stringValue = time
            guard let url = status?.user?.avatar_hd else { return  }
            headerImageView.kf.setImage(with: URL(string: url))
            textLabel.stringValue = status?.text ?? ""
        }
    }

    @IBOutlet weak var headerImageView: NSImageView!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var timeLabel: NSTextField!
    
    @IBOutlet weak var textLabel: NSTextField!
    
    func caculateHeight(_ tableView: NSTableView, targetStatus: WBStatus) -> CGFloat{
        bounds.size.width = tableView.bounds.width
        status = targetStatus
        
        layoutSubtreeIfNeeded()
        return bounds.height
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    
        // Drawing code here.
    }
    
}
