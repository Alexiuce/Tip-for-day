//
//  DetailViewController.swift
//  XCWebook
//
//  Created by alexiuce  on 2017/8/15.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    lazy var regexHelper : RegexTool = {
        let regex = RegexTool()
        regex.delegate = self
        return regex
    }()
    /** 加载的url */
    var loadUrl : String = "" {
        didSet{
           Alamofire.request(loadUrl).response { (response) in
            
            guard let result = response.data else {return}
            
            let encode = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
            
            guard let text = String(data: result, encoding: String.Encoding(rawValue: UInt(encode))) else {return}
            
           
            print(text)
            
            self.regexHelper.matchString(inText: text, pattern:"<div id=\"chapter_content\">.*?</div>")

            }
            
            
        }
    }

    /** webivew  */
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.hidesBarsOnSwipe = true
        // Do any additional setup after loading the view.
    }

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: RegexToolProcotol{
    func regexFinished(_ result: [String]) {
        webView.loadHTMLString(result[0], baseURL: nil)
    }
}
