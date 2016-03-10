//
//  MessageViewController.m
//  BmobSDK
//
//  Created by limao on 15/6/1.
//  Copyright (c) 2015年 donson. All rights reserved.
//

#import "MessageViewController.h"
#import <BmobMessageSDK/Bmob.h>

@interface MessageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneNumberTf;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTf;
@property (weak, nonatomic) IBOutlet UITextField *smsIdTf;
@property (weak, nonatomic) IBOutlet UITextView *resultTv;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestSmsCodeBtn:(UIButton *)sender {
    //获取手机号
    NSString *mobilePhoneNumber = self.mobilePhoneNumberTf.text;
    
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            self.smsIdTf.text = error.description;
            NSLog(@"%@",error);
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
            self.smsIdTf.text = [NSString stringWithFormat:@"%d",number];
        }
    }];
}

- (IBAction)verifySmsCodeBtn:(UIButton *)sender {
    //获取手机号、验证码
    NSString *mobilePhoneNumber = self.mobilePhoneNumberTf.text;
    NSString *smsCode = self.smsCodeTf.text;
    
    //验证
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andSMSCode:smsCode resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"%@",@"验证成功，可执行用户请求的操作");
            self.resultTv.text = @"验证成功，可执行用户请求的操作";
        } else {
            NSLog(@"%@",error);
            self.resultTv.text = [error description];
        }
    }];
}

- (IBAction)queryStateOfMessageBtn:(UIButton *)sender {
     unsigned smsId = [self.smsIdTf.text intValue];
    [BmobSMS querySMSCodeStateInBackgroundWithSMSId:smsId resultBlock:^(NSDictionary *dic, NSError *error) {
        if (dic) {
            NSLog(@"%@",dic);
        } else {
            NSLog(@"%@",error);
        }
    }];
    
     
}

- (IBAction)backgroundTab:(id)sender {
    [self.mobilePhoneNumberTf resignFirstResponder];
    [self.smsCodeTf resignFirstResponder];
    [self.smsIdTf resignFirstResponder];
}


- (IBAction)sendContentSMSBtn:(UIButton *)sender {
    NSString *mobilePhoneNumber = self.mobilePhoneNumberTf.text;
    [BmobSMS requestSMSInbackgroundWithPhoneNumber:mobilePhoneNumber Content:@"测试用例" andSendTime:nil resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"sendContentSMSBtn-%@",error);
        } else {
            self.smsIdTf.text = [[NSString alloc] initWithFormat:@"%d",number];
        }
    }];
}

- (IBAction)sendContentSMSTimingBtn:(id)sender {
    NSString *mobilePhoneNumber = self.mobilePhoneNumberTf.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:10];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *content = [[NSString alloc] initWithFormat:@"测试定时发送，发送时间：%@",dateStr];
    [BmobSMS requestSMSInbackgroundWithPhoneNumber:mobilePhoneNumber Content:@"您的XX服务还有XX时间到期，请及时续费。" andSendTime:@"2015-07-01 10:59:00" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"sendContentSMSBtn-%@",error);
        } else {
            self.smsIdTf.text = [[NSString alloc] initWithFormat:@"%d",number];
            NSLog(@"smsId:%d",number);
        }
    }];
}
@end
