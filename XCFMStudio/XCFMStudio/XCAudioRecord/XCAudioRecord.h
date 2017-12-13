//
//  XCAudioRecord.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/11.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCAudioRecord : NSObject

- (void)startRecordInPath:(NSString *)recordSavePath;
- (void)stopRecord;
- (void)pauseRecord;
- (void)deleteRecord;

- (void)restartRecord;


@end
