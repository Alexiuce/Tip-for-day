//
//  ViewController.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/15.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController ()<ADBannerViewDelegate>

@property (nonatomic, strong) ADBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[ADBannerView alloc]init];
    self.bannerView.delegate = self;
   
    [self.view addSubview:self.bannerView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - ADBannerViewDelegate
- (void)bannerViewWillLoadAd:(ADBannerView *)banner{
    XCLog(@"%s",__func__);
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
     XCLog(@"%s",__func__);
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
     XCLog(@"%s",__func__);
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner{
     XCLog(@"%s",__func__);
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
     XCLog(@"%s",__func__);
    XCLog(@"%@",error.localizedDescription);
    
}


@end
