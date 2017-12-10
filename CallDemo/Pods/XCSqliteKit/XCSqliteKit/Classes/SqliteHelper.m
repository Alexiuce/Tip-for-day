//
//  SqliteHelper.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "SqliteHelper.h"
#import "sqlite3.h"

//#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

#define CACHE_PATH @"/Users/caijinzhu/Desktop"



sqlite3 *ppDb = nil;

@implementation SqliteHelper

+ (BOOL)execSql:(NSString *)sql onUser:(NSString *)userId{
    
    // 1. 创建&打开数据库
    if (![self openDB:userId]) {return NO;}
    // 2. 执行sql
    BOOL execResult =  sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    // 3. 关闭数据库
    [self closeDB];
    
    return execResult;
}


+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql onUser:(NSString *)userId{
    // 创建&打开db
    [self openDB:userId];
    // 准备
    /**
     sqlite3_prepare_v2(ppDb, sql.UTF8String, -1, &ppStmt, nil)
     参数1: 已打开的数据库
     参数2: sql语句
     参数3: 取参数2的语句的长度, -1 表示自动计算(以\0为结束)
     参数4: 准备好的sqlite语句
     参数5: 通过参数3截取后的剩余部分
     */
    sqlite3_stmt *ppStmt = nil;
    if (sqlite3_prepare_v2(ppDb, sql.UTF8String, -1, &ppStmt, nil) != SQLITE_OK) {
        return nil;  // 准备失败,直接返回
    }
    NSMutableArray *rowsArray = [NSMutableArray array];
    // 执行
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
        int total = sqlite3_column_count(ppStmt);  // 所有列数
        // 一条记录 -> 字典
        NSMutableDictionary *rowDict = [NSMutableDictionary dictionary];
        for (int i = 0; i < total; i ++) {
            const char *colNameC = sqlite3_column_name(ppStmt, i);
            NSString *colName = [NSString stringWithUTF8String:colNameC];
            int colType = sqlite3_column_type(ppStmt, i);
            id value = nil;
            switch (colType) {
                case SQLITE_INTEGER:
                    value = @(sqlite3_column_int(ppStmt, i));
                    break;
                case SQLITE_FLOAT:
                    value = @(sqlite3_column_double(ppStmt, i));
                    break;
                case SQLITE_BLOB:
                    value = CFBridgingRelease(sqlite3_column_blob(ppStmt, i));
                    break;
                case SQLITE_NULL:
                    value = @"";
                    break;
                case SQLITE3_TEXT:
                    value = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(ppStmt, i)];
                    break;
            }
            rowDict[colName] = value;
        }
        // 添加到数组
        [rowsArray addObject:rowDict];
    }
    // 释放资源
    sqlite3_finalize(ppStmt);
    // 关闭db
    [self closeDB];
    return [rowsArray copy];
}


+ (BOOL)openDB:(NSString *)uid{
    NSString *dbName = [NSString stringWithFormat:@"%@.db",uid?:@"common"];
    NSString *dbPath = [CACHE_PATH stringByAppendingPathComponent:dbName];
    return  sqlite3_open(dbPath.UTF8String, &ppDb) == SQLITE_OK;
}

+ (void)closeDB{
    sqlite3_close(ppDb);
}
@end
