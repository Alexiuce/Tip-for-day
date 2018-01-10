//
//  ViewController.m
//  HttpServer
//
//  Created by Alexcai on 2017/12/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "ViewController.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "GCDAsyncSocket.h"


@interface ViewController()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [_clientSocket connectToHost:@"192.168.0.138" onPort:8899 error:&error];
    if (error != nil) {
        NSLog(@"%@",error.localizedDescription);
        return;
    }
    
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"链接服务器%@成功 端口: %d",host,port);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送数据 %ld",tag);
}

- (IBAction)sendMessage:(NSButton *)sender {
//    static int sendIndex = 0;
   
    NSString *msg = [NSString stringWithFormat:@"%zd random ", arc4random_uniform(100)];
    NSData *sendData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    [_clientSocket writeData:sendData withTimeout:-1 tag:0];
    
}


- (void)startWebServer{
        GCDWebServer *webServer = [GCDWebServer new];
        [webServer addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
            return [GCDWebServerDataResponse responseWithHTML:@"<html><body>Hello WebServer</body></html>"];
        }];
        [webServer runWithPort:8888 bonjourName:nil];
}


@end
