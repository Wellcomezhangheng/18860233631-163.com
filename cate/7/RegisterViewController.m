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
            
        } else {
            [ProgressHUD showSuccess:@"注册失败"];
            
        }
    }];
}
//注册之前需要判断
- (BOOL)checkOut {
    //用户名不能为空
    if (self.userTextField.text.length <= 0 || [self.userTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:@"用户名有空格或格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertSure = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:alertAction];
        [alert addAction:alertSure];
        //添加提示框
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //两次输入密码一致
    if (![self.passwordTextField.text isEqualToString:self.againPWTextField.text]) {
        //提示框
        UIAlertController *alertPass = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertSu = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertPass addAction:alertAction];
        [alertPass addAction:alertSu];
        [self presentViewController:alertPass animated:YES completion:nil];
        return NO;
    }
    //输入密码不能为空
    if ([self.passwordTextField.text isEqualToString:@" " ]|| [self.passwordTextField.text isEqualToString:@" "] || [self.againPWTextField.text isEqualToString:@" " ]|| [self.againPWTextField.text isEqualToString:@" "]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *alertCan = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:alertAction];
        [alert addAction:alertCan];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    return YES;
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
