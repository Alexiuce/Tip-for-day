//
//  UAToolManager.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class UAToolManager {
    static let defaultManager = UAToolManager()
    
    var filePath : String{
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/userAccount.dat"
    }
    
    var userAccount : UserAccount? {
        return  NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserAccount
    }
    
    var isLogin : Bool {
        guard let account = userAccount else { return false }
        guard let expire_date = account.expires_date else { return false }
        return expire_date.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    func saveUserAccount(_ account : UserAccount) -> Bool {
       return NSKeyedArchiver.archiveRootObject(account, toFile: filePath)
    }
    
}
