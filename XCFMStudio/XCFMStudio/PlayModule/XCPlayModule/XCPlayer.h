//
//  XCPlayer.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCPlayer : NSObject

- (void)playWithUrl:(NSString *)url;

- (void)pause;
- (void)resume;
- (void)stop;

- (void)seekWithTimeOffset:(NSTimeInterval)offset;
- (void)seekWithProgress:(float)progress;

- (void)setPlayRate:(float)rate;
- (void)setPlayMute:(BOOL)mute;
- (void)setVolume:(float)volume;


@end
