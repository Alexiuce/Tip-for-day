//
//  XCGameButton.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCGameButton.h"

@implementation XCGameButton

+ (instancetype)gameButtonWithTitle:(NSString *)text{
    CCSpriteFrame *backgroundFrame = [CCSpriteFrame frameWithImageNamed:@"buttonbackground.png"];
    XCGameButton *btn = [CCButton buttonWithTitle:text spriteFrame:backgroundFrame];
    btn.label.fontName = @"AmericanTypewriter-Bold";
    btn.label.fontSize = 24;
    btn.zoomWhenHighlighted = YES;
    return btn;
}

@end
