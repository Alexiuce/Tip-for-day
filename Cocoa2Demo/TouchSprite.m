//
//  TouchSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/17.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "TouchSprite.h"

@implementation TouchSprite

- (id)init{
    self = [super initWithImageNamed:@"yellow.png"];
    NSAssert(self, @"init failure");
    [self setUserInteractionEnabled:YES];
    return self;
}

//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
//    XCLog(@"touch yello begin");
//}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    XCLog(@"touch yellow end");
}

@end
