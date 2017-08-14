//
//  ViewController.swift
//  XCWebook
//
//  Created by alexiuce  on 2017/8/14.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit
import Alamofire


let baseHTML = "http://www.22ff.com"
let targetPage = "/xs/167580/"

class ViewController: UIViewController {
    
    lazy var regexHelper : RegexTool = {
        let regex = RegexTool()
        regex.delegate = self
        return regex
    }()
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    Alamofire.request(baseHTML + targetPage).response { (response) in
        
        guard let result = response.data else {return}
        
        let encode = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
        
        guard let text = String(data: result, encoding: String.Encoding(rawValue: UInt(encode))) else {return}
    
        let pattern = "<div class=\"clc\">.*?</div>"
        self.regexHelper.matchString(inText: text, pattern: pattern)
        }
    }

}

extension ViewController : RegexToolProcotol {

    func regexFinished(_ result: [String]) {
        print(result)
        
    }

    
}
