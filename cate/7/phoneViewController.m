//
//  phoneViewController.m
//  cate
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "phoneViewController.h"
#import "ProgressHUD.h"
#import <BmobSDK/Bmob.h>
//#import <BmobMessageSDK/Bmob.h>
@interface phoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *verify;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *againPassWord;

@end

@implementation phoneViewController
- (IBAction)registerUser:(id)sender {
    BmobUser *buser = [[BmobUser alloc] init];
    buser.mobilePhoneNumber = self.phoneText.text;
    buser.password = self.passWord.text;
    [buser signUpOrLoginInbackgroundWithSMSCode:@"6位验证吗" block:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            ZHLog(@"%@",error);
        }else{
            BmobUser *user = [BmobUser getCurrentUser];
            ZHLog(@"%@",user);
        }
    }];

}
//- (IBAction)send:(id)sender {
//    
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneText.text andTemplate:@"text" resultBlock:^(int number, NSError *error) {
//        if (error) {
//            ZHLog(@"%@",error);
//        }else{
//            ZHLog(@"%d",number);
//        }
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
