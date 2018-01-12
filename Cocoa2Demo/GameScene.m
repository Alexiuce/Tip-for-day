//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "QQSprite.h"

#import <CoreMotion/CoreMotion.h>



static const CGFloat kAnimationDuration = 30.0;

@interface GameScene()

@property (nonatomic, strong) CCSpriteFrameCache *spriteFrameCache;
@property (nonatomic, strong) CCSprite *background;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) CCSprite *qq;

@end


@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    _motionManager = [[CMMotionManager alloc]init];
     self.userInteractionEnabled = YES;
    CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
    [self addChild:bg];
    
    _qq = [CCSprite spriteWithImageNamed:@"qq.png"];
    
    _qq.position = ccp(100, 100);
    _qq.color = [CCColor redColor];
    
    [self addChild:_qq];
    
//    [self setupUI];
    
    
    return self;
}

- (void)setupUI{
    
   
    // 添加背景
    
    CCSprite *background1 = [CCSprite spriteWithSpriteFrame:[self.spriteFrameCache spriteFrameByName:@"background_2.png"]];
    
    CGFloat height = background1.contentSize.height - 1;
    background1.anchorPoint = CGPointZero;
    background1.position = ccp(0, height);
    [self addChild:background1];
    
    _background = [CCSprite spriteWithSpriteFrame:[self.spriteFrameCache spriteFrameByName:@"background_2.png"]];
    
    _background.anchorPoint = CGPointZero;
    
    [self addChild:_background];
    
    // 添加文字
    
    
    // 添加图片
    CCSprite *qq = [CCSprite spriteWithImageNamed:@"qq.png"];
//    qq.positionType = CCPositionTypeMake(CCPositionUnitUIPoints, CCPositionUnitNormalized, CCPositionReferenceCornerTopRight);
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
}

#pragma mark - Touch
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [self.qq stopActionByTag:0];
    CGPoint p = [touch locationInNode:self];
    
    CCLOG(@"target p = %@",NSStringFromCGPoint(p));
    CGFloat d = ccpDistance(p, self.qq.position) / 200.0;
    
    CCLOG(@"distance %.2f" ,d);
    
    CCActionMoveTo *moveAction = [CCActionMoveTo actionWithDuration:d position:p];
    [moveAction setTag:0];
    [self.qq runAction:moveAction];
}

- (void)onEnter{
    [super onEnter];
    [self.motionManager startAccelerometerUpdates];
}

- (void)onExit{
    [super onExit];
    [self.motionManager stopAccelerometerUpdates];
}

- (void)update:(CCTime)delta{
    CMAccelerometerData *accData =  _motionManager.accelerometerData;
    CMAcceleration acceleration = accData.acceleration;
    CGFloat xP = _qq.position.x + acceleration.x * 1500 * delta;
    if (xP > 300) {xP = 300;}
    if (xP < 10) {xP = 10;}
    _qq.position = ccp(xP, _qq.position.y);
    
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
