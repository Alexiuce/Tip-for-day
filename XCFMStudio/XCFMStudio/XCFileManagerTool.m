//
//  XCFileManagerTool.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/4.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCFileManagerTool.h"

@implementation XCFileManagerTool

+ (BOOL)fileIsExist:(NSString *)filePath{
    if (filePath == NULL || filePath.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (long long)fileSize:(NSString *)filename{
    
    if ([self fileIsExist:filename]) {   // 若文件不存在,直接返回
        return 0;
    }
    
    NSError *error = NULL;
    
    NSDictionary *fileAttributeDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filename error:&error];
    
    if (error != NULL) {   
        return 0;
    }
    return [fileAttributeDict[NSFileSize] longLongValue];
}

+ (BOOL)moveFile:(NSString *)fromPath to:(NSString *)toPath{
   return [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}

+ (BOOL)deleteFile:(NSString *)filename{
   
   return [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
}

@end
