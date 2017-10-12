//
//  NSString+Extension.h
//  FTSaleWorkspace
//
//  Created by alexiuce  on 2017/9/27.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/** 生成时间字符串 */
+ (NSString *)generatorTimeString;

/** 录音文件名 */
+ (NSString *)recordFileString;

/** 获取当前月份 : 2017-10 */
+ (NSString *)getCurrentMonth;


/** jsonStr to NSString*/
- (NSDictionary *)jsonDict;

/** 加密 */
- (NSData*)cryptToData;

-(instancetype)custom_Decrypt;

/** base64字符串 */
- (NSString *)base64String;

/** base64 Decode  */

- (NSString *)base64DecodeString;

@end
