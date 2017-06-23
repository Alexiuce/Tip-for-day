//
//  ViewController.swift
//  GitHubApiDemo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa

import Alamofire
import SwiftyJSON

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL  = "https://api.github.com"
        let appID = "240fdaed9235e27e6203"
        let apiName = "/authorizations/clients/:" + appID
        
         let para =   ["client_secret": "2c363097e99fe86a0c813201077312d96cd7342d",
            "scopes": ["public_repo"],
            "note": "admin script"] as [String : Any]
//        let para = ["client_secret" : "2c363097e99fe86a0c813201077312d96cd7342d"] as [String : Any]
        Alamofire.request(baseURL + "/" + apiName, method: .put, parameters: para).responseJSON { (response) in
            
            guard let data = response.data else{
                XCPrint(response.result.error?.localizedDescription)
                return
            }
           let json = JSON.init(data: data)
            XCPrint(json)
            
            
        }

        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

