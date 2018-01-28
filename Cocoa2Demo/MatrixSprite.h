//
//  MatrixSprite.h
//  Cocoa2Demo iOS
//
//  Created by Alexcai on 2018/1/27.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "MatrixtDelegate.h"




@interface MatrixSprite : CCSprite

+ (instancetype)matrixSpriteWithDelegate:(id <MatrixtDelegate>)delegate;

@end
