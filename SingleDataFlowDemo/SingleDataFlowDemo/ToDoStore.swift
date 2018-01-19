//
//  ToDoStore.swift
//  SingleDataFlowDemo
//
//  Created by alexiuce  on 2017/8/2.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Foundation


let dummy = [NSLocalizedString("buy iWatch", comment: ""),
             NSLocalizedString("Sale OSX App", comment: "") ,
             NSLocalizedString("buy U disk", comment: "") ]

struct ToDoStore {
    static let shareStore = ToDoStore()
    func getToDoItems(_ completionHandler: (([String])->Void)? ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            completionHandler?(dummy)
        }
    }
}

