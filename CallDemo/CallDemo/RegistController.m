//
//  RegistController.m
//  CallDemo
//
//  Created by alexiuce  on 2017/7/20.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import "RegistController.h"
#import <ALCall_Sdk/ALCall_Sdk.h>
#import "UserAccount.h"


NSString * const kUserinfo = @"kALCall_User_Info";


@interface RegistController ()
@property (weak, nonatomic) IBOutlet UITextField *countryCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - IBAction
- (IBAction)registPhone:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_countryCode.text.length && _phoneNumber.text.length) {
        
        [ALCSignin signinWithTel:_phoneNumber.text countryCode:_countryCode.text complete:^(NSDictionary *value, NSString *error) {
            if (error) {  // 错误处理
                NSLog(@"%@",error.localizedLowercaseString);
                return ;
            }
            NSNumber *retVal = value[@"retVal"];
            if (retVal.integerValue == 0) {  // 注册成功
                // 保存用户信息
                UserAccount *account = [UserAccount userAccountWithDictionary:value[@"data"]];
                [account saveUserAccount];
                
                
//                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"%@",value);
            }
            
        }];
    }else{
        NSLog(@"信息输入不完整");
    }
    
}


@end
