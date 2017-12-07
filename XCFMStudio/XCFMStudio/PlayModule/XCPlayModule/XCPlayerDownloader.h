//
//  XCPlayerDownloader.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/7.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCPlayerDownloader : NSObject

@property (nonatomic, assign, readonly) long long loadedSize;    
/**
 根据url 地址,和下载偏移值,进行分段下载
 */
- (void)download:(NSString *)url offSet:(long long)offset;

@end
