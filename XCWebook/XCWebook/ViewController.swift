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

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    Alamofire.request(baseHTML + targetPage).response { (response) in
        
        guard let result = response.data else {return}
        
        let encode = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
        
        guard let text = String(data: result, encoding: String.Encoding(rawValue: UInt(encode))) else {return}
    
        print(text)
        let pattern = "<div class=\"clc\">.*?</div>"
        guard let regex = try? NSRegularExpression(pattern: pattern , options: NSRegularExpression.Options.caseInsensitive) else {return}
        
        let divs = regex.matches(in: text, options:[], range: NSMakeRange(0, text.characters.count))
        
//        print(divs)
        
        for div in divs {
           
            print( (text as NSString).substring(with: div.range))
        }
        
        
        }
    

    }

}


extension ViewController{
    

    
}
