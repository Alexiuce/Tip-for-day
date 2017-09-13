//
//  TwoController.m
//  PresentControllerDemo
//
//  Created by alexiuce  on 2017/8/7.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "TwoController.h"

@interface TwoController ()

@end

@implementation TwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.backgroundColor = [NSColor orangeColor].CGColor;
    // Do view setup here.

}

- (IBAction)dismiss:(NSButton *)sender {
    [self dismissController:self];

}
@end
