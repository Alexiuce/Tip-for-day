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
#import <CCTiledMap.h>
#import <CCTiledMapLayer.h>

static const int CountPerRow = 10;
static const CGFloat MarginBetween = 5.0f;
static const CGFloat BeginTopY = 64.0f;

static int planeMap[10][10];

@implementation IADScene

- (id)init{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        CCNodeColor *bg = [CCNodeColor nodeWithColor:CCColor.grayColor];
        [self addChild:bg];
        [self loadTMX];
        for (int i = 0; i < CountPerRow; i++) {
            [self addLine:i + 1];
        }
        
    }
    return self;
}

#pragma mark - Private Method

- (void)loadTMX{
    CCTiledMap *map = [CCTiledMap tiledMapWithFile:@"gridPlane.tmx"];
    
    [self addChild:map];
    
    CCTiledMapLayer *maplayer = [map layerNamed:@"bottom"];

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
              int begin = [maplayer tileGIDAt:ccp(j, i)];
            if (begin != 0 ) {
                printf("%d  ",begin);
                planeMap[i][j] = begin;
            }else{
                printf("0   ");
                planeMap[i][j] = 0;
            }
        }
        printf("\n");
    }
}


- (void)addLine:(NSUInteger)lineNumber{
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    CGFloat spw = (winSize.width - (CountPerRow + 1) * MarginBetween) / CountPerRow;
    CGFloat beginY = (winSize.height - BeginTopY) - ((spw + MarginBetween) * lineNumber - 1);
    
    for (int i = 0; i < CountPerRow; i++) {
        CGFloat x = i * (spw + MarginBetween) + MarginBetween;
//        RectSprite *r = [RectSprite spriteWithColor:CCColor.redColor size:CGSizeMake(spw, spw)];
        int type = planeMap[lineNumber][i];
        NSString *fn = @"yellow.png";
        CCSpriteFrame *normalFrame = [CCSpriteFrame frameWithImageNamed:fn];
        NSString *disableName = fn;
        switch (type) {
            case 5:
                disableName = @"p1.png";
                break;
            case 17:
                disableName = @"p2.png";
                break;
            case 33:
                disableName = @"p3.png";
                break;
        }
        CCSpriteFrame *disableFrame = [CCSpriteFrame frameWithImageNamed:disableName];
        CCButton *btn = [CCButton buttonWithTitle:@"" spriteFrame:normalFrame highlightedSpriteFrame:disableFrame disabledSpriteFrame:nil];
//        CCButton *btn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:fn]];
        [btn setTarget:self selector:@selector(clickButton:)];
        [btn setScale:spw / btn.contentSize.width];
        btn.anchorPoint = CGPointZero;
        btn.position = ccp(x, beginY);
        [self addChild:btn];
        
    }
}

#pragma mark - Button Target Event
- (void)clickButton:(CCButton *)btn{
   
    CCActionBlink *blink = [CCActionBlink actionWithDuration:0.3 blinks:2];
    [btn runAction:blink];
    
    if (btn.state == CCControlStateDisabled) {
        return;
    }
    btn.state = CCControlStateDisabled;
    
}


//- (void)onEnter{
//    [super onEnter];
//    ViewController *vc = [[ViewController alloc]init];
//    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
//
//}

@end
