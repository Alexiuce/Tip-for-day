//
//  SqliteHelper.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "SqliteHelper.h"
#import "sqlite3.h"

#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject



@implementation SqliteHelper

+ (BOOL)execSql:(NSString *)sql forUser:(NSString *)userId{
    
    
    NSString *dbName = [NSString stringWithFormat:@"%@.db",userId?:@"common"];
    NSString *dbPath = [CACHE_PATH stringByAppendingPathComponent:dbName];
    
    // 1. 创建&打开数据库
    sqlite3 *ppDb = nil;
    if (sqlite3_open(dbPath.UTF8String, &ppDb) != SQLITE_OK) {
        // 创建&打开数据失败
        NSLog(@"创建&打开数据失败");
        return NO;
    }
    
    // 2. 执行sql
    BOOL execResult =  sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    // 3. 关闭数据库
    sqlite3_close(ppDb);
    
    return execResult;
}





@end
