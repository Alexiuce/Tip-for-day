//
//  ViewController.swift
//  TextKitDemo
//
//  Created by caijinzhu on 2018/3/20.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let stringStorage = textView.textStorage
        let lineHeight = textView.font!.lineHeight
        guard let textPath = Bundle.main.path(forResource: "abc", ofType: ".txt") else { return  }
        
        guard let text = try? String(contentsOf: URL(fileURLWithPath: textPath), encoding: String.Encoding.utf8) else{return}
    
        stringStorage.replaceCharacters(in: NSMakeRange(0, 0), with: text)
        
        let layoutManager = NSLayoutManager()
        stringStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: CGSize(width: 100, height: 100))
        textContainer.lineBreakMode = .byTruncatingTail
        layoutManager.addTextContainer(textContainer)
        let exclucePath = UIBezierPath(rect: CGRect(x: 70, y: 100 - lineHeight, width: 30, height: lineHeight))
        textContainer.exclusionPaths = [exclucePath]
        
        
        let textRect = CGRect(x: 100, y: 400, width: 100, height: 150)
        let textView2 = UITextView(frame:textRect , textContainer: textContainer)
        textView2.isEditable = false
        textView2.isScrollEnabled = false
        textView2.backgroundColor = UIColor.yellow
        view.addSubview(textView2)
        
        
        let textContainer2 = NSTextContainer(size: CGSize(width: 100, height: 150))
        layoutManager.addTextContainer(textContainer2)
        
        let rect2 = CGRect(x: 210, y: 400, width: 100, height: 150)
        let textView3 = UITextView(frame: rect2, textContainer: textContainer2)
        textView3.backgroundColor = UIColor.gray
        view.addSubview(textView3)
       
        
    }

   


}

