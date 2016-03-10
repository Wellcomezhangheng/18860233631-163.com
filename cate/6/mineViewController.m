//
//  mineViewController.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "mineViewController.h"
#import "AppDelegate.h"
#import "WBHttpRequest+WeiboShare.h"
#import "WeiboSDK.h"
@interface mineViewController ()
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIView *blackView;
- (IBAction)share:(id)sender;

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    
    
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

- (IBAction)share:(id)sender {
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kwidth, kheight )];
    _blackView.backgroundColor = [UIColor whiteColor];
    [window addSubview:_blackView];
    
    
    
    
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0,kheight, kwidth, kheight)];
    _shareView.backgroundColor = [UIColor orangeColor];
    [window addSubview:_shareView];
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(50, 40,60, 60);
    [weiboBtn addTarget:self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    [weiboBtn setImage:[UIImage imageNamed:@"weibo_login_btn_bg副本.png"] forState:UIControlStateNormal];
    [_shareView addSubview:weiboBtn];
    //friend
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(140, 40,60, 60);
    [friendBtn setImage:[UIImage imageNamed:@"QQ.png"] forState:UIControlStateNormal];
    [_shareView addSubview:friendBtn];
    //circleBtn
    UIButton *circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    circleBtn.frame = CGRectMake(230, 40,60, 60);
    [circleBtn setImage:[UIImage imageNamed:@"WEIXIN.png"] forState:UIControlStateNormal];
    [_shareView addSubview:circleBtn];
    //取消按钮
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(135, 140,70, 70);
    [removeBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [removeBtn setImage:[UIImage imageNamed:@"QQ.png"] forState:UIControlStateNormal];
    [_shareView addSubview:removeBtn];
    [removeBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.8;
        self.shareView.frame = CGRectMake(0, 450, kwidth, kheight-450);
    }];

    
    
    
    
}
//- (void)fenxiang:(UIButton *)btn{
//    {
//        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//        
//        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//        authRequest.redirectURI = kRedirectURL;
//        authRequest.scope = @"all";
//        
//        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
//        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//        //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//        [WeiboSDK sendRequest:request];
//        [self quxiao];
//        
//    }
//}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    ZHLog(@"%@",response);
    
    
}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"更多美食尽在 吃货伙伴app 我在吃货伙伴等你哦！！！", nil);
    return message;
}
- (void)quxiao{
    [self.shareView removeFromSuperview];
    [self.blackView removeFromSuperview];
}
@end
