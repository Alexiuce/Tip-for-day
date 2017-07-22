//
//  XCAssisstant.m
//  IPAPatch
//
//  Created by Alexcai on 2017/7/22.
//  Copyright © 2017年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAssisstant.h"
#import "KVOController.h"


static NSString *QRController = @"WCAccountLoginByQRCodeViewController";    // 微信扫描登录控制器
static NSString *qrImgKey = @"_qrCodeImgView";      // 微信二维码视图控件


@interface XCAssisstant ()

@property (nonatomic, strong) FBKVOController *kvoController; // kvo监听
@property (nonatomic, strong) NSTimer *myTimer;     // 定时器
@property (nonatomic, assign) BOOL isLoadingTask;   // 任务是否在加载(网络请求中)

@end



@implementation XCAssisstant

+ (instancetype)defaultAssisstant{
    static dispatch_once_t onceToken;
    static XCAssisstant * _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[XCAssisstant alloc]init];
        _instance.kvoController = [[FBKVOController alloc]initWithObserver:_instance];  // 添加监听
        [_instance startQueryWorkingTask];   // 开启任务轮询
    });
    return _instance;
}

// 开启任务轮询
- (void)startQueryWorkingTask{
    _myTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(checkingServerPort) userInfo:nil repeats:YES];
    [_myTimer fire];
}

// 发送请求,获取调度任务
- (void)checkingServerPort{
    // 1.任务是否在请求中
    if (_isLoadingTask) {return;}
    // 2.发送任务请求
    
    // 3.请求成功,加载扫码登录
    [self loadLoginQRCodeView];
    
}
// 加载二维码扫描登录页
- (void)loadLoginQRCodeView{
    UIViewController *qrController = (UIViewController *)NSClassFromString(QRController);
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController presentViewController:qrController animated:YES completion:^{
        // kvo监听 获取二维码图片
        UIImageView *qrImgView = [qrController valueForKey:qrImgKey];
        [self.kvoController observe:qrImgView keyPath:@"image" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
            // 获取新图片
            UIImage *newImg = change[NSKeyValueChangeNewKey];
            // 判断图片是否需要刷新
            if (newImg == nil) {
                // 页面控制器刷新图片
                [qrController performSelector:@selector(onRefreshBtnClicked)];
                return;
            }
            // 发送图片到服务器
        
        }];
        
        
    }];
}




@end
