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
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"你好,世界" fontName:@"ArialMT" fontSize:16];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5,0.5};
    [self addChild:label];
    
    return self;
}
@end
