//
//  MYNodeController.m
//  TextureDemo
//
//  Created by caijinzhu on 2018/2/7.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "MYNodeController.h"

@interface MYNodeController ()
    
@property (nonatomic, strong) ASDisplayNode *firstNode;

    
    
@end

@implementation MYNodeController

    
- (instancetype)init{
    _firstNode = [[ASDisplayNode alloc]init];
    _firstNode.backgroundColor = UIColor.redColor;
    self = [super initWithNode:_firstNode];
    
    
    return self;
}
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self init];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}




@end
