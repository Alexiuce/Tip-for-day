//
//  SqliteHelper.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteHelper : NSObject


/** 执行sql语句 */
+ (BOOL)execSql:(NSString *)sql onUser:(NSString *)userId;
/**
 # 查询sql语句
 - NSArray : 字典组成的数组
 */
+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql onUser:(NSString *)userId;

@end
