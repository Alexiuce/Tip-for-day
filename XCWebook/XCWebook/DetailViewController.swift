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
        let activityData = ActivityData(size: view.bounds.size, message: "loading...", type:.ballScaleRippleMultiple, color: UIColor.red,padding:150 ,backgroundColor: UIColor.clear, textColor: UIColor.orange)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
//        webView.scrollView.mj_footer = MJRefreshBackFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
        
        
    }
    
//    @objc fileprivate func loadMore(){
//        print("load ...more ")
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { 
//            self.webView.scrollView.mj_footer.endRefreshing()
//        }
//    }


}

extension DetailViewController: RegexToolProcotol{
    func regexFinished(_ result: [String]) {
        webView.loadHTMLString(result[0], baseURL: nil)
    }
}

extension DetailViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("load finished")
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
