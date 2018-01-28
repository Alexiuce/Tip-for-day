//
//  MatrixtDelegate.h
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/28.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MatrixItemStyle) {
    MatrixItemHead,
    MatrixItemBody,
    MatrixItemEmpty
};

@class MatrixSprite;

@protocol MatrixtDelegate <NSObject>

- (void)matrixDidSelected:(MatrixSprite *)sprite itemStyle:(MatrixItemStyle)type;


@end
