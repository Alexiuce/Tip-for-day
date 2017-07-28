//
//  ViewController.m
//  每日算法练习
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "OneDay.h"
#import "TwoDay.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self twoDay];
}
- (void)oneDay{
    NSArray *myArray = @[@12,@21,@13,@45,@6,@1,@2];
    [OneDay findTargetNumber:@22 sourceArray:myArray];
}

- (void)twoDay{
    
    MyListNode node1 = {9,NULL};
    MyListNode node2 = {2,&node1};
    MyListNode node3 = {1,&node2};
    
    int result = [TwoDay convertNodeToNumber:node3];
    
    NSLog(@"%zd",result);
    
    
}

@end
