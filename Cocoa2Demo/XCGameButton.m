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
    XCGameButton *answerButton = [CCButton buttonWithTitle:text spriteFrame:backgroundFrame];
    answerButton.label.fontName = @"AmericanTypewriter-Bold";
    answerButton.label.fontSize = 24;
    answerButton.zoomWhenHighlighted = YES;
    answerButton.positionType = CCPositionTypeNormalized;
    return answerButton;
}

@end
