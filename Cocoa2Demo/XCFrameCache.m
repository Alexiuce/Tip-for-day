//
//  XCFrameCache.m
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/13.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "XCFrameCache.h"

static CCSpriteFrameCache *frameCache = nil;


@implementation XCFrameCache

+ (CCSpriteFrameCache *)frameCacheForGameArts{
    if (frameCache == nil) {
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"gameArts.plist"];
    }
    return frameCache;
}


@end
