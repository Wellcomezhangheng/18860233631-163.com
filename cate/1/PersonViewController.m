//
//  PersonViewController.m
//  cate
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "PersonViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Header.h"
#define kPerson @"http://apis.znw.me/index.php/User/userinfo/?uid=1294899&mtime=1457407479&mid=1294487&appid=3&mk=4406fd692c2b9d550ef7e807c601c503"
@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    [self getOneModel];
}
- (void)getOneModel{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manger GET:kPerson parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZHLog(@"downloadProgress=%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZHLog(@"responseObject=%@",responseObject);
        
        
//        NSDictionary *dic = responseObject;
//        NSString *message = dic[@"message"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"error = %@",error);
    }];
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
