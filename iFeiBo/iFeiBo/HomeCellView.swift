//
//  HomeCellView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/19.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class HomeCellView: NSTableCellView {

    @IBOutlet weak var backgroundView: NSBox!
    @IBOutlet weak var headImageView: NSImageView!  // 头像
    
    @IBOutlet weak var textLabel: WBTextField!      // 微博正文
    
    @IBOutlet weak var nameLabel: NSTextField!      // 名称

    @IBOutlet weak var timeLabel: NSTextField!      // 实际
    
    @IBOutlet weak var sourceLabel: NSTextField!    // 来源
    @IBOutlet weak var vipImageView: NSImageView!   // vip
    
    @IBOutlet weak var rankImageView: NSImageView!  // 认证
  
    @IBOutlet weak var retweedText: WBTextField!
    @IBOutlet weak var pictureView: PicsView!
    
    @IBOutlet weak var picWidthCons: NSLayoutConstraint!            // 配图宽度约束
    @IBOutlet weak var picHeightCons: NSLayoutConstraint!           // 配图高度约束
    
    @IBOutlet weak var picsTopCons: NSLayoutConstraint!             // 配图的顶部约束
    
    @IBOutlet weak var retweedTopCons: NSLayoutConstraint!          // 转发正文的顶部约束
    var status : WBStatus? {
        didSet{
            guard let status = status else { return  }
            timeLabel.stringValue = status.createdString
            nameLabel.stringValue = status.user?.name ?? ""
            textLabel.stringValue = status.text 
            guard let url = status.user?.avatar_hd else { return  }
            headImageView.kf.setImage(with: URL(string: url))
            sourceLabel.stringValue = status.sourceText
            rankImageView.image = NSImage(named: "common_icon_membership_level\( status.user!.mbrank)")
            switch status.user!.verified_type {
            case 0:
                vipImageView.image = NSImage(named: "avatar_vip")
            case 2,3,5:
                vipImageView.image = NSImage(named: "avatar_enterprise_vip")
            case 220:
                vipImageView.image = NSImage(named: "avatar_grassroot")
            default:
                vipImageView.image = nil
            }
           
            if let retweetedText = status.retweeted_status?.text,let username = status.retweeted_status?.user?.name {
                retweedText.stringValue = "@\(username): " + retweetedText
                backgroundView.isHidden = false;
//                retweedTopCons.constant = 15
            }else{
                retweedText.stringValue = ""
                backgroundView.isHidden = true
//                retweedTopCons.constant = 0
            }
            if  (status.retweeted_status?.picURL != nil && status.retweeted_status!.picURL.count > 0) {
                pictureView.picUrls =  (status.retweeted_status?.picURL)!
//                picsTopCons.constant = 10
            }else{
                pictureView.picUrls = status.picURL
//                picsTopCons.constant = retweedTopCons.constant
            }
        
            picWidthCons.constant = pictureView.caculateSize.width
            picHeightCons.constant = pictureView.caculateSize.height
        }
    }
    
    override var backgroundStyle: NSBackgroundStyle{
        didSet{
            layer?.backgroundColor = backgroundStyle == .dark ? NSColor.red.cgColor : NSColor.clear.cgColor
        }
   
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        wantsLayer = true
        headImageView.layer?.cornerRadius = 24
        headImageView.layer?.masksToBounds = true
   
    }
}







