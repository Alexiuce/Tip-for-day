//
//  ConstantKey.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Foundation


let kFBHomeControllerID = "Home"
let kFBLoginConttollerID = "Login"
let kFBStatusLoginItemID = "LoginItem"

let kFBAppKey = ""

let kFBOAuth2URLPath = ""



// MARK: - weibo API URL

let WBAppID = "3847062016"
let WBAppSecretKey = "4ca2f345734b0453cb9c0212dae0228c"
let WBAppReDirectURL = "http://alexiuce.github.io"


let WBOAuth2URL = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppID)&scope=all&response_type=code&redirect_uri=\(WBAppReDirectURL)"
let WBTokenURL = "https://api.weibo.com/oauth2/access_token"


/** 获取当前登录用户及其所关注（授权）用户的最新微博 */
let WBStatusURL = "https://api.weibo.com/2/statuses/home_timeline.json"
