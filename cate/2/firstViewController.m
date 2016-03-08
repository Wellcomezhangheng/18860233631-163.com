//
//  firstViewController.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "firstViewController.h"
#import "BBSSecondViewController.h"
#import "Header.h"
#import "BBSTableViewCell.h"
#import "BBSModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#define kBBS @"http://apis.znw.me/index.php/Channel/newIndex230/mid/1294487/gps/112.426815%2C34.6186/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"
@interface firstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *headArray;
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign) BOOL refreshing;
@property (nonatomic, assign)NSInteger index;


@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self oneWork];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 210;
   
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSTableViewCell" bundle:nil]   forCellReuseIdentifier:@"cell"];
    
   
}
- (void)oneWork{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //     [ProgressHUD show:@"拼命加载中…"];
    [manger GET:kBBS parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        [ProgressHUD showSuccess:@"加载成功！"];
        
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if (_refreshing) {
            if (self.headArray.count > 0) {
                [self.headArray removeAllObjects];
            }
        }
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dict in data) {
                //每个分区标题
                [self.headArray addObject:dict[@"cate_category_name"]];
                
                for (NSDictionary *dictt  in dict[@"channels"]) {
                    
                    BBSModel *model1 = [[BBSModel alloc] initWithDictionary:dictt];
                    [self.activityArray addObject:model1];
                    
                    
                }
                
                [self.tableView reloadData];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"eeeeeeeeee=%@",error);
    }];
}
- (NSMutableArray *)headArray{
    if (_headArray == nil) {
        self.headArray = [NSMutableArray new];
    }
    return _headArray;
}
- (NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        self.activityArray = [NSMutableArray new];
    }
    return _activityArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        BBSTableViewCell *BBScell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        BBScell.model = self.activityArray[indexPath.row];
        return BBScell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return self.activityArray.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBSModel *model = self.activityArray[indexPath.row];
    UIStoryboard *BBSs = [UIStoryboard storyboardWithName:@"BBSsecond" bundle:nil];
    
    BBSSecondViewController *bbs = BBSs.instantiateInitialViewController;
    bbs.channelid = model.channelId;
    //    bbs.imagee = model.imagee;
    [self.navigationController pushViewController:bbs animated:YES];
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
        return self.headArray.count;
  
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
        return self.headArray[section];
    }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
        return 40;
    
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
