//
//  XCPlayerFile.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCPlayerFile : NSObject




/**
  是否有下载完成的缓存文件 : cache + 文件名称
 - url
 - return
 */
+ (BOOL)hasCacheFile:(NSString *)url;
/**
 缓存文件
 */
+ (NSString *)cacheFileWithURL:(NSString *)url;
/**
 缓存文件大小
 */
+ (long long)cacheFileSize:(NSString *)url;
/**
 临时下载文件
 */
+ (NSString *)tempFileWithURL:(NSString *)url;
/**
 临时文件大小
 */
+ (long long)tempFileSize:(NSString *)url;
/**
 是否有临时文件
 */
+ (BOOL)hasTempFile:(NSString *)url;

/**
 获取缓存文件的MIME TYPE
 */
+ (NSString *)contentType:(NSString *)url;


+ (void)moveTempFileToCache:(NSString *)url;

+ (void)clearTempFile:(NSString *)url;



@end
