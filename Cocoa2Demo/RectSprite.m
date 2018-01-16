//
//  RectSprite.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/16.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "RectSprite.h"


@interface RectSprite()

@property (nonatomic, strong) CCColor *color;

@end


@implementation RectSprite



+ (instancetype)spriteWithColor:(CCColor *)color size:(CGSize)size{
    return [[self alloc] initWithColor:color size:size];
}


- (instancetype)initWithColor:(CCColor *)color size:(CGSize)size{
    self = [super init];
    NSAssert(self, @"init failure");
    self.color = color;
    self.contentSize = size;
    [self setup];
    return self;
}

- (void)setup{
    CCNodeColor *bg = [CCNodeColor nodeWithColor:self.color width:self.contentSize.width height:self.contentSize.height];
    [self addChild:bg];
}

@end
