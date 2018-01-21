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
#import "ObjectAL.h"
#import "MainScene.h"


static const int CountPerRow = 10;
static const CGFloat MarginBetween = 5.0f;
static const CGFloat BeginTopY = 64.0f;

static int planeMap[10][10];

@interface IADScene()


@property (nonatomic, strong) NSArray<NSArray <NSNumber *>*> *map;
@property (nonatomic, assign) NSUInteger score;
@property (nonatomic, assign) NSInteger userClickCount;
@property (nonatomic, strong) NSMutableArray *lifeArray;

@property (nonatomic, weak) CCLabelTTF *lifeLabel;

@end

@implementation IADScene

- (id)init{
    if (self = [super init]) {
        self.lifeArray = [NSMutableArray arrayWithCapacity:10];
        self.userInteractionEnabled = YES;
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

- (NSArray<NSArray< NSNumber *>*>*)convertCArrayToNSArray{
    NSString *mapData = [[NSBundle mainBundle] pathForResource:@"planeMap.dat" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:mapData];
    if (array.count > 0) {
        XCLog(@"local array");
        return array;
    }
    NSMutableArray *allArray = [NSMutableArray arrayWithCapacity:CountPerRow];

    for (int i = 0; i < CountPerRow; i++) {
        NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:CountPerRow];
        for (int j = 0; j < CountPerRow; j++) {
            
            [rowArray addObject:@(planeMap[i][j])];
        }
        [allArray addObject:rowArray];
    }
    
    return [allArray copy];
}

- (void)addLine:(NSUInteger)lineNumber{
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    CGFloat spw = (winSize.width - (CountPerRow + 1) * MarginBetween) / CountPerRow;
    CGFloat beginY = (winSize.height - BeginTopY) - ((spw + MarginBetween) * lineNumber - 1);
    
    for (int i = 0; i < CountPerRow; i++) {
        CGFloat x = i * (spw + MarginBetween) + MarginBetween;
//        RectSprite *r = [RectSprite spriteWithColor:CCColor.redColor size:CGSizeMake(spw, spw)];
        int type =  self.map[lineNumber - 1][i].intValue ; //planeMap[lineNumber][i];
        NSString *fn = @"mask.png";
//        CCSpriteFrame *normalFrame = [CCSpriteFrame frameWithImageNamed:fn];
        NSString *disableName = @"empty.png";
        switch (type) {
            case 3:
                disableName = @"head.png";
                break;
            case 17:
                disableName = @"body.png";
                break;
        }
//        CCSpriteFrame *disableFrame = [CCSpriteFrame frameWithImageNamed:disableName];
//        CCButton *btn = [CCButton buttonWithTitle:@"" spriteFrame:normalFrame highlightedSpriteFrame:disableFrame disabledSpriteFrame:nil];
        CCButton *btn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:fn]];
        btn.name = disableName;
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
    // 添加图形
    CCSprite *s = [CCSprite spriteWithImageNamed:btn.name ];
    s.positionType = CCPositionTypeNormalized;
    s.position = ccp(0.5, 0.5);
    [btn addChild:s];
    btn.userInteractionEnabled = NO;
    
    // 统计结果
    if ([btn.name containsString:@"empty"] && --self.userClickCount < 0) {
        MainScene *main = [MainScene node];
        
//        CCTransition *transition = [CCDefaultTransition transitionFadeWithDuration:0.5];
     
        //[CCDefaultTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:0.7];
        [[CCDirector sharedDirector] pushScene:main];
        return;
    }else if ([btn.name containsString:@"head"]){
        self.score++;
        
    }
    // 点击音效
    [[OALSimpleAudio sharedInstance] playEffect:[btn.name stringByReplacingOccurrencesOfString:@"png" withString:@"mp3"]];
    if ([btn.name containsString:@"head"]) {
        self.score++;
    }
    
}


- (void)onEnter{
    [super onEnter];
    [self removeAllChildren];
    XCLog(@"on enter");
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"background.png"];
    bg.anchorPoint = CGPointZero;
    bg.scaleX =  winSize.width / bg.contentSize.width ;
    bg.scaleY = winSize.height / bg.contentSize.height ;
    [self addChild:bg];
    self.map = [self convertCArrayToNSArray];
    for (int i = 0; i < CountPerRow; i++) {
        [self addLine:i + 1];
    }
    self.userClickCount = 10;
    CCLabelTTF *label = [CCLabelTTF labelWithString:NSLocalizedString(@"life", @"") fontName:@"AvenirNext-Bold" fontSize:20];
    label.position = ccp(self.contentSize.width - 190, self.contentSize.height - 37);
    label.color = CCColor.orangeColor;
    [self addChild:label];
}

- (void)updateLife{
   
    for (CCSprite *life in self.lifeArray) {
        [self removeChild:life];
    }
    [self.lifeArray removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CGFloat lifeY = winSize.height - 50;
    for (int i = 0; i < self.userClickCount; i++) {
        CCSprite *lifeSprite = [CCSprite spriteWithImageNamed:@"life.png"];
        lifeSprite.name = @"life";
        lifeSprite.anchorPoint = CGPointZero;
        lifeSprite.position = ccp(winSize.width - i *(lifeSprite.contentSize.width) - 25, lifeY);
        [self addChild:lifeSprite];
        [self.lifeArray addObject:lifeSprite];
    }
}

- (void)setUserClickCount:(NSInteger)userClickCount{
    _userClickCount = userClickCount;
    [self updateLife];
}



@end
