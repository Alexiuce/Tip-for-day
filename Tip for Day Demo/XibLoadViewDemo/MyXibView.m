//
//  MyXibView.m
//  Tip for Day Demo
//
//  Created by Alexcai on 2017/6/24.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

#import "MyXibView.h"

@implementation MyXibView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


+ (instancetype)xibView{
    // 加载nib
    NSNib *myXib = [[NSNib alloc]initWithNibNamed:@"MyXibView" bundle:nil];
    // 创建xib视图数组(一个xib中可能有多个view)
    NSArray *xibViews;
    // 从xib中加载视图到定义的视图数组中(topLevelObjects的参数为二级指针)
    BOOL isInstant = [myXib instantiateWithOwner:self topLevelObjects:&xibViews];
    if (isInstant) {  // 加载成功
        // 遍历视图数组
        for (MyXibView *view in xibViews) {
            if (![view isKindOfClass:self]) {
                continue;
            }
            // 找到后返回视图
            return view;
        }
        
    }
    return nil;
}


@end
