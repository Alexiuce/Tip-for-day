//
//  SqliteModel.m
//  XCFMStudio
//
//  Created by Alexcai on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "SqliteModel.h"
#import <objc/runtime.h>

@implementation SqliteModel

+ (NSString *)tableName:(Class)cls{
    return NSStringFromClass(cls);
}


+ (NSDictionary *)classIvrNameAndType:(Class)cls{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount = 0;
    Ivar *varList = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar v = varList[i];
        // 获取成员名称
        NSString *name = [NSString stringWithUTF8String:ivar_getName(v)];
        if ([name hasPrefix:@"_"]) {
            name = [name substringFromIndex:1];
        }
        // 获取成员类型
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(v)];
        type = [type stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        dict[name] = type;
    }
    return [dict copy];
}

+ (NSDictionary *)objectCTypeToSqliteType:(Class)cls{
    NSDictionary *oc_dict = [self classIvrNameAndType:cls];
    NSDictionary *map = [self ocMapSqliteDict];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [oc_dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
    if (map[obj] != nil) {
        result[key] = map[obj];
        }
    }];
    return result;
}

+ (NSString *)columNameAndType:(Class)cls{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSDictionary *dict = [self objectCTypeToSqliteType:cls];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        [resultArray addObject:[NSString stringWithFormat:@"%@ %@",key,obj]];
    }];
    return [resultArray componentsJoinedByString:@","];
}


+ (NSDictionary *)ocMapSqliteDict{
    return @{@"d" : @"real",
             @"i" : @"integer",
             @"q" : @"integer",
             @"Q" : @"integer",
             @"B" : @"integer",
             @"NSData" : @"blob",
             @"NSArray" : @"text",
             @"NSDictionary" : @"text",
             @"NSString" : @"text",
             @"NSMutableArray" : @"text",
             @"NSMutableDictionary":@"text"
             };
}

@end
