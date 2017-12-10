//
//  SqliteModel.h
//  XCFMStudio
//
//  Created by Alexcai on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteModel : NSObject

/** 根据类名 转为表名*/
+ (NSString *)tableName:(Class)cls;

/** 根据类获取属性名称和类型 */
+ (NSDictionary *)classIvrNameAndType:(Class)cls;

/** oc type -> sqlit type*/
+ (NSDictionary *)objectCTypeToSqliteType:(Class)cls;

/** 生成 建表格式字符串 name type ... */
+ (NSString *)columNameAndType:(Class)cls;

@end
