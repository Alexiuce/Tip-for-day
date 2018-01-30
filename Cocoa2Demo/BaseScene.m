//
//  BaseScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/30.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "BaseScene.h"

@implementation BaseScene


- (void)onExit{
    [super onExit];
    if ([self.valueDelegate respondsToSelector:@selector(setValueForOnEnter:)]) {
        [self.valueDelegate setValueForOnEnter:self.valueStyle];
    }
}

@end
