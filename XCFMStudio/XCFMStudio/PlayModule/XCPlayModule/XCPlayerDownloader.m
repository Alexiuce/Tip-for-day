//
//  XCPlayerDownloader.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayerDownloader.h"
#import "XCPlayerFile.h"

@interface XCPlayerDownloader()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSOutputStream *outputStream;



@property (nonatomic, copy) NSString * url;

@end



@implementation XCPlayerDownloader

- (void)download:(NSString *)url offSet:(long long)offset{
    _loadingOffset = offset;
    self.url = url;
    [self cancleAndClear];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offset] forHTTPHeaderField:@"Range"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
    
    [dataTask resume];
    
}



- (void)cancleAndClear{
    [self.session invalidateAndCancel];
    self.session = nil;
    // 清空temp文件
    [XCPlayerFile clearTempFile:self.url];
    // 重置数据
    _loadedSize = 0;
}

#pragma  mark - NSURLSessionDataDelegate method

/** 接收到服务器响应*/
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    _mimeType = response.MIMEType; 
    // 获取下载文件的总长度
    self.totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    
    NSString *contentRangeText = response.allHeaderFields[@"Content-Range"];
    // 如果有Content-Range 字段,则取Content-Range值为准.
    if (contentRangeText.length) {
        self.totalSize = [[contentRangeText componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:[XCPlayerFile tempFileWithURL:self.url] append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
}

/** 接收请求数据*/
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nonnull NSData *)data{
    _loadedSize += data.length;
    [self.outputStream write:data.bytes maxLength:data.length];
    // 将下载的数据通知外界
    if ([self.delegate respondsToSelector:@selector(onloading)]) {
        [self.delegate onloading];
    }
}

/** 请求完成*/
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error == nil) {
        // 判断temp文件是否等于总大小(如果是,则将文件从temp 移动到cache中)
        if ([XCPlayerFile tempFileSize:self.url] == self.totalSize) {
            [XCPlayerFile moveTempFileToCache:self.url];
        }
        
    }
    // 关闭输出
    [self.outputStream close];
}


#pragma  mark - lazy methon
- (NSURLSession *)session{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}



@end
