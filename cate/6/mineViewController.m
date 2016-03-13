//
//  mineViewController.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//
#import "systemViewController.h"
#import "mineViewController.h"
#import "AppDelegate.h"
#import "WBHttpRequest+WeiboShare.h"
#import "WeiboSDK.h"
#import <SDWebImage/SDImageCache.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "messageTwoViewController.h"
#import "loginViewController.h"
@interface mineViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;




@end

@implementation mineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    
    self.imageArray = @[@"list_make_out.png",@"list_make_out.png",@"list_make_out.png",@"list_make_out.png",@"list_make_out.png"];
    self.titleArray = [NSMutableArray arrayWithObjects:@"我的主题社区",@"我的收藏",@"我的信息",@"系统设置",@"微博分享", nil];
  
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self HeaderView];
    [self.view addSubview:self.tableView];
    
    
}
- (void)loginn{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"mine" bundle:nil];
    loginViewController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)HeaderView{
    if ([_UID isEqualToString: @"成功"]) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, 150)];
        headView.backgroundColor = [UIColor orangeColor];
        self.tableView.tableHeaderView = headView;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 55, 70, 70)];
        imageV.image = [UIImage imageNamed:@"20160219015437_5Yz2h.thumb.700_0.jpeg"];
        imageV.layer.cornerRadius = 35;
        imageV.clipsToBounds = YES;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, kwidth-150, 30)];
        lable.text = @"欢迎回来";
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(150,80, kwidth-150, 30)];
        lable1.text = self.userName;
        
        [headView addSubview:imageV];
        [headView addSubview:lable];
        [headView addSubview:lable1];

        
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, 195)];
        headView.backgroundColor = [UIColor orangeColor];
        self.tableView.tableHeaderView = headView;
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 100, 70, 70)];
        imageV.image = [UIImage imageNamed:@"20160219015437_5Yz2h.thumb.700_0.jpeg"];
        imageV.layer.cornerRadius = 35;
        imageV.clipsToBounds = YES;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 40)];
        lable.text = @"立即登录，体验更多";
        lable.textColor = [UIColor whiteColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 120, kwidth-150, 40)];
        [btn setTitle:@"点击登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginn) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(kwidth-30, 127, 10, 10)];
        imageV2.image = [UIImage imageNamed:@"list_make_out.png"];
        
        
        [headView addSubview:imageV];
        [headView addSubview:lable];
        [headView addSubview:btn];
        [headView addSubview:imageV2];
    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //我的主题社区
            [self one];
            
        }
            break;
        case 1:
        {
            //我的收藏
            [self two];
        }
            break;
        case 2:
        {
            //我的信息
            [self three];
        }
            break;
        case 3:
        {
            //系统设置
            [self four];
        }
            break;
        case 4:
        {
            //微博分享
            [self five];
        }
            break;
        default:
            break;
    }
}
- (void)one{
    messageTwoViewController *twoVC = [[messageTwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}
- (void)two{
    messageTwoViewController *twoVC = [[messageTwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}
- (void)three{
    messageTwoViewController *twoVC = [[messageTwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}
- (void)four{
    systemViewController *sysVC = [[systemViewController alloc] init];
    [self.navigationController pushViewController:sysVC animated:YES
     ];
}
- (void)five{
    
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kRedirectURL;
        authRequest.scope = @"all";
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        [WeiboSDK sendRequest:request];
        
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    for (int i = 0; i < 5; i ++) {
        if (indexPath.row == i) {
            cell.textLabel.text = self.titleArray[i];
//            cell.imageView.image = [UIImage imageNamed:self.imageArray[i]];
        }
    }
    //    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    //    cell.textLabel.text = self.titleArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell;
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight-44-64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation





- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    ZHLog(@"%@",response);
    
    
}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"更多美食尽在 吃货伙伴app 我在吃货伙伴等你哦！！！", nil);
    return message;
}

@end
