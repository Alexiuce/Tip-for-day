//
//  XCMD5Helper.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCMD5Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation XCMD5Helper

+ (NSString *)stringMD5:(NSString *)text{
    if (text == nil || text.length == 0) {return  nil;}
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *input = text.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char md5Char[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(input, (CC_LONG)strlen(input), md5Char);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
        [digest appendFormat:@"%02x",md5Char[i]];
    }
    return digest;
}


+ (NSString *)dataMD5:(NSData *)data{
    if (data == nil ) {return nil;}
    //需要MD5变量并且初始化
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    //开始加密(第一个参数：对md5变量地址，要为该变量指向的内存空间计算好数据，第二个参数：需要计算的源数据，第三个参数：源数据的长度)
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    unsigned char md5Char[CC_MD5_DIGEST_LENGTH];
    //将数据放入result数组
    CC_MD5_Final(md5Char, &md5);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x",md5Char[i]];
    }
    return digest;
    
}
@end
