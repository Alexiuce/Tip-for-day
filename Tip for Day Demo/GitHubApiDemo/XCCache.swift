//
//  XCCache.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/8/3.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Foundation


class XCCache{
    static let share = XCCache()
    
    fileprivate let cache = NSCache<AnyObject, AnyObject>()
    
      func xc_cache(_ key : AnyObject , value : AnyObject) {
        DispatchQueue.global().async {
            self.cache.setObject(value, forKey: key)            
        }
    }
    
     func xc_getCacheValue(key : AnyObject) -> AnyObject? {
        return cache.object(forKey: key)
    }
}
