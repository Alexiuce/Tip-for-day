//
//  XCAudioManager.m
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/13.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import "XCAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation XCAudioManager

+ (void)addAudio:(NSString *)fromPath toAudio:(NSString *)toPath outputPath:(NSString *)outputPath{
    // 1. 获取音频源
    AVURLAsset *fromAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:fromPath]];
    AVURLAsset *toAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:toPath]];
    
    // 2. 获取音频源的轨道素材
    AVAssetTrack *fromTrack = [fromAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    AVAssetTrack *toTrack = [toAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    // 3. 创建合成器,并添加可以编辑的轨道容器
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableCompositionTrack *compTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
    
    // 4. 向轨道容器中添加轨道素材
    [compTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, toAsset.duration) ofTrack:toTrack atTime:kCMTimeZero error:nil];
    [compTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, fromAsset.duration) ofTrack:fromTrack atTime:toAsset.duration error:nil];
    // 5. 导出音频
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
    exportSession.outputFileType = AVFileTypeAppleM4A;
    exportSession.outputURL = [NSURL fileURLWithPath:outputPath];
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (exportSession.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"文件导出成功");
        }
    }];
    
}

+ (void)cutAudio:(NSString *)audioPath fromTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime outputPath:(NSString *)outputPath{
    // 1. 获取音频源
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:audioPath]];
    
    // 2. 创建音频导出会话
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
    session.outputFileType = AVFileTypeAppleM4A;
    session.outputURL = [NSURL fileURLWithPath:outputPath];
    CMTime startTime = CMTimeMake(fromTime, asset.duration.timescale);
    
    CMTime endTime = CMTimeMake(toTime, asset.duration.timescale);
    // 3. 设置截取的时间区间
    session.timeRange = CMTimeRangeFromTimeToTime(startTime, endTime);
    [session exportAsynchronouslyWithCompletionHandler:^{
        if (session.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"文件导出成功");
        }
    }];
    
    
    
}

@end
