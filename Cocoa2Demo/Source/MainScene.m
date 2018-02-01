#import "MainScene.h"
#import <CCEffectNode.h>
#import <CCEffectBlur.h>
#import "XCTileMap.h"
#import "XCGameButton.h"
#import "NSString+Game.h"
#import "ScoreSprite.h"
#import "ADManager.h"



@interface MainScene()

@property (nonatomic, weak) CCLabelTTF *label;

@property (nonatomic, weak) CCTiledMap *bgMap;

@property (nonatomic, assign) SceneStyle style;



@end


@implementation MainScene

+ (instancetype)sceneWithStyle:(SceneStyle)style{
    int random = arc4random_uniform(100) % 3;
    XCLog(@"random %zd ",random);
    if (random == 0) {
         [ADManager showAD];
    }
 
    MainScene *m = [self node];
    m.style = style;
    return m;
}

- (void)onEnter{
    [super onEnter];
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
    ScoreSprite *ss = [ScoreSprite scoreWith:_total head:_headCount body:_bodyCount];
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
    
}

#pragma  mark - UI Event
- (void)clickButton{
    self.valueStyle = _style == SuccessSytle ? SceneForReloadDataAndRefresh : SceneForRefresh;
    [[CCDirector sharedDirector] popScene];
}








@end
