//
//  ScoreSprite.h
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/31.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface ScoreSprite : CCSprite

+ (instancetype)scoreWith:(int)total head:(int)headCount body:(int)bodyCount;

@end
