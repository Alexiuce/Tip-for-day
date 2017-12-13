//
//  XCAudioManager.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/13.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCAudioManager : NSObject


+ (void)addAudio:(NSString *)fromPath toAudio:(NSString *)toPath outputPath:(NSString *)outputPath;


+ (void)cutAudio:(NSString *)audioPath fromTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime outputPath:(NSString *)outputPath;

@end
