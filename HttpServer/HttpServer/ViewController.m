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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GCDWebServer *webServer = [GCDWebServer new];
    [webServer addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        return [GCDWebServerDataResponse responseWithHTML:@"<html><body>Hello WebServer</body></html>"];
    }];
    [webServer runWithPort:8888 bonjourName:nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
