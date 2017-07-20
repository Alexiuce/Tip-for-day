//
//  ViewController.m
//  CallDemo
//
//  Created by alexiuce  on 2017/7/20.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "RegistController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    RegistController *regVC = [[RegistController alloc]init];
    [self presentViewController:regVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
