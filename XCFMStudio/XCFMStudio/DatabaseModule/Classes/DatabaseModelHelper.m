//
//  DatabaseModelHelper.m
//  XCFMStudio
//
//  Created by Alexcai on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "DatabaseModelHelper.h"
#import "SqliteModel.h"
#import "SqliteHelper.h"

@implementation DatabaseModelHelper

+ (BOOL)createTable:(Class)cls userID:(NSString *)uid{
    
    /**  获取表名*/
    NSString *tableName = [SqliteModel tableName:cls];
    
    /** 获取字段 */
    NSString *columNameType = [SqliteModel columNameAndType:cls];
    /** sql语句*/
    NSString *createTableSql = [NSString stringWithFormat:@"create table if not exists %@(id integer autoincrement primary key not null,%@)",tableName,columNameType];
    /** 执行*/
    return  [SqliteHelper execSql:createTableSql onUser:uid];
}

@end
