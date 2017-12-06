//
//  XCHttpDownloadManager.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCHttpDownloader.h"


@interface XCHttpDownloadManager : NSObject
/** 单利对象*/
+ (instancetype)shareManager;

/** 下载 */
- (void)download:(NSString * )url downloadState:(UpdateDownloadSizeType)downloadSize progress:(ProgressChangedType)downloadProgress finished:(DownloadFinishedType)downloadFinished;


/** 暂停下载url */
- (void)pauseDownloading:(NSString *)url;
/** 继续下载url */
- (void)resumeDownloading:(NSString *)url;
/** 取消下载url */
- (void)cancleDownloading:(NSString *)url;

/** 全部暂停 */
- (void)pauseAll;
/** 全部恢复 */
- (void)resumeAll;

@end
