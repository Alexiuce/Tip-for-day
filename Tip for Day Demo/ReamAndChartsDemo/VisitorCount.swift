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
    dynamic var data = Data()
    
    func saveToDatabase() {
        guard let realm = try? Realm() else {return}
        try? realm.write {
            realm.add(self)
        }
        
    }
}
