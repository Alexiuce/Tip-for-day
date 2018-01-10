//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "QQSprite.h"



static const CGFloat kAnimationDuration = 30.0;

@interface GameScene()

@property (nonatomic, strong) CCSpriteFrameCache *spriteFrameCache;
@property (nonatomic, strong) CCSprite *background;

@end


@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    
    
    // 添加背景
    
    CCSprite *background1 = [CCSprite spriteWithSpriteFrame:[self.spriteFrameCache spriteFrameByName:@"background_2.png"]];
   
    CGFloat height = background1.contentSize.height - 1;
    background1.anchorPoint = CGPointZero;
    background1.position = ccp(0, height);
    [self addChild:background1];

    _background = [CCSprite spriteWithSpriteFrame:[self.spriteFrameCache spriteFrameByName:@"background_2.png"]];

    _background.anchorPoint = CGPointZero;

    [self addChild:_background];
    
    XCLog(@"begin position%@",NSStringFromCGPoint(_background.position));
    
    
    
    // 添加文字
    
    // 添加图片
    CCSprite *qq = [CCSprite spriteWithImageNamed:@"qq.png"];
    qq.position = ccp(100, 100);
    [self addChild:qq];

    

    
    // 添加移动动画
    
  
    {
        CCAction *action = [CCActionMoveBy actionWithDuration:kAnimationDuration position:ccp(0, -height)];
        CCAction *action1 = [CCActionMoveTo actionWithDuration:0 position:ccp(0, height)];
        CCActionInterval *seqActon = [CCActionSequence actionWithArray:@[action,action,action1]];
        CCActionRepeatForever *foreverAction = [CCActionRepeatForever actionWithAction: seqActon];
        [background1 runAction:foreverAction];
        
    }
    
    
    CCAction *action = [CCActionMoveBy actionWithDuration:kAnimationDuration position:ccp(0, -height)];
    CCAction *action1 = [CCActionMoveTo actionWithDuration:0 position:ccp(0, height)];
    CCActionInterval *seqActon = [CCActionSequence actionWithArray:@[action,action1,action]];
    CCActionRepeatForever *foreverAction = [CCActionRepeatForever actionWithAction: seqActon];
    [_background runAction:foreverAction];
    
    return self;
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
