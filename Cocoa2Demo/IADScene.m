//
//  IADScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/15.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "IADScene.h"
#import "ViewController.h"
#import "RectSprite.h"
#import "QQSprite.h"
#import "TouchSprite.h"

static const int CountPerRow = 10;
static const CGFloat MarginBetween = 5.0f;
static const CGFloat BeginTopY = 64.0f;

@implementation IADScene

- (id)init{
    if (self = [super init]) {
//        self.userInteractionEnabled = YES;
        CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
        [self addChild:bg];
        
        // 绘制点
        CCDrawNode *dn = [CCDrawNode node];
        [dn drawDot:ccp(20, 300) radius:12 color:CCColor.redColor];
        [self addChild:dn];
        
        // 绘制线段
        CCDrawNode *dn1 = [CCDrawNode node];
        [dn1 drawSegmentFrom:ccp(50, 50) to:ccp(200, 50) radius:1 color:CCColor.yellowColor];
        [self addChild:dn1];
        
        // 绘制多边形
        CCDrawNode *dn2 = [CCDrawNode node];
        CGPoint vertices[4];
        vertices[0] = ccp(100, 100);
        vertices[1] = ccp(100, 200);
        vertices[2] = ccp(200, 200);
        vertices[3] = ccp(200, 100);
        [dn2 drawPolyWithVerts:vertices count:4 fillColor:CCColor.orangeColor borderWidth:2.0 borderColor:CCColor.blueColor];
        [self addChild:dn2];
        
      
        for (int i = 0; i < CountPerRow; i++) {
            [self addLine:i + 1];
        }
        
        QQSprite *qq = [QQSprite node];
        qq.position = ccp(150, 100);
        [self addChild:qq];
        
        
        TouchSprite *tp = [TouchSprite node];
        tp.position = ccp(90, 90);
        [self addChild:tp];
        
    }
    return self;
}

#pragma mark - Private Method
- (void)addLine:(NSUInteger)lineNumber{
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    CGFloat spw = (winSize.width - (CountPerRow + 1) * MarginBetween) / CountPerRow;
    
    CGFloat beginY = (winSize.height - BeginTopY) - ((spw + MarginBetween) * lineNumber - 1);
    
    for (int i = 0; i < CountPerRow; i++) {
        CGFloat x = i * (spw + MarginBetween) + MarginBetween;
        RectSprite *r = [RectSprite spriteWithColor:CCColor.yellowColor size:CGSizeMake(spw, spw)];
        
        r.anchorPoint = CGPointZero;
        r.position = ccp(x, beginY);
        [self addChild:r];
    }
}


//- (void)onEnter{
//    [super onEnter];
//    ViewController *vc = [[ViewController alloc]init];
//    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
//
//}
//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
//    CGPoint touchPoint = [touch locationInNode:self];
//    for (CCNode *node in self.children) {
//        if ([node isKindOfClass:[RectSprite class]] && CGRectContainsPoint(node.boundingBox, touchPoint)) {
//            XCLog(@"rect sprite");
//            break;
//        }
//    }
//}

@end
