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

static const CGFloat AirCraftTopMargin = 76;
static const CGFloat AirCraftXMargin = 64;
static const CGFloat AirCraftMidPadding = 192;


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
    
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"scrollImage.png"];
    bg.scaleX = winSize.width / bg.contentSize.width;
    bg.scaleY = winSize.height / bg.contentSize.height;
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(0.5, 0.5);
    
    CCSprite *maxtixSprite = [CCSprite spriteWithImageNamed:@"matrix.png"];
    maxtixSprite.scaleX = bg.scaleX;
    maxtixSprite.scaleY = bg.scaleY;
    maxtixSprite.anchorPoint = ccp(0, 1);
    maxtixSprite.position = ccp(1, winSize.height - 117);
    
    
    
    CCLabelTTF *ttfLabel = [CCLabelTTF labelWithString:@"There is three planes in map, you need shoot them down with 10 bullets,once you find one plane ,you will give a star. if you used all buttles ,you will lose the game.so are you ready ?" fontName:@"Avenir-Book" fontSize:20 dimensions:CGSizeMake(winSize.width - 60, 200)];
//    ttfLabel.outlineWidth = 1;
//    ttfLabel.outlineColor = CCColor.lightGrayColor;
    ttfLabel.color = CCColor.blackColor;
    ttfLabel.positionType = CCPositionTypeNormalized;
    ttfLabel.position = ccp(0.5, 0.65);
//    [self addChild:ttfLabel];
    
   

    
    // 2. add help button
    CCSpriteFrame *helpFrame = [CCSpriteFrame frameWithImageNamed:@"helpButton.png"];
    CCButton *helpSprite = [CCButton buttonWithTitle:@"" spriteFrame:helpFrame];
    helpSprite.positionType = CCPositionTypeNormalized;
    helpSprite.position = ccp(0.9, 0.9);

    
    // 3. add  start button
    CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:@"startGame.png"];
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:frame];
    [startButton setTarget:self selector:@selector(startGame)];

    startButton.scaleX = 0.6;
    startButton.scaleY = 0.8;
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5, 0.15);
    
    efn.effect = [CCEffectBrightness effectWithBrightness:0];
    [efn addChild:bg];
    
    [efn addChild:helpSprite];
    [efn addChild:ttfLabel];
    [efn addChild:startButton];
    [efn addChild:maxtixSprite];
    [self addChild:efn];

    
    
    
    //
    CCSprite *maskLaunchSprite = [CCSprite spriteWithImageNamed:@"launchBg.png"];
    maskLaunchSprite.scaleX = winSize.width / maskLaunchSprite.contentSize.width;
    maskLaunchSprite.scaleY = winSize.height / maskLaunchSprite.contentSize.height;
    maskLaunchSprite.positionType = CCPositionTypeNormalized;
    maskLaunchSprite.position = ccp(0.5, 0.5);
    [self addChild:maskLaunchSprite];
    
    CCSprite *leftAircraft = [CCSprite spriteWithImageNamed:@"leftAircraft"];
   
    leftAircraft.anchorPoint = ccp(0, 1);
  
    leftAircraft.position = ccp(AirCraftXMargin,winSize.height - AirCraftTopMargin);
    [self addChild:leftAircraft];
    CCSprite *rightAircraft = [CCSprite spriteWithImageNamed:@"leftAircraft"];
    rightAircraft.anchorPoint = ccp(1, 1);
    rightAircraft.position = ccp(winSize.width - AirCraftXMargin, winSize.height - AirCraftTopMargin);
    [self addChild:rightAircraft];
    CCSprite *downAircraft = [CCSprite spriteWithImageNamed:@"downCraft"];
    downAircraft.anchorPoint = ccp(0.5, 1);
    downAircraft.position = ccp(winSize.width * 0.5, winSize.height - AirCraftMidPadding);
    [self addChild:downAircraft];
    
    CCTime duration = 2.0;
    CGPoint endPoint = ccp(0, 200);
    CCActionMoveBy *moveBy = [CCActionMoveBy actionWithDuration:duration position:endPoint];
    [leftAircraft runAction:moveBy];
    CCActionMoveBy *rmoveBy = [CCActionMoveBy actionWithDuration:duration position:endPoint];
    [rightAircraft runAction:rmoveBy];
    CGPoint dendPoint = ccp(0, 300);
    CCActionMoveBy *dmoveBy = [CCActionMoveBy actionWithDuration:duration position:dendPoint];
    [downAircraft runAction:dmoveBy];
    
    CCActionDelay *delay = [CCActionDelay actionWithDuration:duration];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:0.7];
    CCActionSequence *as = [CCActionSequence actions:delay,fadeOut, nil];
//    CCActionHide *hiden = [CCActionHide action];
    [maskLaunchSprite runAction:as];
    
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
