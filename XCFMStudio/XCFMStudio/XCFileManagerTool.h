//
//  XCFileManagerTool.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/4.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFileManagerTool : NSObject


/** 检测文件是否存在 */
+ (BOOL)fileIsExist:(NSString *)filePath;

/** 检测文件的大小*/
+ (long long)fileSize:(NSString *)filename;

/** 移动文件*/
+ (BOOL)moveFile:(NSString *)fromPath to:(NSString *)toPath;

/** 删除文件 */
+ (BOOL)deleteFile:(NSString *)filename;
@end
