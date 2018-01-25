//
//  IADScene.h
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/15.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCScene.h"

typedef NS_ENUM(NSUInteger,FromSceneStyle) {
    FromStartScene,
    FromHelpScene,
    FromNewScene,
    FromAgainScene
};


@interface IADScene : CCScene



@property (nonatomic, assign) FromSceneStyle fromType;

@end
