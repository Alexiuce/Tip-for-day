//
//  XCMediatorManager.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/11.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCMediatorManager.h"

@implementation XCMediatorManager


+ (id)performTarget:(NSString *)target actoion:(NSString *)actionName params:(id)params isRequireReturenValue:(BOOL)isRequired{
    
    // 1. 获取目标对象
    Class targetCls = NSClassFromString(target);
    if (targetCls == nil){
        return nil;
    }
    
    // 2. 获取行为
    SEL action = NSSelectorFromString(actionName);
    if (action == nil){
        return nil;
    }
    
    // 3.判断对象是否响应行为
    
    if (![targetCls respondsToSelector:action]){
        return nil;
    }
    
    return nil;
}

@end
