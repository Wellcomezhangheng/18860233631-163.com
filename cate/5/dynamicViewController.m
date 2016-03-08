//
//  dynamicViewController.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "dynamicViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Header.h"

#import <UIImageView+WebCache.h>
#import "dyView.h"
@interface dynamicViewController ()
@property (nonatomic, strong)dyView *dyview;
@end

@implementation dynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getOneModel];
//    dynamicModel *model = [[dynamicModel alloc] init];
    self.dyview = [[dyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.dyview];
    
    
}
- (dyView *)dyview{
    if (_dyview == nil) {
        self.dyview = [dyView new];
    }
    return _dyview;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (void)getOneModel{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://apis.znw.me/index.php/Moment/moment/?"  parameters:@{@"momentId":self.momentId,@"mid":@"1294487",@"appid":@"3",@"mk":@"4406fd692c2b9d550ef7e807c601c503"} progress:^(NSProgress * _Nonnull uploadProgress) {
           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               ZHLog(@"%@",responseObject);
               NSDictionary *dic = responseObject;
               NSString *message = dic[@"message"];
               NSArray *data = dic[@"data"];
              
               if ([message isEqualToString:@"操作成功"]) {
                   
                       NSDictionary *dic1 = data[0];
                       self.dyview.dataDic = dic1;
//                       NSDictionary *Str1 = dic1[@"fromUser"];
//                       NSString *Str2 = Str1[@"name"];
//                       [self.nameBtn setTitle:Str2 forState:UIControlStateNormal];
//                       self.timeLable.text = dic1[@"ctime"];
////
//                       self.praiseLable.text = dic1[@"likes_count"];
//                       NSMutableArray *array1 = dic1[@"images"];
//                       for (NSDictionary *Dic in array1) {
//                           NSString *str1 = Dic[@"large"];
//                           
//                           NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
//                           [self.imagee sd_setImageWithURL:[NSURL URLWithString:str2] placeholderImage:nil];
//                       }
//                       
//                       
//                       NSMutableArray *arr1 = dic1[@"channel"];
//                       for (NSDictionary *dic2 in arr1) {
//                           NSString *strr1 = dic2[@"subject"];
//                           [self.btn2 setTitle:strr1 forState:UIControlStateNormal];
//                       }
                  
//
               }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"%@",error);
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
