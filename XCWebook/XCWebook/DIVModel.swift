//
//  DIVModel.swift
//  XCWebook
//
//  Created by alexiuce  on 2017/8/15.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit

class DIVModel: NSObject {
    
    var href = ""
    var text = ""
    
    
    
    init(div: String) {
        super.init()
        let begingRange = (div as NSString).range(of: "href=")
        let endRange = (div as NSString).range(of: "</a>")
        let hrefLocation = begingRange.location + begingRange.length + 1
        href = (div as NSString).substring(with: NSMakeRange(hrefLocation, 20))
        let textLocation = hrefLocation + 22
        let textLenght = endRange.location - textLocation
        text = (div as NSString).substring(with: NSMakeRange(textLocation, textLenght))
    }
    
}
