//
//  XCStartScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCStartScene.h"
#import "IADScene.h"

@implementation XCStartScene

- (id)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // 1. setup background
    
    
    // 2. add button
    CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:@"startGame.png"];
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:frame];
    [startButton setTarget:self selector:@selector(startGame)];
    startButton.zoomWhenHighlighted = YES;
    startButton.scaleX = 0.6;
    startButton.scaleY = 0.8;
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5, 0.3);
    [self addChild:startButton];
}


- (void)startGame{
    [[CCDirector sharedDirector] presentScene:[IADScene node]];
}

- (void)dealloc{
    XCLog(@"dealloc");
}

@end
