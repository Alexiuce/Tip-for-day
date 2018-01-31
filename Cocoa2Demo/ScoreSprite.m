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
    CCLabelTTF * title = [CCLabelTTF labelWithString:@"Score" fontName:@"AmericanTypewriter-Bold" fontSize:25];
    title.position = ccp(self.contentSize.width * 0.5, self.contentSize.height - title.contentSize.height);
    title.colorRGBA = CCColor.redColor;
    [self addChild:title];
    
    
}


@end
