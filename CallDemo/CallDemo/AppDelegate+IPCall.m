//
//  AppDelegate+IPCall.m
//  CallDemo
//
//  Created by alexiuce  on 2017/7/20.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "AppDelegate+IPCall.h"
#import <ALCall_Sdk/ALCall_Sdk.h>

@implementation AppDelegate (IPCall)

- (void)repareForCall{
    // Required - 注册 ALCHelperInstance
    ALCHelperInstance.appKey = @"2139e1b8ca68e7ce7fe5a2dce3bb7648";
    ALCHelperInstance.appToken = @"13dfb8bbdbad2d060f7cefcf7a472bef";

    // 添加震动提示交互（可选）
    [ALCHelperInstance setupVibra:YES];
}

@end
