//
//  XCPlayerDownloadDelegate.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayerDownloadDelegate.h"


@interface XCPlayerDownloadDelegate()

@end

@implementation XCPlayerDownloadDelegate


/**
 * 请求资源方法,由这里抛数据给外界播放使用,通常在这个方法里进行缓存的逻辑处理
 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    return YES;
}
/**
 * 取消请求调用这个方法.
 */
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
}

@end
