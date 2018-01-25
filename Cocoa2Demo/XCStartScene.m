//
//  XCStartScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCStartScene.h"
#import "IADScene.h"
#import <CCParticles.h>
#import <CCTextureCache.h>
#import <CCMotionStreak.h>
#import <CCNodeTag.h>
#import <CCEffectNode.h>
#import <CCEffectBrightness.h>

static const int EffectTag = 1;


@implementation XCStartScene

- (id)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    // 1. setup background

    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CCEffectNode *efn = [CCEffectNode effectNodeWithWidth:winSize.width height:winSize.height pixelFormat:CCTexturePixelFormat_RGBA8888];
    efn.tag = EffectTag;
    
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"scrollBg.png"];
    bg.scaleX = winSize.width / bg.contentSize.width;
    bg.scaleY = winSize.height / bg.contentSize.height;
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(0.5, 0.5);

    
   
    
    CCLabelTTF *ttfLabel = [CCLabelTTF labelWithString:@"There is three planes in map, you need shoot them down with 10 bullets,once you find one plane ,you will give a star. if you used all buttles ,you will lose the game.so are you ready ?" fontName:@"Avenir-Book" fontSize:20 dimensions:CGSizeMake(winSize.width - 60, 200)];
//    ttfLabel.outlineWidth = 1;
//    ttfLabel.outlineColor = CCColor.lightGrayColor;
    ttfLabel.color = CCColor.blackColor;
    ttfLabel.positionType = CCPositionTypeNormalized;
    ttfLabel.position = ccp(0.5, 0.65);
//    [self addChild:ttfLabel];
    
   

    
    // 2. add help button
    CCSprite *helpSprite = [CCSprite spriteWithImageNamed:@"helpButton.png"];
    helpSprite.positionType = CCPositionTypeNormalized;
    helpSprite.position = ccp(0.9, 0.9);
//    [self addChild:helpSprite];
    
    // 3. add  start button
    CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:@"startGame.png"];
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:frame];
    [startButton setTarget:self selector:@selector(startGame)];
    startButton.zoomWhenHighlighted = YES;
    startButton.scaleX = 0.6;
    startButton.scaleY = 0.8;
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5, 0.3);
//    [self addChild:startButton];
    
    efn.effect = [CCEffectBrightness effectWithBrightness:0];
    [efn addChild:bg];
    [efn addChild:helpSprite];
    [efn addChild:ttfLabel];
    [efn addChild:startButton];
    [self addChild:efn];
   
}


- (void)startGame{
    
 
    [self schedule:@selector(changeToGameScene) interval:0.1];
    
}

- (void)changeToGameScene{
    CCEffectNode *efn = (CCEffectNode *)[self getChildByTag:EffectTag];
    CCEffectBrightness *bright = (CCEffectBrightness *)efn.effect;
    if (bright.brightness <= -1) {
        [self unschedule:_cmd];
        [[CCDirector sharedDirector] presentScene:[IADScene node]];
    }else{
        bright.brightness = MAX(-1, bright.brightness - 0.1);
    }
}

- (void)dealloc{
    XCLog(@"dealloc");
}

@end
