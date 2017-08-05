//
//  ToDoStore.swift
//  SingleDataFlowDemo
//
//  Created by alexiuce  on 2017/8/2.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import Foundation


let dummy = ["buy iWatch","Sale OSX App","buy U disk"]

struct ToDoStore {
    static let shareStore = ToDoStore()
    func getToDoItems(_ completionHandler: (([String])->Void)? ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            completionHandler?(dummy)
        }
    }
}
