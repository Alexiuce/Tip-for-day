//
//  ALCHelper.h
//  ALCall_Sdk
//
//  Created by phq on 16/11/15.
//  Copyright © 2016年 phq. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 通话状态类别
 */
typedef NS_ENUM(NSInteger, CallStatus) {
    CallStatusNone,         // 默认状态
    CallStatusReady,        // 准备呼叫
    CallStatusCallFailure,  // 呼叫连接失败
    
    CallStatusCalling,      // 连接中
    CallStatusRinging,      // 响铃中
    CallStatusEstablished,  // 建立通话
    CallStatusRejected,     // 呼叫被拒
    CallStatusTimeout,      // 呼叫超时
    CallStatusCallerhungUp, // 主叫挂断
    CallStatusCleared,      // 已结束通话
    CallStatusInterrupt     // 进程中断
};

/** @brief 通话SDK实例的委托类，回调通话状态信息
 */
@protocol ALCHelperDelegate <NSObject>

/**
 建议通话请求失败
 @param callStatus 通话状态
 @param errorMsg 错误信息
 */
- (void)helperMakeCallFaild:(CallStatus)callStatus errorMsg:(NSString *)errorMsg;

/**
 建议通话请求成功后，接收通话中各个状态
 @param callStatus 通话状态
 */
- (void)helperDidCall:(CallStatus)callStatus;

@end

/** @brief 通话SDK实例，具体参照该类成员的参数定义
 * 示例代码: ALCHelperInstance.appKey = @"xxxxxxxxxxxxxx...";
 *         ALCHelperInstance.appToken = @"yyyyyyyy....";
 */
#define ALCHelperInstance [ALCHelper sharedInstance]
@interface ALCHelper : NSObject

/** required:  appkey string */
@property(nonatomic, copy) NSString *appKey;
/** required:  appkey string */
@property(nonatomic, copy) NSString *appToken;
/** optional:  default: nil*/
@property (nonatomic, assign) id <ALCHelperDelegate> delegate;

+ (ALCHelper *)sharedInstance;

/**
 sdk版本号
 */
- (void)logVersion;

/**
 注册通话功能。** 注：注册成功后才能请求通话
 @param username 注册手机号，请使用-signinWithTel:countryCode:complete:实现注册
 @return 注册状态：成功返回YES，失败返回NO
 */
- (BOOL)registerWithTel:(NSString *)tel;

/**
 发起通话。由于iOS10的私隐权限原因，需要在info.plist中添加NsMicrophoneUsageDescription的描述，否则会终止程序。
 @param number 被叫号码，国家代码+区号(首0去一个0)+电话号码
 */
- (void)markCall:(NSString *)number;

/**
 挂断通话。挂断后需要时间终止语音流链接程序，与网络环境有关，避免同时间多次调用。建议1～2秒的呼叫间隔。
 */
- (void)endCallsAction;

/**
 设置接通震动提示,默认NO
 @param sender YES打开，默认NO
 */
- (void)setupVibra:(BOOL)sender;

/**
 获取接通震动提示状态
 @return YES打开，NO关闭
 */
- (BOOL)vibraAlert;

/**
 二次拨号，在建立通话时实现二次送号
 @param key key = 0～9，*，#
 */
- (void)sendDTMFSignal:(NSString *)key;

/**
 设置免提的打开或关闭
 @param on YES打开，NO关闭
 */
- (void)setupSpeakerOn:(BOOL)on;
- (BOOL)isSpeakerOn;

/**
 设置静音的打开或关闭
 @param on YES打开，NO关闭
 */
- (void)setupMuteOn:(BOOL)on;
- (BOOL)isMuteOn;

/**
 开始录音、关闭录音、当前录音功能是否打开（录音文件的后缀是wav）
 @param name 文件名（如：xiaoqiang）
 @param path 保存录音文件的沙盒路径
 @param on YES打开，NO关闭
 */
- (BOOL)startRecordingWtihName:(NSString *)name savePath:(NSString *)path;
- (void)stopRecording;
- (BOOL)isRecording;

@end
