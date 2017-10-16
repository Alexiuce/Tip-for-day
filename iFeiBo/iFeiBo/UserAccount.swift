//
//  UserAccount.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import MJExtension

class UserAccount: NSObject,NSCoding {
    var access_token = ""
    var expires_in : TimeInterval = 0.0 {
        didSet{
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    var uid = ""
    var expires_date : Date?
    
    init(dict : [String : Any]?){
        super.init()
        guard let dict = dict else { return }
        mj_setKeyValues(dict)
    }

    
    
    /** 解码对象（反序列化）*/
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid = aDecoder.decodeObject(forKey: "uid") as! String
        
    }
    /** 编码对象（序列化）*/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
    }
    
    override var description: String{
        let keys = ["uid","expires_in","access_token"]
        return dictionaryWithValues(forKeys: keys).description
    }
}


