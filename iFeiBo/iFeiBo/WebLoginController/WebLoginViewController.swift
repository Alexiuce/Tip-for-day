//
//  WebLoginViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import WebKit
import Alamofire

class WebLoginViewController: NSViewController {

    @IBOutlet weak var webView: WebView!
    
    lazy var session = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask : URLSessionDataTask!
    
    var codeForToken = "" {
        didSet{
            if codeForToken == oldValue {return}
            let url = URL(string: WBTokenURL)!
            let paraDict = ["client_id":WBAppID,"client_secret":WBAppSecretKey,"grant_type":"authorization_code",
                            "code":codeForToken,"redirect_uri":WBAppReDirectURL]
            
            Alamofire.request(url, method: .post, parameters: paraDict).responseJSON { (response) in
              
                guard let data =  try? JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableLeaves)  as? [String : Any] else {
                    return
                }
                
                let account = UserAccount(dict: data)
                _ = UAToolManager.defaultManager.saveUserAccount(account)
                
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                let homeWindowController = storyboard.instantiateController(withIdentifier: kFBHomeControllerID) as! HomeWindowController
                
                homeWindowController.showWindow(nil)
            }
            
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let requestURL = URL(string:WBOAuth2URL)
        let request = URLRequest(url: requestURL!)

        webView.mainFrame.load(request)
    }
    
}


extension WebLoginViewController : WebPolicyDelegate{
    func webView(_ webView: WebView!, decidePolicyForNavigationAction actionInformation: [AnyHashable : Any]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
        
        print(request.url?.host ?? "")
        if request.url?.host == "alexiuce.github.io" {
            guard let host = request.url?.absoluteString else { return }
            let hostString = host as NSString
            let range = hostString.range(of: "code=")
            codeForToken = hostString.substring(from: range.location + range.length)
            listener.ignore()
        }
        listener.use()
    }
}
