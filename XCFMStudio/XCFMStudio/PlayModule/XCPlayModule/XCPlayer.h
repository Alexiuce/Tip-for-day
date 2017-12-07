//
//  XCPlayer.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,XCPlayState) {
    XCPlayStateUnknow,
    XCPlayStateLoading,
    XCPlayStatePlaying,
    XCPlayStateStop,
    XCPlayStatePause,
    XCPlayStateFailure
};

@interface XCPlayer : NSObject

#pragma mark 提供接口

+ (instancetype)sharePlayer;
- (void)playWithUrl:(NSString *)url;

- (void)pause;
- (void)resume;
- (void)stop;

- (void)seekWithTimeOffset:(NSTimeInterval)offset;
- (void)seekWithProgress:(float)progress;

#pragma mark 数据提供
@property (nonatomic, assign) BOOL mute;
@property (nonatomic, assign) float volume;
@property (nonatomic, assign) float rate;
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, assign, readonly) float progress;
@property (nonatomic, copy, readonly) NSString * playURL;
@property (nonatomic, assign) float loadingCacheProgress;   // 加载缓存的进度
@property (nonatomic, assign) XCPlayState state;

@end
