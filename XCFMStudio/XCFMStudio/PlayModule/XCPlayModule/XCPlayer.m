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

@end
