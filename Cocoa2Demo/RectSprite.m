//
//  RectSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/16.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "RectSprite.h"


@interface RectSprite()

@end


@implementation RectSprite



+ (instancetype)spriteWithColor:(CCColor *)color size:(CGSize)size{
    return [[self alloc] initWithColor:color size:size];
}


- (instancetype)initWithColor:(CCColor *)color size:(CGSize)size{
    self = [super init];
    [self setUserInteractionEnabled:YES];
    NSAssert(self, @"init failure");
    self.color = color;
    self.contentSize = size;
    [self setup];
    return self;
}

- (void)setup{
    CCDrawNode *bg = [CCDrawNode node];
    CGPoint rect[4];
    rect[0] = CGPointZero;
    rect[1] = ccp(0, self.contentSize.height);
    rect[2] = ccp(self.contentSize.height, self.contentSize.width);
    rect[3] = ccp(self.contentSize.width, 0);

    [bg drawPolyWithVerts:rect count:4 fillColor:self.color borderWidth:0 borderColor:CCColor.redColor];
    [self addChild:bg];
}


- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    XCLog(@"beeeee....");
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    XCLog(@"sprite====");
}

@end
