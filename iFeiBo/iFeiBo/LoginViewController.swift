//
//  LoginViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    /** start login  */
    @IBAction func startLogin(_ sender: NSButton) {
       

        let homeWindowController = storyboard?.instantiateController(withIdentifier: kFBHomeControllerID) as! HomeWindowController
        
        homeWindowController.showWindow(nil)
        
      
        
        /*
         let loginURL = URL(string: kFBOAuth2URLPath)!
         NSWorkspace.shared().open(loginURL)
         */
    }
    
}

