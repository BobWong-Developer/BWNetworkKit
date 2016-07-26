//
//  BWLoginViewController.m
//  BWNetworkActivity
//
//  Created by Bob Wong on 16/7/11.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLoginViewController.h"
#import "BWCommon.h"

@interface BWLoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *tfAccount;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation BWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    
    _tfAccount.text = @"123456";
    _tfPassword.text = @"654321";
}

- (IBAction)buttonActLogin:(UIButton *)sender
{
    NSDictionary *params = @{
                             @"account": _tfAccount.text,
                             @"password": _tfPassword.text
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BWAFNetworkingInstance POSTDefaultWithCommand:kCommonLogin parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
}

- (IBAction)buttonActRegister:(UIButton *)sender
{
    NSDictionary *params = @{
                             @"account": _tfAccount.text,
                             @"password": _tfPassword.text
                             };
    [BWAFNetworkingInstance POSTDefaultWithCommand:kCommonRegister parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
