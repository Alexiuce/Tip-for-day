//
//  RectSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/16.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "RectSprite.h"
#import <CCParticles.h>


@interface RectSprite()

@property (nonatomic, assign) BOOL hasExplosion;

@property (nonatomic, weak) CCDrawNode *bgNode;

@property (nonatomic, assign) BOOL hasResult;

@end


@implementation RectSprite



+ (instancetype)spriteWithColor:(CCColor *)color size:(CGSize)size{
    return [[self alloc] initWithColor:color size:size];
}


- (instancetype)initWithColor:(CCColor *)color size:(CGSize)size{
    self = [super init];
    [self setUserInteractionEnabled:YES];
    NSAssert(self, @"init failure");
    self.color = color;
    self.contentSize = size;
    [self setup];
    return self;
}

- (void)setup{
    CCDrawNode *bg = [CCDrawNode node];
    CGPoint rect[4];
    rect[0] = CGPointZero;
    rect[1] = ccp(0, self.contentSize.height);
    rect[2] = ccp(self.contentSize.height, self.contentSize.width);
    rect[3] = ccp(self.contentSize.width, 0);

    [bg drawPolyWithVerts:rect count:4 fillColor:self.color borderWidth:0 borderColor:CCColor.redColor];
    [self addChild:bg];
    _bgNode = bg;
}


- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [self showResult];

}


- (void)startFlip{
    self.bgNode.color = CCColor.greenColor;
    CCActionBlink *fx = [CCActionBlink actionWithDuration:0.7 blinks:2 ];



    [self runAction:fx];
}

- (void)showResult{
    if (_hasResult) {
        return;
    }
    _hasResult = YES;
    int random = arc4random_uniform(3) ;
    switch (random) {
        case 0:
            [self addCircle];
            break;
            
        case 1:
            [self addCrose];
            break;
        case 2:
            [self addTriangle];
            break;
    
    }

}


- (void)addCircle{
    CCDrawNode *node = [CCDrawNode node];
    CGFloat w = self.contentSize.width;
    CGFloat h = self.contentSize.height;
    CGFloat r = w / 2 - 5;
    CCColor *c = CCColor.orangeColor;
    [node drawDot:ccp(w / 2, h / 2) radius:r color:c];
    [self addChild:node];
}


/**
 # 添加交叉
 */
- (void)addCrose{
    CCDrawNode *node1 = [CCDrawNode node];
    CGFloat padding = 5;
    CGFloat radius = 3;
    CCColor *lineColor = CCColor.redColor;
    CGFloat w = self.contentSize.width;
    CGFloat h = self.contentSize.height;
    CGPoint leftDown = ccp(padding, padding);
    CGPoint rightUp = ccp(w - padding, h - padding);

    CGPoint leftUp = ccp(padding, h -padding);
    CGPoint rightDown = ccp(w - padding, padding);
    [node1 drawSegmentFrom:leftDown to:rightUp radius:radius color:lineColor];
    [self addChild:node1];
    
    CCDrawNode *node2 = [CCDrawNode node];
    [node1 drawSegmentFrom:leftUp to:rightDown radius:radius color:lineColor];
    [self addChild:node2];
    
    
}

/**
 # 添加绘制的三角形
 */
- (void)addTriangle{
    CCDrawNode *node =[CCDrawNode node];
    CGPoint rect[3];
    rect[0] = ccp(5, 5);
    rect[1] = ccp(self.contentSize.width / 2, self.contentSize.height - 5);
    rect[2] = ccp(self.contentSize.width - 5, 5);
    
    [node drawPolyWithVerts:rect count:3 fillColor:CCColor.greenColor borderWidth:0 borderColor:CCColor.redColor];
    [self addChild:node];
}


- (void)particleEffect{
    if (self.hasExplosion) { XCLog(@"children %zd",self.children.count); return;}
    XCLog(@"children %zd",self.children.count);
    self.hasExplosion = YES;
    CCParticleExplosion *explosion = [CCParticleExplosion node];
    explosion.texture = [CCTexture textureWithFile:@"point.png"];
    explosion.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
    explosion.emitterMode = CCParticleSystemModeRadius;
    explosion.startColor = CCColor.blackColor;
    explosion.startColorVar = CCColor.redColor;
    explosion.endColor = CCColor.purpleColor;
    explosion.endColorVar = CCColor.whiteColor;
    explosion.life = 0.5;
    explosion.lifeVar = 0.2;
    explosion.autoRemoveOnFinish = YES;
    explosion.startRadius = 5;
    explosion.startRadiusVar = 1;
    explosion.endRadius = 20;
    explosion.endRadiusVar = 3;
    [self addChild:explosion];
}



@end
