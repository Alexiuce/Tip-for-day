//
//  ViewController.m
//  PresentControllerDemo
//
//  Created by alexiuce  on 2017/8/7.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "TwoController.h"
#import "PresentAnimator.h"


@interface ViewController ()



@end

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


     TwoController *twoVc  = [[TwoController alloc]init];
    
   /**  1. 以 sheet 方式(共享当前的window),弹出后,当前windows close 不可用 */
//    [self presentViewControllerAsSheet:twoVc];
    
    /** 2. 以modal 窗口的方式弹出新控制器(有独立的window)  */
//    [self presentViewControllerAsModalWindow:twoVc];
    
    /** 3. 自定义方式弹控制器, 需提供一个实现<NSViewControllerPresentationAnimator> 协议的类,完成动画 */
    
    PresentAnimator *modalAnimator = [[PresentAnimator alloc]init];
    [self presentViewController:twoVc animator:modalAnimator];
    
    /** 4. 以 popover 方式弹出新的控制器
     asPopoverRelativeToRect : 弹出popover时,附着的矩形区域(即被popover剪头指向的那一块矩形区域)
     ofView: 矩形区域( asPopoverRelativeToRect)所属的view
     preferredEdge:矩形区域( asPopoverRelativeToRect)的参考边界:
                     NSRectEdgeMinX:(在矩形区域左边显示popover)
                     NSRectEdgeMaxX:(在矩形区域右边显示popover)
                     NSRectEdgeMinY:(在矩形区域顶部显示popover)
                     NSRectEdgeMaxY:(在矩形区域底部显示popover)
     behavior : popover的行为模式
                NSPopoverBehaviorApplicationDefined :点击popover 视图以外的操作不会自动关闭(不支持ESC键盘关闭)
                NSPopoverBehaviorTransient :  点击popover 视图以外的操作会自动关闭(支持ESC键盘关闭)
                NSPopoverBehaviorSemitransient: : 点击popover 视图以外的操作不会自动关闭(支持ESC键盘关闭)
     
     */
    
//    [self presentViewController:twoVc asPopoverRelativeToRect:sender.frame ofView:self.view preferredEdge:NSRectEdgeMinY behavior:NSPopoverBehaviorApplicationDefined];
    
}

@end
