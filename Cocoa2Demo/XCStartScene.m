//
//  XCStartScene.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCStartScene.h"
#import "IADScene.h"
#import <CCParticles.h>
#import <CCTextureCache.h>
#import <CCMotionStreak.h>
#import <CCNodeTag.h>
#import <CCEffectNode.h>
#import <CCEffectBrightness.h>
#import "XCHelpScene.h"
#import "MatrixSprite.h"
#import "MatrixtDelegate.h"
#import "SceneValueDelegate.h"

#import "MainScene.h"

#import <CCPhysics.h>


static const int BackTag = 100;
static const int MatrixTag = 101;

static const CGFloat kAnimationDuration = 60.0;

static const CGFloat AirCraftTopMargin = 76;
static const CGFloat AirCraftXMargin = 64;
static const CGFloat AirCraftMidPadding = 192;





@interface XCStartScene()<MatrixtDelegate,SceneValueDelegate>

@property (nonatomic, strong) NSMutableArray *bulletArray;
@property (nonatomic, assign) int bulletCount ;
@property (nonatomic, weak) CCLabelBMFont *scoreLabel;
@property (nonatomic, weak) CCButton *startButton;
@property (nonatomic, assign) int score;



@end


@implementation XCStartScene

- (id)init{
    if (self = [super init]) {
        self.bulletCount = 10;
        self.bulletArray = [NSMutableArray arrayWithCapacity:self.bulletCount];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // 1. setup background
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"scrollImage.png"];
    bg.scaleX = winSize.width / bg.contentSize.width;
    bg.scaleY = winSize.height / bg.contentSize.height;
    bg.anchorPoint = CGPointZero;
    bg.position = CGPointZero;
    bg.tag = BackTag;
    
    MatrixSprite *maxtixSprite = [MatrixSprite matrixSpriteWithDelegate:self];
    maxtixSprite.scaleX = bg.scaleX;
    maxtixSprite.scaleY = bg.scaleY;
    maxtixSprite.anchorPoint = ccp(0, 1);
    maxtixSprite.position = ccp(1, winSize.height - 117);
    maxtixSprite.tag = MatrixTag;
    [maxtixSprite setUserInteractionEnabled:NO];
    
    // 2. add help button
    CCSpriteFrame *helpFrame = [CCSpriteFrame frameWithImageNamed:@"helpIcon.png"];
    CCButton *helpButton = [CCButton buttonWithTitle:@"" spriteFrame:helpFrame];
    [helpButton setTarget:self selector:@selector(showHelpScene)];
    helpButton.position = ccp(winSize.width - 30,winSize.height - 35);

    
    // 3. add  start button
    CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:@"startGame.png"];
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:frame];
    [startButton setTarget:self selector:@selector(startGame)];
    self.startButton = startButton;
    startButton.scaleX = 0.6;
    startButton.scaleY = 0.8;
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5, 0.15);
    
    [self addChild:bg];
    [self addChild:maxtixSprite];
    [self addChild:helpButton];
    [self addChild:startButton];
    [self showBullet];
    //  过渡动画
    CCSprite *maskLaunchSprite = [CCSprite spriteWithImageNamed:@"launchBg.png"];
    maskLaunchSprite.scaleX = winSize.width / maskLaunchSprite.contentSize.width;
    maskLaunchSprite.scaleY = winSize.height / maskLaunchSprite.contentSize.height;
    maskLaunchSprite.positionType = CCPositionTypeNormalized;
    maskLaunchSprite.position = ccp(0.5, 0.5);
    [self addChild:maskLaunchSprite];
    
    CCSprite *leftAircraft = [CCSprite spriteWithImageNamed:@"leftAircraft.png"];
   
    leftAircraft.anchorPoint = ccp(0, 1);
  
    leftAircraft.position = ccp(AirCraftXMargin,winSize.height - AirCraftTopMargin);
    [self addChild:leftAircraft];
    CCSprite *rightAircraft = [CCSprite spriteWithImageNamed:@"leftAircraft.png"];
    rightAircraft.anchorPoint = ccp(1, 1);
    rightAircraft.position = ccp(winSize.width - AirCraftXMargin, winSize.height - AirCraftTopMargin);
    [self addChild:rightAircraft];
    CCSprite *downAircraft = [CCSprite spriteWithImageNamed:@"downCraft.png"];
    downAircraft.anchorPoint = ccp(0.5, 1);
    downAircraft.position = ccp(winSize.width * 0.5, winSize.height - AirCraftMidPadding);
    [self addChild:downAircraft];
    
    CCTime duration = 2.0;
    CGPoint endPoint = ccp(0, 200);
    CCActionMoveBy *moveBy = [CCActionMoveBy actionWithDuration:duration position:endPoint];
    [leftAircraft runAction:moveBy];
    CCActionMoveBy *rmoveBy = [CCActionMoveBy actionWithDuration:duration position:endPoint];
    [rightAircraft runAction:rmoveBy];
    CGPoint dendPoint = ccp(0, 300);
    CCActionMoveBy *dmoveBy = [CCActionMoveBy actionWithDuration:duration position:dendPoint];
    [downAircraft runAction:dmoveBy];
    
    CCActionDelay *delay = [CCActionDelay actionWithDuration:duration];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:0.7];
    CCActionCallBlock *callBlock = [CCActionCallBlock actionWithBlock:^{
        [maskLaunchSprite removeFromParent];
        [leftAircraft removeFromParent];
        [rightAircraft removeFromParent];
        [downAircraft removeFromParent];
//        [self physicTest];
    } ];
    
    CCActionSequence *as = [CCActionSequence actions:delay,fadeOut,callBlock, nil];
//    CCActionHide *hiden = [CCActionHide action];
    [maskLaunchSprite runAction:as];
    
    
   
    
}


- (void)startGame{
    // 1. start background animation
    [self startBackgroundAnimation];
    // 2. show bullet and animtion
    CCActionMoveBy *moveBy = [CCActionMoveBy actionWithDuration:0.25 position:ccp(0, -0.2)];
    [self.startButton runAction:moveBy];
    [self getChildByTag:MatrixTag].userInteractionEnabled = YES;
   
}


- (void)startBackgroundAnimation{
    // 添加移动动画
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"scrollImage.png"];
    bg.scaleX = winSize.width / bg.contentSize.width;
    bg.scaleY = winSize.height / bg.contentSize.height;
    bg.anchorPoint = CGPointZero;
    bg.position = ccp(0, winSize.height);
    [self addChild:bg z:-1];
    
     CGFloat height = bg.boundingBox.size.height ;
    {
        CCAction *action = [CCActionMoveBy actionWithDuration:kAnimationDuration position:ccp(0, -height)];
        CCAction *action1 = [CCActionMoveTo actionWithDuration:0 position:ccp(0, height)];
        CCActionInterval *seqActon = [CCActionSequence actionWithArray:@[action,action,action1]];
        CCActionRepeatForever *foreverAction = [CCActionRepeatForever actionWithAction: seqActon];
        [bg runAction:foreverAction];
        
    }
    
    CCSprite *currentBackground = (CCSprite *)[self getChildByTag:BackTag];
    CCAction *action = [CCActionMoveBy actionWithDuration:kAnimationDuration position:ccp(0, -height)];
    CCAction *action1 = [CCActionMoveTo actionWithDuration:0 position:ccp(0, height)];
    CCActionSequence *seqActon = [CCActionSequence actionWithArray:@[action,action1,action]];
    CCActionRepeatForever *foreverAction = [CCActionRepeatForever actionWithAction: seqActon];
    [currentBackground runAction:foreverAction];
}

- (void)showBullet{
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CGFloat lifeY = winSize.height - 50;
    
    // add life icon
    CCSprite *lifeIcon = [CCSprite spriteWithImageNamed:@"lifeIcon.png"];
    lifeIcon.anchorPoint = CGPointZero;
    lifeIcon.position = ccp(5, lifeY);
    [self addChild:lifeIcon];
    
    // add score icon
    CGFloat sY = lifeY - 5;
    CCSprite *scoreIcon = [CCSprite spriteWithImageNamed:@"score.png"];
    scoreIcon.anchorPoint = ccp(0, 1);
    scoreIcon.position = ccp(5, sY);
    [self addChild:scoreIcon];
    // add score label
    CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"markerFelt.fnt"];
    CGFloat sx = 5 + scoreIcon.contentSize.width + 10;
    scoreLabel.anchorPoint = ccp(0, 1);
    scoreLabel.position = ccp(sx, sY - 5);
    [self addChild:scoreLabel];
    self.scoreLabel = scoreLabel;
    CGFloat bX = 5 + lifeIcon.contentSize.width + 10;
    CGFloat bY = lifeY + lifeIcon.contentSize.height * 0.5;
    for (int i = 0; i < 10; i++) {
        CCSprite *lifeSprite = [CCSprite spriteWithImageNamed:@"bullet.png"];
       

        lifeSprite.position = ccp( i *(lifeSprite.contentSize.width + 3) + bX, bY);
        [self addChild:lifeSprite];
        [self.bulletArray addObject:lifeSprite];
    }
}


//- (void)changeToGameScene{
//    CCEffectNode *efn = (CCEffectNode *)[self getChildByTag:EffectTag];
//    CCEffectBrightness *bright = (CCEffectBrightness *)efn.effect;
//    if (bright.brightness <= -1) {
//        [self unschedule:_cmd];
//        [[CCDirector sharedDirector] presentScene:[IADScene node]];
//    }else{
//        bright.brightness = MAX(-1, bright.brightness - 0.1);
//    }
//}
- (void)showHelpScene{
    [[CCDirector sharedDirector] pushScene: [XCHelpScene node]];
}

#pragma mark MatrixtDelegate
- (void)matrixDidSelected:(MatrixSprite *)sprite itemStyle:(MatrixItemStyle)type{
    if (type == MatrixItemEmpty) {
        if (self.bulletCount == 0) {
            // 显示Game over Scene
            MainScene *m = [MainScene node];
            m.valueDelegate = self;
            [[CCDirector sharedDirector] pushScene:m];
            return;
        }
        CCSprite *bullet = self.bulletArray[10 - self.bulletCount];
        CCSpriteFrame *emptyFrame = [CCSpriteFrame frameWithImageNamed:@"emptyBullet.png"];
        [bullet setSpriteFrame:emptyFrame];
        self.bulletCount--;
    }else if (type == MatrixItemHead){
        self.score++;
        self.scoreLabel.string = [NSString stringWithFormat:@"%zd",self.score];
        if (self.score == 3) {
            // 显示you win Scene
            MainScene *m = [MainScene node];
            m.valueDelegate = self;
            [[CCDirector sharedDirector] pushScene:m];
        }
    }
    XCLog(@"%zd",type);
}

#pragma  mark - SceneValueDelegate
- (void)setValueForOnEnter:(SceneValueStyle)value{
    MatrixSprite *m = (MatrixSprite *)[self getChildByTag:MatrixTag];
    switch (value) {
        case SceneForReloadDataAndRefresh:{
            XCLog(@"SceneForReloadDataAndRefresh");
            [m reloadMapDataAndRefresh];
            [self gameRestore];
            break;
        }
            
        case SceneForRefresh:{
            XCLog(@"SceneForRefresh");
            [m refresh];
            [self gameRestore];
            break;
        }
        case SceneComebackFromWin:{
            XCLog(@"SceneComebackFromWin");
            break;
        }
        case SceneComebackFromHelp: {
            
            break;
        }
    }
}
#pragma mark - privite method

- (void)gameRestore{
    // 恢复data
    self.score = 0;
    self.scoreLabel.string = @"0";
    self.bulletCount = 10;
    // 恢复bullet
    CCSpriteFrame *emptyFrame = [CCSpriteFrame frameWithImageNamed:@"bullet.png"];
    for (CCSprite *s in self.bulletArray) {
        [s setSpriteFrame:emptyFrame];
    }
}

- (void)physicTest{
    CCPhysicsNode *space = [CCPhysicsNode node];
    space.gravity = ccp(0, -200);
    space.debugDraw = YES;
    [self addChild: space];
    

    
    CCPhysicsBody *starBody = [CCPhysicsBody bodyWithCircleOfRadius:16 andCenter:ccp(16,16)];
    starBody.elasticity = 3;
    CCSprite *starSprite = [CCSprite spriteWithImageNamed:@"starIcon.png"];
    starSprite.position = ccp(150, 500);
    starSprite.physicsBody = starBody;
    [space addChild:starSprite];
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    NSMutableArray *shapes = [NSMutableArray array];
    
    CCPhysicsShape *bottomGroundShape = [CCPhysicsShape pillShapeFrom:CGPointZero to:ccp(winSize.width, 0) cornerRadius:4];
    
    [shapes addObject:bottomGroundShape];
    CCPhysicsBody *ground = [CCPhysicsBody bodyWithShapes:shapes];
    ground.type = CCPhysicsBodyTypeStatic;
    
    CCNode *bottomNode = [CCNode node];

    bottomNode.physicsBody = ground;
    [space addChild:bottomNode];
}


@end
