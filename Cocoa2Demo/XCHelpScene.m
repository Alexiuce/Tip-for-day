//
//  XCHelpScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCHelpScene.h"
#import "XCGameButton.h"
#import "NSString+Game.h"

@implementation XCHelpScene

- (id)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    // 1. setup background
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CCSprite *bgSprite = [CCSprite spriteWithImageNamed:[NSString adaptedString: @"helpScene.png"]];
    bgSprite.scaleX = winSize.width / bgSprite.contentSize.width;
    bgSprite.scaleY = winSize.height / bgSprite.contentSize.height;
    bgSprite.position = ccp(winSize.width * 0.5, winSize.height * 0.5);
    [self addChild:bgSprite];
    
    // 2. setup title label
    
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:[NSString adaptedString:@"Help for the Game"]  fontName:@"AmericanTypewriter-Bold" fontSize:24];
    titleLabel.positionType = CCPositionTypeNormalized;
    titleLabel.position = ccp(0.5, 0.9);
    [self addChild:titleLabel];
    
    // 3. setup go back button
    
    XCGameButton *backButton = [XCGameButton gameButtonWithTitle:[NSString adaptedString:@"Go back"]];
    backButton.position = ccp(0.5, 0.1);
    [backButton setTarget:self selector:@selector(goToStartScene)];
    [self addChild:backButton];
}
- (void)goToStartScene{
    self.valueStyle = SceneComebackFromHelp;
    [[CCDirector sharedDirector] popScene];
}
@end
