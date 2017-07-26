//
//  UserAccount.h
//  CallDemo
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DisplayNumberType) {
    OnlyDomestic,      // 国内显示
    OnlyForeign,        // 国外显示
    AllDisplay,           // 国内国外都显示
    NoneDisplay        // 不显示
};



@interface UserAccount : NSObject

@property (nonatomic, copy) NSString *gcode;   // 国家代码
@property (nonatomic, copy) NSString *mobile;   // 电话号码（包含国家代码）
@property (nonatomic, assign) BOOL isValid;   // 用户状态是否有效
@property (nonatomic, assign) DisplayNumberType displayStyle;   // 去电号码显示状态
@property (nonatomic, assign)BOOL isMobileAuthed;   // 用户是否为手机认证


/** 创建帐号 */
+ (instancetype)userAccountWithDictionary:(NSDictionary *)dict;
/** 读取帐号 */
+ (instancetype)readUserAccount;
/** 保存帐号 */
- (void)saveUserAccount;


@end
