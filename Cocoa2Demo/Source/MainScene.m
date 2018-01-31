#import "MainScene.h"
#import <CCEffectNode.h>
#import <CCEffectBlur.h>
#import "XCTileMap.h"
#import "XCGameButton.h"
#import "NSString+Game.h"
#import "ScoreSprite.h"

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

    NSAssert(self, @"Whoops");
//    self.userInteractionEnabled = YES;
   
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    // 1 . add background
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"gameoverBg.png"];
    bg.scaleX = winSize.width / bg.contentSize.width;
    bg.scaleY = winSize.height / bg.contentSize.height;
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(0.5, 0.5);
    [self addChild:bg];
    // 2. add title image
    
    NSString *imageName = _style == SuccessSytle ? @"youwin.png": @"gameover.png";
    
    CCSprite *headSprite = [CCSprite spriteWithImageNamed:imageName];
    headSprite.anchorPoint = ccp(0.5, 1);
    headSprite.position = ccp(winSize.width * 0.5, winSize.height - 64);
    [self addChild:headSprite];
    

    // add scroe sprite
    ScoreSprite *ss = [ScoreSprite scoreWith:20 head:12 body:12];
    ss.position = ccp(self.contentSize.width * 0.5, self.contentSize.height * 0.5 + 20);
    [self addChild:ss];
   
    NSString *btnName = _style == SuccessSytle ? @"start new" : @"play again";
    XCGameButton *backButton = [XCGameButton gameButtonWithTitle:[NSString adaptedString:btnName]];
    if (_style == FailureStyle) {
        CCActionRotateBy *rotateBy = [CCActionRotateBy actionWithDuration:0.15 angleX:5 angleY:0];
        CCActionRotateBy *rotateY = [CCActionRotateBy actionWithDuration:0.15 angleX:-5 angleY:0];
        CCActionSequence *as = [CCActionSequence actions:rotateY,[rotateY reverse],rotateBy,[rotateBy reverse], nil];
        CCActionRepeat *ar = [CCActionRepeat actionWithAction:as times:2];
        [headSprite runAction:ar];
    }
    [backButton setTarget:self selector:@selector(clickButton)];
    backButton.anchorPoint = ccp(0.5, 1);
    backButton.position = ccp(ss.position.x, ss.position.y - ss.contentSize.height * 0.5 - 15 );
    [self addChild:backButton];
    
    // done
    return self;
}

#pragma  mark - UI Event
- (void)clickButton{
    self.valueStyle = _style == SuccessSytle ? SceneForReloadDataAndRefresh : SceneForRefresh;
    [[CCDirector sharedDirector] popScene];
}


@end
