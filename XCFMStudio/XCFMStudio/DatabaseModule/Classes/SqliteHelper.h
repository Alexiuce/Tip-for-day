//
//  SqliteHelper.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteHelper : NSObject


// 执行sql语句
+ (BOOL)execSql:(NSString *)sql forUser:(NSString *)userId;

@end
