//
//  RectSprite.h
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/16.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface RectSprite : CCSprite

@property (nonatomic,assign) NSUInteger lineNumber;

+ (instancetype)spriteWithColor:(CCColor *)color size:(CGSize)size;

@end
