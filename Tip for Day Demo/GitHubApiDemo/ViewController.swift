//
//  ViewController.swift
//  GitHubApiDemo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa
import WebKit
import Alamofire
import SwiftyJSON

class ViewController: NSViewController {

     @IBOutlet weak var topBox: NSView!
    @IBOutlet weak var webView: WebView!
    
    @IBOutlet weak var leftTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      let server = "https://github.com"
        let url = URL(string: server)!
        let requet = URLRequest(url: url)
        webView.mainFrame.load(requet)
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController : WebPolicyDelegate{
    func webView(_ webView: WebView!, decidePolicyForNavigationAction actionInformation: [AnyHashable : Any]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
        XCPrint(request.url?.host)
        let host = request.url!.host! as NSString
        
        if host .isEqual(to: "alexiuce.github.io") {
            XCPrint("alexicuce")
            listener.ignore()
        }else{
            listener.use()
        }
    
    }
}


extension ViewController{
    fileprivate func loadOAuthor(){
       
//        Alamofire.request(baseURL + apiName + clientID, method: .put, parameters: para).responseJSON { (response) in
//            if let data = response.data {
//                let json = JSON.init(data: data)
//                XCPrint(json)
//            }
//        }
    }
}

