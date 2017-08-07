//
//  ViewController.m
//  PresentControllerDemo
//
//  Created by alexiuce  on 2017/8/7.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "TwoController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)presentController:(NSButton *)sender {

   /** 已 sheet 方式(共享当前的window),弹出后,当前windows close 不可用 */
//    [self presentViewControllerAsSheet:[[TwoController alloc]init]];
    /** 以modal 窗口的方式弹出新控制器(有独立的window)  */
//    [self presentViewControllerAsModalWindow: [[TwoController alloc]init]];
    
    /** 自定义方式弹控制器, 需提供一个实现<NSViewControllerPresentationAnimator> 协议的类,完成动画 */
//    [self presentViewController:[[TwoController alloc]init] animator:<#(nonnull id<NSViewControllerPresentationAnimator>)#>];
    
    /** 以 popover 方式弹出新的控制器 
     asPopoverRelativeToRect : 弹出popover时,附着的矩形区域(即被popover剪头指向的那一块矩形区域)
     ofView: 矩形区域( asPopoverRelativeToRect)所属的view
     preferredEdge:矩形区域( asPopoverRelativeToRect)的参考边界:
                     NSRectEdgeMinX:(在矩形区域左边显示popover)
                     NSRectEdgeMaxX:(在矩形区域右边显示popover)
                     NSRectEdgeMinY:(在矩形区域顶部显示popover)
                     NSRectEdgeMaxY:(在矩形区域底部显示popover)
     behavior : popover的行为模式
     
     */
    
    
    
    
    TwoController *twoVc  = [[TwoController alloc]init];
    [self presentViewController:twoVc asPopoverRelativeToRect:sender.frame ofView:self.view preferredEdge:NSRectEdgeMinY behavior:NSPopoverBehaviorTransient];
    
}

@end
