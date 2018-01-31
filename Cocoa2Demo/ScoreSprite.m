//
//  ScoreSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/31.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "ScoreSprite.h"

@interface ScoreSprite()

@property (nonatomic, assign) int total;
@property (nonatomic, assign) int headCount;
@property (nonatomic, assign) int bodyCount;
@end


@implementation ScoreSprite

+ (instancetype)scoreWith:(int)total head:(int)headCount body:(int)bodyCount{
    return [[self alloc] initWithTotal:total head:headCount body:bodyCount];
}

- (id)initWithTotal:(int)total head:(int)headCount body:(int)bodyCount{
    if (self = [super initWithImageNamed:@"scoreSprite.png"]) {
        self.total = total;
        self.headCount = headCount;
        self.bodyCount = bodyCount;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // add title
    CCLabelTTF * title = [CCLabelTTF labelWithString:@"Score" fontName:@"AmericanTypewriter-Bold" fontSize:25];
    title.position = ccp(self.contentSize.width * 0.5, self.contentSize.height - title.contentSize.height);
    title.colorRGBA = CCColor.redColor;
    [self addChild:title];
    // add total
    NSString *ts = [NSString stringWithFormat:@"Total is  %zd",self.total];
    CCLabelTTF * total = [CCLabelTTF labelWithString:ts fontName:@"ChalkboardSE-Bold" fontSize:20];
    total.anchorPoint = ccp(0.5, 1);
    total.position = ccp(title.position.x, title.position.y - title.contentSize.height * 0.5 );
    total.color = CCColor.lightGrayColor;
    [self addChild:total];
    
    NSString *hs = [NSString stringWithFormat:@" %zd Found",self.headCount];
    CCLabelTTF * head = [CCLabelTTF labelWithString:hs fontName:@"ChalkboardSE-Bold" fontSize:20];
    head.anchorPoint = ccp(0, 0.5);
    head.position = ccp(60, self.contentSize.height - 164 + 71 );
    head.color = CCColor.blueColor;
    [self addChild:head];
    
    NSString *bs = [NSString stringWithFormat:@" %zd Found",self.bodyCount];
    CCLabelTTF * body = [CCLabelTTF labelWithString:bs fontName:@"ChalkboardSE-Bold" fontSize:20];
    body.anchorPoint = ccp(0, 0.5);
    body.position = ccp(60, self.contentSize.height - 198 + 66);
    body.color = CCColor.blueColor;
    [self addChild:body];
    

}


@end
