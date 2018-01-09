//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "QQSprite.h"

@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    
    // 添加背景
    CCSprite *background = [CCSprite spriteWithImageNamed:@"background_1.png"];
    [background setScaleX:1.2];
    [background setScaleY:1.5];
    background.anchorPoint = (CGPoint){0,0};
    [self addChild:background];
    
//    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    // 添加文字
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"你好,世界" fontName:@"ArialMT" fontSize:16];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5,0.5};
    [self addChild:label];
    
    // 添加图片
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"ic_launcher.png"];
//    sprite.positionType = CCPositionTypeNormalized;
//    sprite.position = (CGPoint){1,0};
    sprite.position = ccp(100, 200);
    [self addChild:sprite z:0 name:@"cocos"];
    

    
    // 添加移动动画
    id move = [CCActionMoveTo actionWithDuration:2.0 position:ccp(200, 200)];
    [sprite runAction:move];

    
    
    QQSprite *qq = [QQSprite node];
    [self addChild:qq];
    
    
    
    return self;
}



@end
