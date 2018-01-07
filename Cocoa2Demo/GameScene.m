//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    
//    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"你好,世界" fontName:@"ArialMT" fontSize:16];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5,0.5};
    [self addChild:label];
    
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"ic_launcher"];
//    sprite.positionType = CCPositionTypeNormalized;
//    sprite.position = (CGPoint){1,0};
    sprite.position = ccp(100, 200);

    [self addChild:sprite];
    
    
    return self;
}
@end
