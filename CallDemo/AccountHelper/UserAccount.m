//
//  UserAccount.m
//  CallDemo
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "UserAccount.h"
#import <MJExtension.h>

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"helperAlc.ua"]

@implementation UserAccount

// 解档和归档
MJExtensionCodingImplementation

// 创建帐号
+ (instancetype)userAccountWithDictionary:(NSDictionary *)dict{
    UserAccount *account =  [self mj_objectWithKeyValues:dict];
    
    account.isMobileAuthed = [dict[@"is_authed"] integerValue] == 1;  // 0 : 否  1 : 是
    account.isValid = [dict[@"status"] integerValue] == 2;   // 1 无效 2 有效
    switch ([dict[@"tc_status"] integerValue ]) {
        case 1:
            account.displayStyle = OnlyDomestic;
            break;
        case 2:
            account.displayStyle = OnlyForeign;
            break;
        case 3:
            account.displayStyle = AllDisplay;
            break;
        case 4:
            account.displayStyle = NoneDisplay;
            break;
    }
    return  account;
}
// 读取帐号
+ (instancetype)readUserAccount{

    return  [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
}

// 保存帐号
- (void)saveUserAccount{
    [NSKeyedArchiver archiveRootObject:self toFile:FilePath];
}

@end
