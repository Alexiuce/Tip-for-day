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

typedef void(^UpdateDownloadStateType)(DownloadState state);
typedef void(^UpdateDownloadSizeType)(long long totalSize);
typedef void(^ProgressChangedType)(float progress);
typedef void(^DownloadFinishedType)(NSString *cacheFile,NSError *error);


@interface XCHttpDownloader : NSObject

/** 根据url下载*/
- (void)download:(NSString * )url downloadState:(UpdateDownloadSizeType)downloadSize progress:(ProgressChangedType)downloadProgress finished:(DownloadFinishedType)downloadFinished;
/** 暂停当前下载*/
- (void)pauseCurrentDownloading;
/** 继续当前下载任务*/
- (void)resumeCurrentDownloading;
/** 取消当前下载*/
- (void)cancleCurrentDownload;
/** 取消并清除当前缓存文件*/
- (void)cancleAndClearCache;

/** 下载状态 */
@property (nonatomic, assign, readonly) DownloadState state;

/** 更新状态block*/
@property (nonatomic, copy) UpdateDownloadStateType updateDownloadState;
/** 更新下载大小 */
@property (nonatomic, copy) UpdateDownloadSizeType updateDownloadSize;
/** 下载进度改变block */
@property (nonatomic, copy) ProgressChangedType progressChanged;
@property (nonatomic, assign, readonly) float progerss;

/** 下载完成block*/
@property (nonatomic, copy) DownloadFinishedType downloadFinished;


@end
