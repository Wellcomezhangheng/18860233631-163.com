//
//  RegisterViewController.m
//  cate
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProgressHUD.h"
#import <BmobSDK/Bmob.h>
#import "loginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPWTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchP;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property(nonatomic, strong) UIAlertAction *alertSure;
@property(nonatomic, strong) UIAlertAction *alertCancel;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //密文显示
    self.passwordTextField.secureTextEntry = YES;
    self.againPWTextField.secureTextEntry = YES;
    
    self.switchP.on = NO;
}
- (IBAction)switchhh:(id)sender {
    UISwitch *passSwitch = sender;
    if (passSwitch.on) {
        self.passwordTextField.secureTextEntry = NO;
        self.againPWTextField.secureTextEntry = NO;
    } else {
        self.passwordTextField.secureTextEntry = YES;
        self.againPWTextField.secureTextEntry = YES;
    }

}
- (IBAction)registerchick:(id)sender {
    if (![self checkOut]) {
        return;
    }
    
    [ProgressHUD show:@"正在为您注册"];
    BmobUser *bmUser = [[BmobUser alloc] init];
    [bmUser setUsername:self.userTextField.text];
    [bmUser setPassword:self.passwordTextField.text];
    [bmUser setPassword:self.againPWTextField.text];
    [bmUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功"];
            [self one];
        } else {
            [ProgressHUD showSuccess:@"注册失败"];
            
        }
    }];
}
- (void)one{
    
    
}
//注册之前需要判断
- (BOOL)checkOut {
//    //判断手机号
//    if (self.userTextField.text.length <= 0 && [self.userTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号不能为空" preferredStyle:UIAlertControllerStyleAlert];
//        [alertC addAction:self.alertCancel];
//        [alertC addAction:self.alertSure];
//        [self presentViewController:alertC animated:YES completion:nil];
//        return NO;
//    }
//    //判断手机号的格式
//    //移动
//    NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
//    //联通
//    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    //电信
//    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSPredicate *regextestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    //小灵通
//    NSString *CT = @"^1((33|53|8[09])[09]|349)\\d@{7}$";
//    NSPredicate *regextestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if (!([regextestMobile evaluateWithObject:self.userTextField.text] == YES || [regextestCU evaluateWithObject:self.userTextField.text] == YES || [regextestCT evaluateWithObject:self.userTextField.text] == YES || [regextestCM evaluateWithObject:self.userTextField.text] == YES)) {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
//        [alertC addAction:self.alertCancel];
//        [alertC addAction:self.alertSure];
//        [self presentViewController:alertC animated:YES completion:nil];
//        return NO;
//    }
    //判断密码
    if (self.passwordTextField.text.length <= 0 && [self.passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:self.alertCancel];
        [alertC addAction:self.alertSure];
        [self presentViewController:alertC animated:YES completion:nil];
        
        
        
        return NO;
    }
    //判断两个密码
    if (![self.passwordTextField.text isEqualToString:self.againPWTextField.text]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:self.alertCancel];
        [alertC addAction:self.alertSure];
        [self presentViewController:alertC animated:YES completion:nil];
        return NO;
    }
    if (self.passwordTextField.text.length < 7||self.passwordTextField.text.length > 20) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码格式错误" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:self.alertCancel];
        [alertC addAction:self.alertSure];
        [self presentViewController:alertC animated:YES completion:nil];
        return NO;

    }
    
    return YES;
}

//懒加载
- (UIAlertAction *)alertCancel{
    if (!_alertCancel) {
        self.alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    }
    return _alertCancel;
}

- (UIAlertAction *)alertSure{
    if (!_alertSure) {
        self.alertSure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    }
    return _alertSure;
}

//点击return处回收键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
