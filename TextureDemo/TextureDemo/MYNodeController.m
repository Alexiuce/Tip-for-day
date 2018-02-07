//
//  MYNodeController.m
//  TextureDemo
//
//  Created by caijinzhu on 2018/2/7.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "MYNodeController.h"
#import "MYFirstNode.h"

@interface MYNodeController ()
    
@property (nonatomic, strong) ASDisplayNode *firstNode;



    
@end

@implementation MYNodeController

    
- (instancetype)init{
    _firstNode = [[ASDisplayNode alloc]init];
    _firstNode.backgroundColor = UIColor.lightGrayColor;
    self = [super initWithNode:_firstNode];
    
    
    return self;
}
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self init];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    ASDisplayNode *redNode = [[ASDisplayNode alloc]init];
    redNode.frame = CGRectMake(10, 64, 50, 50);
    redNode.backgroundColor = UIColor.redColor;
    [_firstNode addSubnode:redNode];
    
    MYFirstNode *myNode = [[MYFirstNode alloc]init];
    myNode.frame = CGRectMake(100, 100, 200, 400);
    myNode.backgroundColor = UIColor.grayColor;
    [_firstNode addSubnode:myNode];
    
    // Do any additional setup after loading the view.
}



@end
