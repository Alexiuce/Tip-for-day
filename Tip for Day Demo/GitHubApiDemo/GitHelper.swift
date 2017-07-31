//
//  GitHelper.swift
//  Tip for Day Demo
//
//  Created by Alexcai on 2017/7/29.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import Cocoa


@objc protocol GitHelperProtocol {
    func gitHelperStartLaunch();
    func gitHelperDidFinished();
}

class GitHelper: NSObject {
    
    

}

extension GitHelper{
    open func gitClone(_ repoUrl:String){
        executeShellCommond("git clone \(repoUrl)")
    }
}

extension GitHelper{
    fileprivate func executeShellCommond(_ cmd: String){
        let task = Process()
        
        task.launchPath = "/bin/bash"
        task.arguments = ["-c",cmd]
        
        
        task.launch()
        
        
    }
}
