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



@implementation IADScene

- (id)init{
    if (self = [super init]) {
        CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
        [self addChild:bg];
        
        // 绘制点
        CCDrawNode *dn = [CCDrawNode node];
        [dn drawDot:ccp(20, 300) radius:12 color:CCColor.redColor];
        [self addChild:dn];
        
        // 绘制线段
        CCDrawNode *dn1 = [CCDrawNode node];
        [dn1 drawSegmentFrom:ccp(50, 50) to:ccp(200, 90) radius:1 color:CCColor.yellowColor];
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
        
        
        
//        RectSprite *r1 = [RectSprite spriteWithColor:CCColor.yellowColor size:CGSizeMake(50, 50)];
//        r1.position = ccp(100, 100);
//        [self addChild:r1];
        
    }
    return self;
}


//- (void)onEnter{
//    [super onEnter];
//    ViewController *vc = [[ViewController alloc]init];
//    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
//
//}

@end
