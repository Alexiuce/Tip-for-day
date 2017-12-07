//
//  XCPlayer.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayer.h"
#import <AVFoundation/AVFoundation.h>


static XCPlayer *_instance;

@interface XCPlayer()<NSCopying,NSMutableCopying>

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) BOOL isUserPause;

@end

@implementation XCPlayer

+ (instancetype)sharePlayer{
    if (_instance == nil) {
        _instance = [[self alloc]init];
    }
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

- (void)playWithUrl:(NSString *)url{
    
    AVURLAsset *as = (AVURLAsset *)self.player.currentItem.asset;
    if ([url isEqualToString:as.URL.absoluteString]) {
        [self resume];
        return;
    }
    _playURL = url;
    // 1. 请求资源
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:url]];
    
    if (self.player.currentItem) {
        [self removeObser];
    }
    // 2. 组织资源
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    // 2.1 使用kvo,监听资源组织的状态(当资源准备好后,再进行播放)
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    // 3. 播放资源
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playInterupted) name:AVPlayerItemPlaybackStalledNotification object:nil];

}

#pragma mark - Notificaiton method
- (void)playFinished{   // 播放完成
    self.state = XCPlayStateStop;
}
- (void)playInterupted{  // 播放被打断(来电话/资源不足)
    
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if (status == AVPlayerItemStatusReadyToPlay) {  // 资源准备好了..
            [self resume];
        }
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        BOOL isKeepUp = [change[NSKeyValueChangeNewKey] boolValue];
        if (isKeepUp ) {  // 资源足够播放,并且用户没有手动暂停播放
            if (_isUserPause == NO) {
                [self resume];
            }else{
                self.state = XCPlayStatePause;
            }
        }else{      // 资源还不足,正在加载
            self.state = XCPlayStateLoading;
        }
    }
}

- (void)removeObser{
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}

#pragma mark - interface method

- (void)pause{
    [self.player pause];
    _isUserPause = YES;
    if (self.player) {
        self.state = XCPlayStatePause;
    }
}
- (void)resume{
    [self.player play];
    _isUserPause = NO;
    if (self.player && self.player.currentItem.playbackLikelyToKeepUp) {
        self.state = XCPlayStatePlaying;
    }
}
- (void)stop{
    [self.player pause];
    if (self.player) {self.state = XCPlayStateStop;}
    self.player = nil;
}

- (void)seekWithTimeOffset:(NSTimeInterval)offset{

    // 当前播放时长
    NSTimeInterval playingTime = offset + self.currentTime;
    [self seekWithProgress:playingTime / self.totalTime];
}
// 快进
- (void)seekWithProgress:(float)progress{
    if (progress < 0 || progress > 1) {return;}
    // CMTime : 影片时间(以帧率为计时单位)
    // 1. 影片时间 -> 秒
    // 当前播放时长
    // CMTime currentTime = self.player.currentTime;
    NSTimeInterval playTime = self.totalTime * progress;
    CMTime gotoTime = CMTimeMake(playTime, 1);
    
    [self.player seekToTime:gotoTime completionHandler:^(BOOL finished) {
        if (finished) {  // 播放加载的资源
            
        }else{ // 取消加载的资源
            
        }
    }];
}
- (void)setRate:(float)rate{
    [self.player setRate:rate];
}
- (float)rate{
    return self.player.rate;
}
- (void)setMute:(BOOL)mute{
    self.player.muted = mute;
}
- (BOOL)mute{
    return self.player.muted;
}

- (void)setVolume:(float)volume{
    if (volume < 0 || volume > 1) {return;}
    self.player.muted = volume == 0;
    self.player.volume = volume;
}
- (float)volume{
    return self.player.volume;
}

#pragma mark - 数据
- (NSTimeInterval)totalTime{
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval time = CMTimeGetSeconds(totalTime);
    if (isnan(time)) {return 0;}
    return time;
}
- (NSTimeInterval)currentTime{
    CMTime currentTime = self.player.currentTime;
   NSTimeInterval time = CMTimeGetSeconds(currentTime);
    if (isnan(time)) {return 0;}
    return time;
}

- (float)progress{
    if (self.totalTime == 0) {return 0;}
    return self.currentTime / self.totalTime;
}
- (float)loadingCacheProgress{
    if (self.totalTime == 0) {return 0;}
    CMTimeRange loadedRange = [self.player.currentItem.loadedTimeRanges.lastObject CMTimeRangeValue];
    CMTime loadedTime = CMTimeAdd(loadedRange.start, loadedRange.duration);
    NSTimeInterval loadedSecond = CMTimeGetSeconds(loadedTime);
    return loadedSecond / self.totalTime;
}
@end
