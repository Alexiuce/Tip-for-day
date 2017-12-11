//
//  XCAudioRecord.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/11.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCAudioRecord.h"
#import <AVFoundation/AVFoundation.h>



@interface XCAudioRecord()
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end


@implementation XCAudioRecord


- (AVAudioRecorder *)recorder{
    if(_recorder == nil){
        // 1. 设置录音会话
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        // 2. 设置录音保持路径
        NSURL *saveUrl = [NSURL URLWithString:@""];
        // 3. 配置录音参数
        NSMutableDictionary *audioConfiger = [NSMutableDictionary dictionary];
        // 3.1 编码格式
        audioConfiger[AVFormatIDKey] = [NSNumber numberWithInt:kAudioFormatMPEG4AAC];
        // 3.2 采样率
        audioConfiger[AVSampleRateKey] = [NSNumber numberWithFloat:11025.0];
        // 3.3 通道数
        audioConfiger[AVNumberOfChannelsKey] = [NSNumber numberWithInt:2];
        // 3.4 采样质量
        audioConfiger[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityMin];
        // 4. 创建录音实例
        _recorder = [[AVAudioRecorder alloc]initWithURL:saveUrl settings:audioConfiger error:nil];
    }
    return _recorder;
}

@end
