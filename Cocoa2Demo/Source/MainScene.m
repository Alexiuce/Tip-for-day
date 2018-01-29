#import "MainScene.h"
#import <CCEffectNode.h>
#import <CCEffectBlur.h>
#import "XCTileMap.h"
#import "XCGameButton.h"

@interface MainScene()

@property (nonatomic, weak) CCLabelTTF *label;

@property (nonatomic, weak) CCTiledMap *bgMap;

@end


@implementation MainScene

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
    self.userInteractionEnabled = YES;
    // Background
//    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"ic_launcher.png"];
//    sprite.position = ccp(0.5, 0.5);
//    sprite.positionType = CCPositionTypeNormalized;
//    [self addChild:sprite];
    
    // The standard Hello World text
    
    self.color = CCColor.lightGrayColor;
//    NSString *hello = [NSString localizedStringWithFormat:NSLocalizedString(@"Hello World", @"问候语")];
//
//    CCLabelTTF *label = [CCLabelTTF labelWithString:hello fontName:@"ArialMT" fontSize:16];
//    label.positionType = CCPositionTypeNormalized;
//    label.position = (CGPoint){0.5, 0.25};
//    [self addChild:label];
//    self.label = label;

//    XCTileMap *bg = [XCTileMap tiledMapWithFile:@"gridMap.tmx"];
//    bg.scale = [CCDirector sharedDirector].viewSize.width / bg.contentSize.width;
//    bg.positionType = CCPositionTypeNormalized;
//    bg.anchorPoint = ccp(0.5, 0.5);
//    bg.position = ccp(0.5, 0.5);
//    [self addChild:bg];
//    _bgMap = bg;
//
   
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    // 1 . add background
    CCSprite *bg = [CCSprite spriteWithImageNamed:@"gameoverBg.png"];
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(0.5, 0.5);
    [self addChild:bg];
    // 2. add title image
    CCSprite *gameOver = [CCSprite spriteWithImageNamed:@"gameover.png"];
    gameOver.anchorPoint = ccp(0.5, 1);
    gameOver.position = ccp(winSize.width * 0.5, winSize.height - 100);
    [self addChild:gameOver];
    

    
    CCActionRotateBy *rotateBy = [CCActionRotateBy actionWithDuration:0.15 angleX:5 angleY:0];
    CCActionRotateBy *rotateY = [CCActionRotateBy actionWithDuration:0.15 angleX:-5 angleY:0];

    CCActionSequence *as = [CCActionSequence actions:rotateY,[rotateY reverse],rotateBy,[rotateBy reverse], nil];
    CCActionRepeat *ar = [CCActionRepeat actionWithAction:as times:2];
    [gameOver runAction:ar];
    
    
    XCGameButton *backButton = [XCGameButton gameButtonWithTitle:@"play again"];

    backButton.position = ccp(0.5, 0.5);
    [self addChild:backButton];
    
    XCGameButton *newButton = [XCGameButton gameButtonWithTitle:@"start new"];
    newButton.position = ccp(0.5, 0.4);
    [self addChild:newButton];
    
//    self.title = @"Demo";
//    CCSpriteFrame *sf = [CCSpriteFrame frameWithImageNamed:@"fire.png"];
//    [CCButton buttonWithTitle:<#(NSString *)#>];
  
//    CGPoint targetPoint = ccp(bflabel.position.x, bflabel.position.y + 0.3 );
//
//
//    CCActionMoveTo *actionLabelMove = [CCActionMoveTo actionWithDuration:3 position:targetPoint];
//
//    CCActionEaseOut *easeLabel = [CCActionEaseOut actionWithAction:actionLabelMove];
//
//    [bflabel runAction:easeLabel];
    
    
    // done
    return self;
}

- (void)setTitle:(NSString *)title{
//    _title = title ;
//    CCLabelBMFont *bflabel = [CCLabelBMFont labelWithString:self.title fntFile:@"bitmapFontTest.fnt"];
//    bflabel.positionType = CCPositionTypeNormalized;
//    bflabel.position = ccp(0.5, 0.7);
//    [self addChild:bflabel];
    
//    CCEffectNode *en = [CCEffectNode effectNodeWithWidth:300 height:300];
//    en.position = ccp(170, 400);
//    en.effect = [CCEffectBlur effectWithBlurRadius:5 ];
//
//    [en addChild:bflabel];
//
//    [self addChild:en];
    
//    NSString *text = @"Restart Game";
//    if ([title containsString:@"win"]) {
//        text = @"Continue More";
//    }
    
//    CCButton *btn = [CCButton buttonWithTitle:text fontName:@"AvenirNext-Bold" fontSize:30];
//    [btn setTarget:self selector:@selector(popMainScene)];
//    btn.positionType = CCPositionTypeNormalized;
//    btn.position = ccp(0.5, 0.5);
//    [self addChild:btn];
//
    
//    CCButton *backBtn = [CCButton buttonWithTitle:@"Go back"];
//
//
//    CCLayoutBox *box = [CCLayoutBox node];
//    box.spacing = 10;
//    box.direction = CCLayoutBoxDirectionVertical;
//    box.position = ccp(10, 300);
//    [box addChild:btn];
//    [box addChild:backBtn];
//
//    [self addChild:box];
    
}

- (void)popMainScene{
    [[CCDirector sharedDirector] popScene];
}

@end
