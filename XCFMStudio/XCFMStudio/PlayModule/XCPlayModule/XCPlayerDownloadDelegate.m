//
//  XCPlayerDownloadDelegate.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayerDownloadDelegate.h"
#import "XCPlayerFile.h"
#import "XCPlayerDownloader.h"


@interface XCPlayerDownloadDelegate()

@property (nonatomic, strong) XCPlayerDownloader *downloader;

@end

@implementation XCPlayerDownloadDelegate


/**
 * 请求资源方法,由这里抛数据给外界播放使用,通常在这个方法里进行缓存的逻辑处理
 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    // 1. 先检测本地是否有缓存,如果有,直接根据缓存向外界响应数据(3个步骤)
    if ([XCPlayerFile hasCacheFile:loadingRequest.request.URL.absoluteString]) {
        [self checkLocalCacheWithLoadingReqeust:loadingRequest];
        return YES;
    }
    // 2. 判断当前是否正在下载,如果没有, 下载return
    if (self.downloader.loadedSize == 0) {
        [self.downloader download:loadingRequest.request.URL.absoluteString offSet:loadingRequest.dataRequest.requestedOffset];
        return YES;
    }
    
    // 3. 当前正在下载,检测是否需要重新下载, 如果需要,重新下载并return
    
    // 4. 处理所有请求,(要不断处理下载的请求)
    
    return YES;
}
/**
 * 取消请求调用这个方法.
 */
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
}

/** 检查本地缓存,如果有, 使用缓存数据*/
- (void)checkLocalCacheWithLoadingReqeust:(AVAssetResourceLoadingRequest *)request{
    NSString *url = request.request.URL.absoluteString;
    // 获取缓存文件大小
    long long fileSize = [XCPlayerFile cacheFileSize:url];
    // 获取文件类型
    NSString *contentType = [XCPlayerFile contentType:url];
    // 1. 处理头信息
    request.contentInformationRequest.contentLength = fileSize;
    request.contentInformationRequest.contentType = contentType;
    request.contentInformationRequest.byteRangeAccessSupported = YES;
    // 2. 处理数据
    NSData *fileData = [NSData dataWithContentsOfFile:[XCPlayerFile cacheFileWithURL:url] options:NSDataReadingMappedIfSafe error:nil];
    long long offset = request.dataRequest.currentOffset;
    NSInteger length = request.dataRequest.requestedLength;
    NSData *subData = [fileData subdataWithRange:NSMakeRange(offset, length)];
    [request.dataRequest respondWithData:subData];
    // 3. 结束请求
    [request finishLoading];
}


#pragma mark - lazy method
- (XCPlayerDownloader *)downloader{
    if (_downloader == nil) {
        _downloader = [[XCPlayerDownloader alloc]init];
    }
    return _downloader;
}

@end
