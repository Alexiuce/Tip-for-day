//
//  ViewController.m
//  每日算法练习
//
//  Created by alexiuce  on 2017/7/26.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "OneDay.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *myArray = @[@12,@21,@13,@45,@6,@1,@2];
    [OneDay findTargetNumber:@22 sourceArray:myArray];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
