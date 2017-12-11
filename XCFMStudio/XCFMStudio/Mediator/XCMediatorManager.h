//
//  XCMediatorManager.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/11.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCMediatorManager : NSObject

+ (id)performTarget:(NSString *)target actoion:(NSString *)actionName params:(id)params isRequireReturenValue:(BOOL)isRequired;

@end
