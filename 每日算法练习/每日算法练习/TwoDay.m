//
//  TwoDay.m
//  每日算法练习
//
//  Created by alexiuce  on 2017/7/27.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "TwoDay.h"

static int deepIndex = 0;


@implementation TwoDay

+ (MyListNode)addListNode:(MyListNode)node1 andTwo:(MyListNode)node2{
    MyListNode node3 = {0,NULL};  // 结构体初始化
    
    
    return node3;
}


+ (int)convertNodeToNumber:(MyListNode)node{
    int result = node.number;
    if (node.nextNode) {
        deepIndex++;
        result += [self convertNodeToNumber:*node.nextNode] * pow(10, deepIndex);
    }
    return result;
}


@end
