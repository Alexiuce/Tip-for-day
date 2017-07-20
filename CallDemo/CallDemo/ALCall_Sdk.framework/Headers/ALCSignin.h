//
//  ALCSignin.h
//  ALCall_Sdk
//
//  Created by phq on 16/11/15.
//  Copyright © 2016年 phq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCSignin : NSObject

/**
 注册用户接口 - 注册的用户手机号用于初始化通话实现

 @param tel 手机号码
 @param code 国家号码
 @param resultBlock 请求结果回调block
 */
+ (void)signinWithTel:(NSString *)tel
          countryCode:(NSString *)code
             complete:(void (^)(NSDictionary *value, NSString *error))resultBlock;


/**
 认证号码 - 获取验证码接口

 @param tel 通过“注册用户接口”获取的mobile值（国家代码+手机号码）
 @param resultBlock 请求结果回调block
 */
+ (void)getMobileCodeWithTel:(NSString *)tel
                    complete:(void (^)(NSDictionary *value, NSString *error))resultBlock;


/**
 认证号码 - 验证手机验证码

 @param tel 通过“注册用户接口”获取的mobile值（国家代码+手机号码）
 @param code 通过调用“获取验证码接口”获取的语音验证码
 @param resultBlock 请求结果回调block
 */
+ (void)verifyMobileWithTel:(NSString *)tel
                       code:(NSString *)code
                   complete:(void (^)(NSDictionary *value, NSString *error))resultBlock;


/**
 查询用户信息

 @param tel 通过“注册用户接口”获取的mobile值（国家代码+手机号码）
 @param resultBlock 请求结果回调block
 */
+ (void)getUserInfoWithTel:(NSString *)tel
                  complete:(void (^)(NSDictionary *value, NSString *error))resultBlock;


/**
 查询用户通话详单

 @param tel 通过“注册用户接口”获取的mobile值（国家代码+手机号码）
 @param yMonth 通话详单年月，如：2016-01
 @param pageCount 当前页数，默认为1（15条/页）
 @param resultBlock 请求结果回调block
 */
+ (void)getUserCDRWithTel:(NSString *)tel
                   yMonth:(NSString *)yMonth
                pageCount:(NSUInteger)pageCount
                 complete:(void (^)(NSDictionary *value, NSString *error))resultBlock;

@end
