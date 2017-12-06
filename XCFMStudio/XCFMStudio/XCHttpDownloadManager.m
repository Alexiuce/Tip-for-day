//
//  XCHttpDownloadManager.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCHttpDownloadManager.h"
#import "XCMD5Helper.h"


@interface XCHttpDownloadManager()<NSCopying,NSMutableCopying>


@property (nonatomic, strong) NSMutableDictionary *downloaderDict;            // key : url(md5)   value : downloader


@end



static XCHttpDownloadManager *_instance;
@implementation XCHttpDownloadManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}

- (void)download:(NSString *)url downloadState:(UpdateDownloadSizeType)downloadSize progress:(ProgressChangedType)downloadProgress finished:(DownloadFinishedType)downloadFinished{
    // 1. 先从字典中根据url的md5key获取下载器
    NSString *key = [XCMD5Helper stringMD5:url];
    XCHttpDownloader *downloader = self.downloaderDict[key];
    // 2. 如果没有下载器,创建并添加到字典中
    if (downloader == nil) {
        downloader = [[XCHttpDownloader alloc]init];
        self.downloaderDict[key] = downloader;
    }
    __weak typeof(self) weakSelf = self;
    [downloader download:url downloadState:downloadSize progress:downloadProgress finished:^(NSString *cacheFile, NSError *error) {
        if (error == nil) {  // 下载完成,移除下载器
            [weakSelf.downloaderDict removeObjectForKey:key];
        }
        downloadFinished(cacheFile,error);
    }];
}

- (void)pauseDownloading:(NSString *)url{
    NSString *key = [XCMD5Helper stringMD5:url];
    XCHttpDownloader *downloader = self.downloaderDict[key];
    [downloader pauseCurrentDownloading];
}

- (void)resumeDownloading:(NSString *)url{
    NSString *key = [XCMD5Helper stringMD5:url];
    XCHttpDownloader *downloader = self.downloaderDict[key];
    [downloader resumeCurrentDownloading];
}

- (void)cancleDownloading:(NSString *)url{
    NSString *key = [XCMD5Helper stringMD5:url];
    XCHttpDownloader *downloader = self.downloaderDict[key];
    [downloader cancleCurrentDownload];
}

- (void)pauseAll{
    [self.downloaderDict.allValues makeObjectsPerformSelector:@selector(pauseCurrentDownloading)];
}
-(void)resumeAll{
    [self.downloaderDict.allValues makeObjectsPerformSelector:@selector(resumeCurrentDownloading)];
}


#pragma mark - lazy method
- (NSMutableDictionary *)downloaderDict{
    if (_downloaderDict == nil) {
        _downloaderDict = [NSMutableDictionary dictionary];
    }
    return _downloaderDict;
}

@end
