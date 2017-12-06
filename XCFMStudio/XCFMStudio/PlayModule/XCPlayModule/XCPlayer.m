//
//  XCPlayer.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCPlayer.h"
#import <AVFoundation/AVFoundation.h>


@interface XCPlayer()

@property (nonatomic, strong) AVPlayer *player;

@end



@implementation XCPlayer

- (void)playWithUrl:(NSString *)url{
    // 1. 请求资源
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:url]];
    
    // 2. 组织资源
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    // 2.1 使用kvo,监听资源组织的状态(当资源准备好后,再进行播放)
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 3. 播放资源
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    [self.player play];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if (status == AVPlayerItemStatusReadyToPlay) {  // 资源准备好了..
            
        }
        
    }
}


#pragma mark - interface method

- (void)pause{
    [self.player pause];
}
- (void)resume{
    [self.player play];
}
- (void)stop{
    [self.player pause];
    self.player = nil;
}

- (void)seekWithTimeOffset:(NSTimeInterval)offset{
    // 播放总时长
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalSecond = CMTimeGetSeconds(totalTime);
    // 当前播放时长
    CMTime currentTime = self.player.currentTime;
    NSTimeInterval playingTime = CMTimeGetSeconds(currentTime);
    playingTime += offset;
    
    [self seekWithProgress:playingTime / totalSecond];
    
}
// 快进
- (void)seekWithProgress:(float)progress{
    if (progress < 0 || progress > 1) {return;}
    // CMTime : 影片时间(以帧率为计时单位)
    // 1. 影片时间 -> 秒
    // 获取播放总时长
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalSecond = CMTimeGetSeconds(totalTime);
    // 当前播放时长
    // CMTime currentTime = self.player.currentTime;
    NSTimeInterval playTime = totalSecond * progress;
    CMTime gotoTime = CMTimeMake(playTime, NSEC_PER_SEC);
    
    [self.player seekToTime:gotoTime completionHandler:^(BOOL finished) {
        if (finished) {  // 播放加载的资源
            
        }else{ // 取消加载的资源
            
        }
    }];
}

- (void)setPlayRate:(float)rate{
    [self.player setRate:rate];
}
- (void)setPlayMute:(BOOL)mute{
    self.player.muted = mute;
}
- (void)setVolume:(float)volume{
    if (volume < 0 || volume > 1) {return;}
    self.player.muted = volume == 0;
    self.player.volume = volume;
}

@end
