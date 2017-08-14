//
//  RegexTool.swift
//  XCWebook
//
//  Created by alexiuce  on 2017/8/14.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit


protocol RegexToolProcotol  {
    func regexFinished(_ result:[String]);
}



class RegexTool: NSObject {
    
    var delegate : RegexToolProcotol?
    
    
    func matchString(inText : String, pattern : String) {
        DispatchQueue.global().async { 
            guard let regex = try? NSRegularExpression(pattern: pattern , options: NSRegularExpression.Options.caseInsensitive) else {return}
            let resultArray = regex.matches(in: inText, options:[], range: NSMakeRange(0, inText.characters.count))
            var results = [String]()
            for rs in resultArray {
                let text = (inText as NSString).substring(with: rs.range)
                results.append(text)
            }
            
            DispatchQueue.main.async(execute: { 
                self.delegate?.regexFinished(results)
            })
            
        }
        
    
        
    }

}




