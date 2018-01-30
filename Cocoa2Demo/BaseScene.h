//
//  BaseScene.h
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/30.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "SceneValueDelegate.h"


@interface BaseScene : CCScene

@property (nonatomic, weak) id <SceneValueDelegate>valueDelegate;

@property (nonatomic,assign) SceneValueStyle valueStyle;

@end
