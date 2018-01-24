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
#import "XCFrameCache.h"

static const CGFloat kAnimationDuration = 30.0;
static const int CountPerRow = 10;
static const CGFloat MarginBetween = 2.0f;
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
        //获取当前设备语言
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = [appLanguages objectAtIndex:0];
        XCLog(@"language = %@",languageName);
        
        // 预先加载音效
        for (NSString *name in @[@"head.mp3",@"body.mp3",@"empty.mp3"]) {
            [[OALSimpleAudio sharedInstance] preloadEffect:name];
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
    
    CGFloat topY = (winSize.height - ((CountPerRow - 1)*MarginBetween + CountPerRow * spw)) * 0.5;
    
    CGFloat beginY = (winSize.height - topY) - ((spw + MarginBetween) * lineNumber - 1);
    
    for (int i = 0; i < CountPerRow; i++) {
        CGFloat x = i * (spw + MarginBetween) + MarginBetween;
//        RectSprite *r = [RectSprite spriteWithColor:CCColor.redColor size:CGSizeMake(spw, spw)];
        int type =  self.map[lineNumber - 1][i].intValue ; //planeMap[lineNumber][i];
        NSString *fn = @"p4.png";
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
        main.title = @"game over";
//        CCTransition *transition = [CCDefaultTransition transitionFadeWithDuration:0.5];
     
        //[CCDefaultTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:0.7];
        [[CCDirector sharedDirector] pushScene:main];
        return;
    }else if ([btn.name containsString:@"head"]){
        self.score++;
        if (self.score == 3) {
            MainScene *s = [MainScene node];
            s.title = @"You win!";
            [[CCDirector sharedDirector] pushScene:s];
        }
    }
    
    NSString *effectName = [btn.name stringByReplacingOccurrencesOfString:@"png" withString:@"mp3"];
    
    // 点击音效
    [[OALSimpleAudio sharedInstance] playEffect:effectName];
    
}


- (void)onEnter{
    [super onEnter];
    [self removeAllChildren];
    [self.lifeArray removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    [self setupBg];
//    CCSprite *bg = [CCSprite spriteWithImageNamed:@"background.png"];
//    bg.anchorPoint = CGPointZero;
//    bg.scaleX =  winSize.width / bg.contentSize.width ;
//    bg.scaleY = winSize.height / bg.contentSize.height ;
//    [self addChild:bg];
    self.map = [self convertCArrayToNSArray];
    for (int i = 0; i < CountPerRow; i++) {
        [self addLine:i + 1];
    }
   // life label
    CCLabelTTF *label = [CCLabelTTF labelWithString:NSLocalizedString(@"life", @"") fontName:@"AvenirNext-Bold" fontSize:20];
    label.position = ccp(self.contentSize.width - 190, self.contentSize.height - 37);
    label.color = CCColor.orangeColor;
    [self addChild:label];
   // life sprite
    CGFloat lifeY = winSize.height - BeginTopY;
    for (int i = 0; i < 10; i++) {
        CCSprite *lifeSprite = [CCSprite spriteWithImageNamed:@"life.png"];
        lifeSprite.name = @"life";
        lifeSprite.anchorPoint = CGPointZero;
        lifeSprite.position = ccp(winSize.width - i *(lifeSprite.contentSize.width) - 25, lifeY);
        [self addChild:lifeSprite];
        [self.lifeArray addObject:lifeSprite];
    }
     self.userClickCount = 10;
    // detail for game
    CCSprite *detailSprite = [CCSprite spriteWithImageNamed:@"detail.png"];
    detailSprite.scale = winSize.width / detailSprite.contentSize.width;
    detailSprite.anchorPoint = CGPointZero;
    [self addChild:detailSprite];
    
    // add Help
    CCSpriteFrame *sf = [CCSpriteFrame frameWithImageNamed:@"p2.png"];
    CCButton *helpButton = [CCButton buttonWithTitle:nil spriteFrame:sf];
//    CCSprite *helpSprite = [CCSprite spriteWithImageNamed:@"p2.png"];
    helpButton.positionType = CCPositionTypeNormalized;
    helpButton.position = ccp(0.95, 0.98);
    [self addChild:helpButton];
}

- (void)updateLife{
    if (self.userClickCount < 0) {return;}
    for (int i = (int)self.userClickCount; i < 10; i++) {
        CCSprite *life = self.lifeArray[i];
        life.visible = NO;
    }
    
}

- (void)setUserClickCount:(NSInteger)userClickCount{
    _userClickCount = userClickCount;
    [self updateLife];
    
}

- (void)setupBg{
    // 添加背景
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CCSprite *background1 = [CCSprite spriteWithImageNamed:@"scrollBg.png"];
    ccTexParams texParams = {GL_NEAREST,GL_NEAREST,GL_CLAMP_TO_EDGE,GL_CLAMP_TO_EDGE};
    [background1.texture setTexParameters:&texParams];
    CGFloat height = background1.contentSize.height ;
    background1.scale = winSize.width / background1.contentSize.width;
    background1.anchorPoint = CGPointZero;
    background1.position = ccp(0, height);
    [self addChild:background1 z:-1];
    
    CCSprite * _background = [CCSprite spriteWithImageNamed:@"scrollBg.png"];
    _background.scale = background1.scale;
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


@end
