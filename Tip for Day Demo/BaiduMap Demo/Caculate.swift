//
//  Caculate.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/5.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Foundation

/** 比较两个地理位置是否相同 */
func compareLocation(_ source: CLLocationCoordinate2D , dest:CLLocationCoordinate2D?) -> Bool {
    if dest == nil {return false}
    return source.longitude == dest!.longitude && source.latitude == dest!.latitude
}
