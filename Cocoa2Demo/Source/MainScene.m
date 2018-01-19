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
    
    
    NSString *hello = [NSString localizedStringWithFormat:NSLocalizedString(@"Hello World", @"问候语")];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:hello fontName:@"ArialMT" fontSize:16];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5, 0.25};
    [self addChild:label];
    self.label = label;
   
   
    CCSpriteFrame *sf = [CCSpriteFrame frameWithImageNamed:@"fire.png"];
    CCButton *btn = [CCButton buttonWithTitle:@"" spriteFrame:sf];
    btn.boundingBox
    btn.positionType = CCPositionTypeNormalized;
    btn.position = ccp(0.3, 0.5);
    [self addChild:btn];

    
    CCLabelBMFont *bflabel = [CCLabelBMFont labelWithString:@"Http BMFont" fntFile:@"bitmapFontTest.fnt"];
    bflabel.positionType = CCPositionTypeNormalized;
    bflabel.position = ccp(0.5, 0.5);
    [self addChild:bflabel];

    
    CGPoint targetPoint = ccp(bflabel.position.x, bflabel.position.y + 0.3 );
  

    CCActionMoveTo *actionLabelMove = [CCActionMoveTo actionWithDuration:3 position:targetPoint];

    CCActionEaseOut *easeLabel = [CCActionEaseOut actionWithAction:actionLabelMove];

    [bflabel runAction:easeLabel];
    
    
    // done
    return self;
}

- (void)testBreak{
    for (int i = 0; i < 5; i++) {
        switch (i) {
            case 0:
                XCLog(@"i is one");
                break;
            case 1:
                XCLog(@"i is two");
                break;
            case 2:
                XCLog(@"i is three");
                break;
            case 3:
                XCLog(@"i is four");
                break;
            case 4:
                XCLog(@"i is five");
                
                break;
            default:
                break;
        }
    }
    
}


- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    static int i = 0;
     XCLog(@"label texture%@",self.label.texture);
    self.label.string = [NSString stringWithFormat:@"Good %zd",i++];
}
@end
