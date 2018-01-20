#import "MainScene.h"


@interface MainScene()

@property (nonatomic, weak) CCLabelTTF *label;
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
    NSString *hello = [NSString localizedStringWithFormat:NSLocalizedString(@"Hello World", @"问候语")];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:hello fontName:@"ArialMT" fontSize:16];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5, 0.25};
    [self addChild:label];
    self.label = label;
   
   
//    CCSpriteFrame *sf = [CCSpriteFrame frameWithImageNamed:@"fire.png"];
//    [CCButton buttonWithTitle:<#(NSString *)#>];
    CCButton *btn = [CCButton buttonWithTitle:@"Restart Game" fontName:@"AvenirNext-Bold" fontSize:30];
    [btn setTarget:self selector:@selector(popMainScene)];
    btn.positionType = CCPositionTypeNormalized;
    btn.position = ccp(0.5, 0.5);
    [self addChild:btn];

    
    CCLabelBMFont *bflabel = [CCLabelBMFont labelWithString:@"Game Over" fntFile:@"bitmapFontTest.fnt"];
    bflabel.positionType = CCPositionTypeNormalized;
    bflabel.position = ccp(0.5, 0.7);
    [self addChild:bflabel];

    
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

- (void)popMainScene{
    [[CCDirector sharedDirector] popScene];
}
//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
//    static int i = 0;
//     XCLog(@"label texture%@",self.label.texture);
//    self.label.string = [NSString stringWithFormat:@"Good %zd",i++];
//}
@end
