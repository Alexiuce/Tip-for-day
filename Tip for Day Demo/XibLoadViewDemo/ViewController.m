//
//  ViewController.m
//  XibLoadViewDemo
//
//  Created by Alexcai on 2017/6/24.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

#import "ViewController.h"
#import "MyXibView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyXibView *myView = [MyXibView xibView];
    myView.frame = NSMakeRect(10, 10, 100, 100);
    [self.view addSubview:myView];
    // Do any additional setup after loading the view.
}





@end
