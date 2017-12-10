//
//  DatabaseModelHelper.h
//  XCFMStudio
//
//  Created by Alexcai on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseModelHelper : NSObject

+ (BOOL)createTable:(Class)cls userID:(NSString *)uid;

@end
