#import "MainScene.h"
#import <CCEffectNode.h>
#import <CCEffectBlur.h>
#import "XCTileMap.h"
#import "XCGameButton.h"
#import "NSString+Game.h"

@interface MainScene()

@property (nonatomic, weak) CCLabelTTF *label;

@property (nonatomic, weak) CCTiledMap *bgMap;


@end

static SceneStyle _style = FailureStyle;

@implementation MainScene

+ (instancetype)sceneWithStyle:(SceneStyle)style{
    _style = style;
    return [self node];
}


- (id)init{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
//    self.userInteractionEnabled = YES;
   
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    // 1 . add background
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"gameoverBg.png"];
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(0.5, 0.5);
    [self addChild:bg];
    // 2. add title image
    
    NSString *imageName = _style == SuccessSytle ? @"youwin.png": @"gameover.png";
    
    CCSprite *headSprite = [CCSprite spriteWithImageNamed:imageName];
    headSprite.anchorPoint = ccp(0.5, 1);
    headSprite.position = ccp(winSize.width * 0.5, winSize.height - 100);
    [self addChild:headSprite];
    
   
    
    if (_style == FailureStyle) {
        CCActionRotateBy *rotateBy = [CCActionRotateBy actionWithDuration:0.15 angleX:5 angleY:0];
        CCActionRotateBy *rotateY = [CCActionRotateBy actionWithDuration:0.15 angleX:-5 angleY:0];
        CCActionSequence *as = [CCActionSequence actions:rotateY,[rotateY reverse],rotateBy,[rotateBy reverse], nil];
        CCActionRepeat *ar = [CCActionRepeat actionWithAction:as times:2];
        [headSprite runAction:ar];
        XCGameButton *backButton = [XCGameButton gameButtonWithTitle:[NSString adaptedString:@"play again"]];
        [backButton setTarget:self selector:@selector(playAgain)];
        backButton.position = ccp(0.5, 0.5);
        [self addChild:backButton];
       
    }else{
         XCGameButton *newButton = [XCGameButton gameButtonWithTitle:[NSString adaptedString:@"start new"]];
        [newButton setTarget:self selector:@selector(startNew)];
        newButton.position = ccp(0.5, 0.5);
         [self addChild:newButton];
    }
   

    
    // done
    return self;
}

#pragma  mark - UI Event
- (void)playAgain{
    self.valueStyle = SceneForRefresh;
    [self popMainScene];
}
- (void)startNew{
    self.valueStyle = SceneForReloadDataAndRefresh;
    [self popMainScene];
}


- (void)popMainScene{
    
    [[CCDirector sharedDirector] popScene];
}

@end
