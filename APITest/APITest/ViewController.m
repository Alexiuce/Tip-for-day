//
//  ViewController.m
//  APITest
//
//  Created by alexiuce  on 2017/10/11.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NSString+Extension.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self sendRequest:nil];
    

    
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)sendRequest:(id)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    NSString * voipServer = @"http://192.168.0.185:8080/common/saveDialVoIp";
    
    
    NSString *httpServer = @"http://httpbin.org/post";
    NSString *jsonText = @"{\"id\":\"0\",\"cust_id\":\"34\",\"link_id\":\"23\",\"number\":\"17682340610\",\"login_id\":\"1\",\"duration\":\"52\",\"call_time\":\"2017-10-12 09:59:04\",\"path\":\"record/17682340610/2017-10-12 09.59.04(17682340610).wav\",\"paid\":\"0.1\"}";
    NSString *jsonBase64 =  [[jsonText custom_Decrypt] base64String];
    //@"BVwXGlxETlJcHQsNCiEXGlxEXFxSXBIXEBUhFxpcRFxcUlwQCxMcGwxcRFxPSUhGTE1KTkhPTlxSXBIRGRcQIRcaXERcT1xSXBoLDB8KFxEQXERcT0xcUlwdHxISIQoXExtcRFxMTk9JU09OU09MXk9ORE5LRE1JXFJcDh8KFlxEXAwbHREMGlFPSUhGTE1KTkhPTlFMTk9JU09OU09MXk9OUE5LUE1JVk9JSEZMTUpOSE9OV1AJHwhcUlwOHxcaXERcTlBPXAM=";
   
    NSURL *url = [NSURL URLWithString:httpServer];
//
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    
// NSMutableURLRequest *requestM = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:httpServer parameters:nil error:nil];
    

    requestM.HTTPMethod = @"POST";
//    [requestM setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestM setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    requestM.HTTPBody = [jsonBase64 dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task =  [manager dataTaskWithRequest:requestM completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error : %@",error.localizedDescription);
            return ;
        }
        NSLog(@"response:  %@",responseObject);
        
    }];
    
    [task resume];

    
    
}


@end
