//
//  NSString+Extension.m
//  FTSaleWorkspace
//
//  Created by alexiuce  on 2017/9/27.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/** 生成时间字符串 */
+ (NSString *)generatorTimeString{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYYMMddHHmmss";
    return  [formatter stringFromDate:date];
}

+ (NSString *)recordFileString{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH.mm.ss";
    return  [formatter stringFromDate:date];
}

/** Json字符串转 Dictionary */
- (NSDictionary *)jsonDict{
    NSData *jsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingMutableLeaves error:&error];
    NSAssert(error == nil, @"error format json");
    return dict;
}

+ (NSString *)getCurrentMonth{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM";
    return  [formatter stringFromDate:date];
}


/**
 * 加密
 */

-(instancetype)custom_Decrypt{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]==0) return nil;
    uint8_t *input = (uint8_t *)[data bytes];
    NSUInteger length = [data length];
    char _key = '~';
    for (NSUInteger i = 0; i < length; i++) {
        input[i] = (Byte)input[i]^_key;
    }
    
    //    NSString *str = [NSString stringWithFormat:@"%s",input];
    NSString *str = [[NSString alloc] initWithBytes:input length:data.length encoding:NSUTF8StringEncoding];
    if(str == nil){
        str = [NSString stringWithFormat:@"%s",input];
    }
    return str;
}


-(NSData*)cryptToData{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]==0) return nil;
    uint8_t *input = (uint8_t *)[data bytes];
    NSUInteger length = [data length];
    char _key = '~';
    for (NSUInteger i = 0; i < length; i++) {
        input[i] = (Byte)input[i]^_key;
    }
    
    return [[NSData alloc] initWithBytes:input length:data.length];
}
/** base64 字符串 */
- (NSString *)base64String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/** base64 Decode  */

- (NSString *)base64DecodeString{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
