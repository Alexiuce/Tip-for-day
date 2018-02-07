//
//  MYFirstNode.m
//  TextureDemo
//
//  Created by caijinzhu on 2018/2/7.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "MYFirstNode.h"


@interface MYFirstNode()


@property (nonatomic, strong) ASDisplayNode *red;
@property (nonatomic, strong) ASDisplayNode *blue;
@property (nonatomic, strong) ASDisplayNode *green;
    
@end







@implementation MYFirstNode
    
    
- (instancetype)init{
    self = [super init];
    
    _red = [ASDisplayNode new];
    _red.backgroundColor = UIColor.redColor;
    [self addSubnode:_red];
    _blue = [ASDisplayNode new];
    _blue.backgroundColor = UIColor.blueColor;
    [self addSubnode:_blue];
    _green = [ASDisplayNode new];
    _green.backgroundColor = UIColor.greenColor;
    [self addSubnode:_green];
    
    return self;
}
    
    
    
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    _red.style.preferredSize = (CGSize){40,40};
    _red.style.layoutPosition = (CGPoint){100,50};
    _blue.style.preferredSize = (CGSize){40,30};
    _blue.style.layoutPosition = (CGPoint){100,100};
    _green.style.preferredSize = (CGSize){40,20};
    _green.style.layoutPosition = (CGPoint){100,140};
  
    
    ASAbsoluteLayoutSpec *layoutSpec = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithChildren:self.subnodes];
    
    return layoutSpec;
}
    
@end
