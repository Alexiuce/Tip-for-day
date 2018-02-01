//
//  ADManager.m
//  Cocoa2Demo iOS
//
//  Created by caijinzhu on 2018/2/1.
//  Copyright © 2018年 Apportable. All rights reserved.
//

#import "ADManager.h"

@import GoogleMobileAds;


@interface ADManager()<GADInterstitialDelegate>

@property (nonatomic, strong) GADInterstitial *interstitial;



@end


@implementation ADManager


+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static ADManager *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    
    });
    return _instance;
}


+ (void)readyAD{
    [[self shareManager] loadRequest];
}

+ (void)showAD{
    [[self shareManager] showAd];
}



- (void)showAd{
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:[CCDirector sharedDirector]];
    }else{
        XCLog(@"not ready for ad");
    }
}

#pragma mark - GADInterstitialDelegate


/**
 # 请求发生错误
 @param error 错误信息
 */
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
   
 
}


/**
 # 请求成功
 @param ad 请求结果
 */
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    [self loadRequest];
}

/**
 # 已经从屏幕消失
 */
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{

    // 预先加载下次数据
    [self loadRequest];

}



- (GADInterstitial *)interstitial{
    if (_interstitial == nil) {
        _interstitial = [[GADInterstitial alloc]initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
        _interstitial.delegate = self;
    }
    return _interstitial;
}

- (void)loadRequest{
    _interstitial = nil;
    [self.interstitial loadRequest:[GADRequest request]];
   
}

@end
