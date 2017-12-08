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


@interface XCPlayerDownloadDelegate()<XCDownloadingProcotol>

@property (nonatomic, strong) XCPlayerDownloader *downloader;

@property (nonatomic, strong) NSMutableArray *loadingRreques;    // 记录需要处理的请求
@property (nonatomic, strong) NSMutableArray *deleteRequests;    // 记录需要移除的请求

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
    // 记录请求
    [self.loadingRreques addObject:loadingRequest];
    // 2. 判断当前是否正在下载,如果没有, 下载return
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    if (requestOffset != loadingRequest.dataRequest.currentOffset) {
        requestOffset = loadingRequest.dataRequest.currentOffset;
    }
    if (self.downloader.loadedSize == 0) {
        [self.downloader download:loadingRequest.request.URL.absoluteString offSet:requestOffset];
        return YES;
    }
    
    // 3. 当前正在下载,检测是否需要重新下载, 如果需要,重新下载并return:
    // 3.1 请求资源节点小于 当前加载节点
    // 3.2 请求资源节点大于当前加载范围
    if (requestOffset < self.downloader.loadingOffset || requestOffset > self.downloader.loadingOffset + self.downloader.loadedSize + 100) {
        [self.downloader download:loadingRequest.request.URL.absoluteString offSet:requestOffset];
        return YES;
    }
    
    // 4. 处理所有请求,(要不断处理下载的请求)
    [self handleAllLoadingRequests];
    
    return YES;
}
/**
 * 取消请求调用这个方法.
 */
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    [self.loadingRreques removeObject:loadingRequest];
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
    long long offset = request.dataRequest.requestedOffset;
    if (offset != request.dataRequest.currentOffset) {
        offset = request.dataRequest.currentOffset;
    }
    NSInteger length = request.dataRequest.requestedLength;
    NSData *subData = [fileData subdataWithRange:NSMakeRange(offset, length)];
    [request.dataRequest respondWithData:subData];
    // 3. 结束请求
    [request finishLoading];
}

#pragma mark - XCDownloadProtocol method
- (void)onloading{
    [self handleAllLoadingRequests];
}

// 处理所有请求方法
- (void)handleAllLoadingRequests{
    for (AVAssetResourceLoadingRequest *loadingRequest in self.loadingRreques) {
        NSString *url = loadingRequest.request.URL.absoluteString;
        
        // 1. 处理头信息
        loadingRequest.contentInformationRequest.contentLength = self.downloader.totalSize;
        loadingRequest.contentInformationRequest.contentType = self.downloader.mimeType;
        loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
        // 2. 处理数据
        NSData *data = [NSData dataWithContentsOfFile:[XCPlayerFile tempFileWithURL:url] options:NSDataReadingMappedIfSafe error:nil];
        
        if (data == nil) {  // 如果数据被移动到cache时,从cache获取数据
            data = [NSData dataWithContentsOfFile:[XCPlayerFile cacheFileWithURL:url] options:NSDataReadingMappedIfSafe error:nil];
        }
        
        long long requestOffset = loadingRequest.dataRequest.requestedOffset;
        long long currentOffset = loadingRequest.dataRequest.currentOffset;
        if (requestOffset != currentOffset) {
            requestOffset = currentOffset;
        }
        
        long long requestLength = loadingRequest.dataRequest.requestedLength;
        
        long long responseOffset = requestOffset - self.downloader.loadingOffset;
        long long responseLength = MIN(self.downloader.loadingOffset + self.downloader.loadedSize - requestOffset, requestLength) ;
        
        NSData *subData = [data subdataWithRange:NSMakeRange(responseOffset, responseLength)];
        [loadingRequest.dataRequest respondWithData:subData];
        // 3. 结束请求(必须完成请求区间后才能结束)
        if (requestLength == responseLength) {
            [loadingRequest finishLoading];
            // 添加到移除数组
            [self.deleteRequests addObject:loadingRequest];
        }
    }
    // 移除请求
    [self.loadingRreques removeObjectsInArray:self.deleteRequests];
}
#pragma mark - lazy method
- (XCPlayerDownloader *)downloader{
    if (_downloader == nil) {
        _downloader = [[XCPlayerDownloader alloc]init];
        _downloader.delegate = self;
    }
    return _downloader;
}

- (NSMutableArray *)loadingRreques{
    if (_loadingRreques == nil) {
        _loadingRreques = [NSMutableArray array];
        
    }
    return _loadingRreques;
}
- (NSMutableArray *)deleteRequests{
    if (_deleteRequests == nil) {
        _deleteRequests = [NSMutableArray array];
    }
    return _deleteRequests;
}
@end
