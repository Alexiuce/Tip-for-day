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
        
        let cellNib = NSNib(nibNamed:"RespositoryCell", bundle: nil)
        leftTable.register(cellNib, forIdentifier: "respositoryCell")
        leftTable.rowHeight = 100
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            XCPrint("dlefaeladsf")
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
}

extension ViewController : NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "respositoryCell", owner: self) as! RespositoryCell
        cell.titleTextField.stringValue = "text \(row)"
        return cell
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

