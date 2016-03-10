//
//  activityViewController.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "activityViewController.h"
#import "Header.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "activity.h"
@interface activityViewController ()
@property (strong, nonatomic) IBOutlet activity *activityView;


@end

@implementation activityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getWork];
}
- (void)getWork{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://apis.znw.me/index.php/Event/eventinfo/?" parameters:@{@"mid":@"1294487",@"source":@"douban",@"mtime":@"1457471957",@"mk":@"4406fd692c2b9d550ef7e807c601c503",@"sourceId":self.sourceId,@"appid":@"3"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic1 in data) {
                self.activityView.dataDic = dic1;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ZHLog(@"%@",error);
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
