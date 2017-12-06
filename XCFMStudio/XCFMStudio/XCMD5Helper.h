//
//  XCMD5Helper.h
//  XCFMStudio
//
//  Created by caijinzhu on 2017/12/6.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCMD5Helper : NSObject

/** NSString的md5 */
+ (NSString *)stringMD5:(NSString *)text;
/** NSDate的md5*/
+ (NSString *)dataMD5:(NSData *)data;

@end
