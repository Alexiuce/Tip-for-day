//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "QQSprite.h"

@interface GameScene()

@property (nonatomic, strong) CCSpriteFrameCache *spriteFrameCache;

@end


@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    
    CGFloat height = [CCDirector sharedDirector].viewSize.height;
    
    // 添加背景

    CCSprite *background = [CCSprite spriteWithSpriteFrame:[self.spriteFrameCache spriteFrameByName:@"background_2.png"]];
    
    background.anchorPoint = CGPointZero;
    
    [self addChild:background];
    
    
    
    
    
    // 添加文字
    
    // 添加图片
    CCSprite *qq = [CCSprite spriteWithImageNamed:@"qq.png"];
    qq.position = ccp(100, 100);
    [self addChild:qq];

    

    
    // 添加移动动画
    
    CCAction *action = [CCActionMoveBy actionWithDuration:5.0 position:ccp(0, -height)];
    
    CCAction *callAction = [CCActionCallFunc actionWithTarget:self selector:@selector(moveBackground)];
    
    CCAction *seqActon = [CCActionSequence actionWithArray:@[action,callAction]];
    
    [background runAction:seqActon];
    
    
    return self;
}

#pragma mark -
- (void)moveBackground{
    XCLog(@"move end");
}


#pragma mark - lazy method
- (CCSpriteFrameCache *)spriteFrameCache{
    if (_spriteFrameCache == nil) {
        _spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache] ;
        [_spriteFrameCache addSpriteFramesWithFile:@"gameArts.plist"];
    }
    return _spriteFrameCache;
}

@end
