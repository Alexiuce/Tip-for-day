//
//  XCHttpDownloader.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/4.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,DownloadState){
    DownloadStatePause,
    DownloadStateLoading,
    DownloadStateFinished,
    DownloadStateResume,
    DownloadStateFailure
};


@interface XCHttpDownloader : NSObject

/** 根据url下载*/
- (void)download:(NSString * )url;
/** 暂停当前下载*/
- (void)pauseCurrentDownloading;
/** 继续当前下载任务*/
- (void)resumeCurrentDownloading;
/** 取消当前下载*/
- (void)cancleCurrentDownload;
/** 取消并清除当前缓存文件*/
- (void)cancleAndClearCache;

/***/
@property (nonatomic, assign) DownloadState state;          // 下载状态

/***/


@end
