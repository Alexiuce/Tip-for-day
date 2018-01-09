//
//  QQSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/8.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "QQSprite.h"

@implementation QQSprite

- (id)init{
    self = [super initWithImageNamed:@"qq.png"];
    self.anchorPoint = CGPointZero;
    NSAssert(self, @"error init ");
//    [self setUserInteractionEnabled:YES];
    
    XCLog(@"qq init");
    
//    [self schedule:@selector(myUpdate) interval:1.0];
    return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    XCLog(@"touched qq");
    
    CCAction *action = [CCActionBlink actionWithDuration:0.5 blinks:1];
    [self runAction:action];

}

/**
* 系统自动调用此方法 (每秒60次)
*
 @param delta 间隔时间
 */
//- (void)update:(CCTime)delta{
//    static int a = 0;
//    XCLog(@"%zd",a++);
//}

/**
 * 自定义的更新方法
 */
- (void)myUpdate{
    XCLog(@"update");
}

@end
