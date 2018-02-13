//
//  SceneValueDelegate.h
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/30.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,SceneValueStyle) {
    SceneComebackFromHelp,
    SceneComebackFromWin,
    SceneForRefresh,
    SceneForReloadDataAndRefresh,
};



@protocol SceneValueDelegate <NSObject>

- (void)setValueForOnEnter:(SceneValueStyle)value;


@end
