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
    
    @IBOutlet weak var searchBar : NSSearchField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      let server = "https://github.com"
        let url = URL(string: server)!
        let requet = URLRequest(url: url)
        webView.mainFrame.load(requet)
        searchRespositories("AFN")
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func searchDidChange(_ sender : NSSearchField){
        XCPrint(sender.stringValue)
   
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


extension ViewController : NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        return "text \(row)"
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
       
        let cell = tableView .make(withIdentifier: "github", owner: self) as! NSTableCellView
        cell.textField?.stringValue = object as! String
        
       
    }
    
    
}



extension ViewController{
    fileprivate func searchRespositories(_ keywork: String){
        let baseURL = "https://api.github.com"
        let apiName = "/search/repositories"
        let para = ["q":keywork]
    
     Alamofire.request(baseURL + apiName, method: .get, parameters: para).responseJSON { (response) in
            if let data = response.data {
                let json = JSON.init(data: data)
                XCPrint(json)
            }
        }
    }
}

