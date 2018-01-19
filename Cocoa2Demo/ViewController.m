//
//  ViewController.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/1/15.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "ViewController.h"

@import GoogleMobileAds;

@interface ViewController ()<GADInterstitialDelegate>

@property (nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterstitial];
   
}



#pragma mark - GADInterstitialDelegate


/**
 # 请求发生错误
 @param error 错误信息
 */
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    XCLog(@"didFailToReceiveAdWithError");
}


/**
 # 请求成功
 @param ad 请求结果
 */
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}


/**
 # 将要显示
 @param ad 显示数据
 */
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    XCLog(@"WillPresentScreen");
}

/**
 # 显示失败
 */
- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad{
    XCLog(@"DidFailToPresentScreen");
}

/**
 # 将要消失
 */
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    XCLog(@"WillDismissScreen");
}


/**
 # 已经从屏幕消失
 */
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    XCLog(@"DidDismissScreen");
    [self.interstitial removeObserver:self forKeyPath:@"isReady"];
}

/**
 # 将要离开应用
 */
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    XCLog(@"WillLeaveApplication");
}


#pragma mark - Private methon
- (void)setupInterstitial{
    self.interstitial = [[GADInterstitial alloc]initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitial addObserver:self forKeyPath:@"isReady" options:NSKeyValueObservingOptionNew context:nil];
    [self.interstitial loadRequest:request];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    XCLog(@"%@",change);
}



@end

