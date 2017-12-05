//
//  XCHttpDownloader.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/4.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCHttpDownloader.h"
#import "XCFileManagerTool.h"


#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define TEMP_PATH NSTemporaryDirectory()


@interface XCHttpDownloader()<NSURLSessionDataDelegate>

@property (nonatomic, assign) long long tempSzie;
@property (nonatomic, assign) long long totalSzie;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSString *cacheFile;
@property (nonatomic, copy) NSString *tempFile;

@property (nonatomic, strong) NSOutputStream * outputStream;

@property (nonatomic, weak) NSURLSessionDataTask *dataTask;


@end


@implementation XCHttpDownloader

- (void)download:(NSString *)url{
    
    NSString *filename = url.lastPathComponent;
    
    // 1. 如果正在下载 return
    
    // 如果已经下载  文件存放在cache目录
    _cacheFile = [CACHE_PATH stringByAppendingPathComponent:filename];
    if ([XCFileManagerTool fileIsExist:_cacheFile]) {  // 文件已经下载,告知外界
        
        return;
    }
    
    // 如果没有下载  文件存放在temp目录
    _tempFile = [TEMP_PATH stringByAppendingPathComponent:filename];
    // 获取临时下载文件的大小: 若文件不存在,返回大小为0
    _tempSzie = [XCFileManagerTool fileSize:_tempFile];
    
    [self download:url offset:_tempSzie];
   
}

- (void)pauseCurrentDownloading{
    [self.dataTask suspend];
}

- (void)cancleCurrentDownload{
    [self.session invalidateAndCancel];
    _session = nil;
}

- (void)cancleAndClearCache{
    [self cancleCurrentDownload];
    [XCFileManagerTool deleteFile:self.tempFile];
    
}
#pragma mark - NSURLSession Delegate method
// 第一次接收到服务器响应的时候调用(通常是获取http header)
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    // 获取下载文件的总长度
    long long totalLength = [response.allHeaderFields[@"Content-Length"] longLongValue];
    
    NSString *contentRangeText = response.allHeaderFields[@"Content-Range"];
    // 如果有Content-Range 字段,则取Content-Range值为准.
    if (contentRangeText.length) {
        totalLength = [[contentRangeText componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    // 比对 文件大小
    if (_tempSzie == totalLength) {  // 下载完成,将文件移入cache目录,并取消本次请求
        [XCFileManagerTool moveFile:self.tempFile to:self.cacheFile];
        completionHandler(NSURLSessionResponseCancel);
        return;
    }
    
    if (_tempSzie > totalLength) {   // 移除缓存文件,从0 开始重新下载,并取消本次请求
        [XCFileManagerTool deleteFile:self.tempFile];
        [self download:response.URL.absoluteString];
        completionHandler(NSURLSessionResponseCancel);
        return;
    }
    // 继续本次请求,接收数据
    _outputStream = [NSOutputStream outputStreamToFileAtPath:self.tempFile append:YES];
    [_outputStream open];
    completionHandler(NSURLSessionResponseAllow);
    
}
// 接收服务器的数据时,调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    [_outputStream write:data.bytes maxLength:data.length];
    
}
// 请求完成时调用 (注意:请求完成 != 请求成功)
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    [_outputStream close];
    
    if (error == nil) {  // 下载文件正确
        [XCFileManagerTool moveFile:self.tempFile to:self.cacheFile];
    }
    
    NSLog(@"download finished:%@",self.cacheFile);
    
}

#pragma mark - custom method
- (void)download:(NSString *)url offset:(long long)offset{
    
    NSURL *d_url = [NSURL URLWithString:url];
    // 每次请求,忽略本地缓存url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:d_url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offset] forHTTPHeaderField:@"Range"];
    self.dataTask = [self.session dataTaskWithRequest:request];
    
    [self.dataTask resume];
    
}

#pragma mark - lazy methon
- (NSURLSession *)session{
    if (_session == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    return _session;
}



@end
