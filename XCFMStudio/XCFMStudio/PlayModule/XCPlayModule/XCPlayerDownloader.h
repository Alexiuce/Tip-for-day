//
//  XCPlayerDownloader.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol XCDownloadingProcotol <NSObject>
/** 下载中*/
- (void)onloading;
@end



@interface XCPlayerDownloader : NSObject

@property (nonatomic, weak) id <XCDownloadingProcotol>delegate;

@property (nonatomic, assign, readonly) long long loadedSize;
@property (nonatomic, assign, readonly) long long loadingOffset;
@property (nonatomic, assign) long long totalSize;
@property (nonatomic, strong, readonly) NSString *mimeType;
/**
 根据url 地址,和下载偏移值,进行分段下载
 */
- (void)download:(NSString *)url offSet:(long long)offset;

@end
