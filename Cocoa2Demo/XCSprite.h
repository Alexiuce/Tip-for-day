//
//  XCSprite.h
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/13.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCSprite.h"


typedef NS_ENUM(NSUInteger,XCSpriteType) {
    XCSpritePlayer,
    XCSpriteEnemy
};


@interface XCSprite : CCSprite

@property (nonatomic, assign) CGPoint moveSpeed;   // 移动速度

+ (instancetype)spritWithType:(XCSpriteType)type;

@end
