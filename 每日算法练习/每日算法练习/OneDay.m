//
//  OneDay.m
//  每日算法练习
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "OneDay.h"

@implementation OneDay
/**
 给一个数组,每一位是一个整数.再给一个整数作为“目标”.数组中会有两个数的和,恰好为这个“目标”.找到这两个数,并返回它们的下标.(可以假定给出的输入只有一个解,而且一个数不能用两次)
 */
+ (void)findTargetNumber:(NSNumber *)targetNumber sourceArray:(NSArray <NSNumber *>*)numbersArray{
    // 方法1
    NSUInteger allCount = numbersArray.count;
    for (int i = 0; i < allCount ; i ++) {
        int subNumber =  targetNumber.intValue - numbersArray[i].intValue;
        for (int j = i + 1; j < allCount; j ++) {
            if (numbersArray[j].intValue == subNumber) {
                NSLog(@"find the two number %d = %d , %d =%d", i, numbersArray[i].intValue, j,numbersArray[j].intValue );
            }
        }
    }
    return;
    // 方法2
    
    
}
@end
