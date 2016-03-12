//
//  phoneViewController.m
//  cate
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "phoneViewController.h"
#import "ProgressHUD.h"
#import <BmobSDK/BmobSMS.h>
//#import <BmobMessageSDK/Bmob.h>
@interface phoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *sureNumberBtn;
@property (weak, nonatomic) IBOutlet UITextField *sureNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (weak, nonatomic) IBOutlet UISwitch *switchp;

@end

@implementation phoneViewController
//点击完成返回到登陆界面

- (IBAction)registerUser:(id)sender {
   
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.cellPhoneNumberTF.text andTemplate:@"test1" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
        }
    }];
    
}
- (IBAction)send:(id)sender {
    //验证
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.cellPhoneNumberTF.text andSMSCode:self.sureNumberTF.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"%@",@"验证成功，可执行用户请求的操作");
        } else {
            NSLog(@"%@",error);
        }
    }];
    
}
   

//密码加密
- (IBAction)switchSecurity:(id)sender {
    UISwitch *passSwitch = sender;
    if (passSwitch.on) {
        self.passWordTF.secureTextEntry = NO;
    } else {
        self.passWordTF.secureTextEntry = YES;
        
    }
}
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
