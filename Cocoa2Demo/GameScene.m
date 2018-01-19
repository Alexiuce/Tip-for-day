//
//  GameScene.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/6.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "QQSprite.h"
#import "XCFrameCache.h"
#import <CCActionManager.h>
#import <CoreMotion/CoreMotion.h>
#import "XCSprite.h"
#import <CCParticles.h>


static const CGFloat kAnimationDuration = 30.0;

@interface GameScene()
@property (nonatomic, strong) CCSprite *background;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) XCSprite *player;
@property (nonatomic, strong) CCParticleSystem *fire;

@end


@implementation GameScene

- (id)init{
    self = [super init];
    NSAssert(self, @"game scene init failure");
    self.userInteractionEnabled = YES;
    // 设置背景
//    CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
//    [self addChild:bg];
   
//    // 创建精灵
//    CCSprite *qq = [CCSprite spriteWithImageNamed:@"qq.png"];
//    qq.position = ccp(100, 100);
//    [self addChild:qq];
//    self.qq = qq;
    
//   
//    self.fire = [CCParticleFire node];
//    self.fire.emitterMode = CCParticleSystemModeRadius;
//    self.fire.startRadius = 200;
//    self.fire.startRadiusVar = 5.0;
//    self.fire.endRadius = 30.0;
//    self.fire.endRadiusVar = 3.0;
//    self.fire.rotatePerSecond = 180.0;
//    self.fire.rotatePerSecondVar = 12.0;
//    self.fire.position = ccp(160, 300);
//    [self addChild:self.fire];
    
    self.player = [XCSprite spritWithType:XCSpritePlayer];
    self.player.position = ccp(200, 100);
    [self addChild:self.player];
    
    CCParticleSystem *fire;
    
    XCSprite *enemy = [XCSprite spritWithType:XCSpriteEnemy];
    enemy.moveSpeed = ccp(0, -3);
    [self addChild:enemy];
    
//    // 添加动画
//    CCActionMoveTo *moveAction = [CCActionMoveTo actionWithDuration:2.0 position:ccp(300, 100)];
//
//    // 添加动画回调动作
//    CCActionCallFunc *endAction = [CCActionCallFunc actionWithTarget:self selector:@selector(endMoveToAction)];
//    // 创建动画执行队列
//    CCActionSequence *sequence = [CCActionSequence actions:moveAction,endAction, nil];
//    [qq runAction:sequence];
    [self setupUI];
//
    return self;
}

- (void)endMoveToAction{
    CCLOG(@"动画执行完毕 ~~");
}

- (void)setupUI{
    
    // 添加背景

    CCSprite *background1 = [CCSprite spriteWithSpriteFrame:[[XCFrameCache frameCacheForGameArts] spriteFrameByName:@"background_2.png"]];
    ccTexParams texParams = {GL_NEAREST,GL_NEAREST,GL_CLAMP_TO_EDGE,GL_CLAMP_TO_EDGE};
    [background1.texture setTexParameters:&texParams];
    CGFloat height = background1.contentSize.height ;
    background1.anchorPoint = CGPointZero;
    background1.position = ccp(0, height);
    [self addChild:background1 z:-1];
    
    _background = [CCSprite spriteWithSpriteFrame:[[XCFrameCache frameCacheForGameArts] spriteFrameByName:@"background_2.png"]];
    
    _background.anchorPoint = CGPointZero;
    
    [self addChild:_background z:-1];
    
    // 添加文字
    
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
    CCActionSequence *seqActon = [CCActionSequence actionWithArray:@[action,action1,action]];
    CCActionRepeatForever *foreverAction = [CCActionRepeatForever actionWithAction: seqActon];
    [_background runAction:foreverAction];
}

#pragma mark - Touch
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [self.player stopActionByTag:0];
    CGPoint p = [touch locationInNode:self];
    // 获取屏幕size
    CGSize screenSize = [CCDirector sharedDirector].viewSize;
    // 根据两点之间的距离计算移动时间
    CGFloat duration = ccpDistance(p, self.player.position) / 200.0;
    // 限制边界值
    p.x = clampf(p.x, self.player.contentSize.width / 2, screenSize.width - self.player.contentSize.width / 2);
    p.y = clampf(p.y, self.player.contentSize.height / 2,screenSize.height - self.player.contentSize.height / 2);
    
    CCActionMoveTo *moveAction = [CCActionMoveTo actionWithDuration:duration position:p];
    [moveAction setTag:0];
    [self.player runAction:moveAction];
}

//- (void)onEnter{
//    [super onEnter];
//    [self.motionManager startAccelerometerUpdates];
//}
//
//- (void)onExit{
//    [super onExit];
//    [self.motionManager stopAccelerometerUpdates];
//}
//
//- (void)update:(CCTime)delta{
//    CMAccelerometerData *accData =  _motionManager.accelerometerData;
//    CMAcceleration acceleration = accData.acceleration;
//    CGFloat xP = _qq.position.x + acceleration.x * 1500 * delta;
//    if (xP > 300) {xP = 300;}
//    if (xP < 10) {xP = 10;}
//    _qq.position = ccp(xP, _qq.position.y);
//
//}

@end
