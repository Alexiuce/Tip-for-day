//
//  TwoDay.h
//  每日算法练习
//
//  Created by alexiuce  on 2017/7/27.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 给你两个非空链表，每个链表代表一个数，把这两个数加起来，返回结果。结果也是以链表的形式返回。
 
 稍微特殊一点的地方是，给的链表是按数字的每一位倒着给的，比如 123 一百二十三 给的链表是 3 -> 2 -> 1
 
 这样如果输入 (2 -> 4 -> 3) 和 (5 -> 6 -> 4) 两个链表，代表 342 和 465，加出来的结果应该是 807，返回的结果应该是 7 -> 0 -> 8

 
 */


typedef struct ListNode {
    int number;                         // 数值 0~9
    struct ListNode *nextNode;  // 下一个链接节点
}MyListNode;



@interface TwoDay : NSObject

+ (MyListNode)addListNode:(MyListNode)node1 andTwo:(MyListNode)node2;
+ (int)convertNodeToNumber:(MyListNode)node;
@end
