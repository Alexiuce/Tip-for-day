//
//  XCSprite.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/13.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCSprite.h"
#import "XCFrameCache.h"

@interface XCSprite()

@property (nonatomic, assign) XCSpriteType type;

@end


@implementation XCSprite

+ (instancetype)spritWithType:(XCSpriteType)type{
    return [[self alloc] initWithType:type];
}

- (instancetype)initWithType:(XCSpriteType)type{
    // 获取全局纹理数据
    CCSpriteFrameCache *sfc = [XCFrameCache frameCacheForGameArts];
    NSString *name = type == XCSpritePlayer ? @"hero_fly_1.png" : @"enemy1_fly_1.png";
    if ( self = [super initWithSpriteFrame:[sfc spriteFrameByName:name]]) {
        if (type == XCSpriteEnemy) {  // 设置敌机的初始位置
            [self forcePoistion];
        }
        self.type = type;
    }
    return self;
}

#pragma mark - 重写刷新方法
- (void)update:(CCTime)delta{
    if (self.type == XCSpriteEnemy) {
        self.position = ccpAdd(self.position, self.moveSpeed);
        
        if (self.position.y < - self.contentSize.height / 2) {
            [self forcePoistion];
        }
    }
}

- (void)forcePoistion{
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CGFloat yPoint = winSize.height + self.contentSize.height / 2;
    CGFloat xPoint = CCRANDOM_0_1() * (winSize.width - self.contentSize.width) + self.contentSize.width / 2;
    self.position = ccp(xPoint, yPoint);
}


@end
