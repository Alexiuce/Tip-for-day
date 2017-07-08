//
//  VisitorCount.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/6.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit
import RealmSwift

class VisitorCount: Object {
    dynamic var count = 0
    dynamic var date = Date()
    
    func saveToDatabase() {
    
        do{
            let realm =  try Realm()
            
            try realm.write {
                realm.add(self)
            }
        }catch let erroe as NSError{
            print(erroe.localizedDescription)
        }
    }
}
