//
//  NSString+Game.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/24.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "NSString+Game.h"

@implementation NSString (Game)

+ (instancetype)adaptedString:(NSString *)text{
    if (text == nil || text.length == 0) {return text;}
    return NSLocalizedString(text, text);
}

@end
