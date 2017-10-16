//
//  HTTPManager.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire

class HTTPManager {

    class func getWBStatus(_ begingID :Int64 = 0 ,endID : Int64 = 0 , finished : @escaping ([String : Any]?)->()) {
        
        // 1. url
        let statusURL = URL(string: WBStatusURL)!
        // 2. setup parameter
        let para = ["access_token": UAToolManager.defaultManager.userAccount!.access_token,
                    "since_id":begingID,
                    "max_id": endID] as [String : Any]
        
        // 3. send https request
        Alamofire.request(statusURL, method: HTTPMethod.get, parameters:para ).responseJSON { (response) in
           
            if let error = response.error{
                XCPring(error.localizedDescription)
            }
            
            guard let dict = response.value as? [String : Any] else {return}
            // 3. callback closure
            finished(dict)
        }
    }

}
