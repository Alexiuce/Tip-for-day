//
//  XCPlayerFile.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayerFile.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define TEMP_PATH NSTemporaryDirectory()



@implementation XCPlayerFile
/**
 下载完成的文件: cache + 文件名称
 */
+ (NSString *)cacheFileWithURL:(NSString *)url{
    return [CACHE_PATH stringByAppendingPathComponent:url.lastPathComponent];
}
/**
 是否存在缓存文件
 */ 
+ (BOOL)hasCacheFile:(NSString *)url{
    
    NSString *filename = [self cacheFileWithURL:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:filename];
}
+ (long long)cacheFileSize:(NSString *)url{
    if (![self hasCacheFile:url]) {return 0;}
    // 文件路径
    NSString *filename = [self cacheFileWithURL:url];
    // 获取文件属性信息
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filename error:nil];
    return [fileInfo[NSFileSize] longLongValue];
}


+ (BOOL)hasTempFile:(NSString *)url{
    NSString *file = [self tempFileWithURL:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:file];
}
+ (NSString *)tempFileWithURL:(NSString *)url{
    return [TEMP_PATH stringByAppendingPathComponent:url.lastPathComponent];
}
+ (long long)tempFileSize:(NSString *)url{
    if (![self hasTempFile:url]) {return 0;}
    // 文件路径
    NSString *filename = [self tempFileWithURL:url];
    // 获取文件属性信息
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filename error:nil];
    return [fileInfo[NSFileSize] longLongValue];
}

+ (NSString *)contentType:(NSString *)url{
    NSString *file = [self cacheFileWithURL:url];
    NSString *fileExtension = file.pathExtension;
    CFStringRef contentTypeRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef )fileExtension, NULL);
    NSString *contentType = CFBridgingRelease(contentTypeRef);
    return contentType;
}

+ (void)moveTempFileToCache:(NSString *)url{
    
    [[NSFileManager defaultManager]moveItemAtPath:[self tempFileWithURL:url] toPath:[self cacheFileWithURL:url] error:nil];
}

+ (void)clearTempFile:(NSString *)url{
    [[NSFileManager defaultManager] removeItemAtPath:[self tempFileWithURL:url] error:nil];
}

@end
