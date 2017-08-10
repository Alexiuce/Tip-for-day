//
//  ViewController.m
//  QQCloudDemo
//
//  Created by alexiuce  on 2017/8/10.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "ViewController.h"
#import "COSClient.h"

@interface ViewController ()

@property (nonatomic, strong) COSClient *myClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myClient = [[COSClient alloc] initWithAppId:@"" withRegion:@"sh"];
}

- (IBAction)downFile:(id)sender {
    
    
    COSObjectGetTask *cm = [[COSObjectGetTask alloc] initWithUrl:@"n"];
 
    _myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        //
        NSLog(@"%zd  desc = %@, result = %@",resp.retCode ,resp.descMsg, resp.data);
    };
    _myClient.downloadProgressHandler = ^(int64_t receiveLength,int64_t contentLength){
    };
    [_myClient getObject:cm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
