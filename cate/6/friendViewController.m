//
//  friendViewController.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "friendViewController.h"
#import "friendTableViewCell.h"
#import "Header.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "activityViewController.h"
@interface friendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *headArray;
@property (nonatomic, strong)NSMutableArray *activityArray;

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation friendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
//  
    
        [self oneWork];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 210;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"friendTableViewCell" bundle:nil]   forCellReuseIdentifier:@"cell"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"洛阳市" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarButtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightbarButtn;

    
}
- (void)right:(UIButton *)btn{
    
}
- (void)oneWork{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://apis.znw.me/index.php/Event/explodeEvent/?" parameters:@{@"mid":@"1294487",@"cityCode":@"0379",@"appid":@"3",@"mk":@"4406fd692c2b9d550ef7e807c601c503",@"city":@"%E6%B4%9B%E9%98%B3%E5%B8%82"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dict in data){
                NSArray *recommend = dict[@"recommend"];
                for (NSDictionary *dic1 in recommend) {
                    friendModel *model = [[friendModel alloc] initWithDictionary:dic1];
                    [self.activityArray addObject:model];
                }
                [self.tableView reloadData];
            }
        
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"%@",error);
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
    
    
    friendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.activityArray[indexPath.row];
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.activityArray.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    friendModel *model = self.activityArray[indexPath.row];
    UIStoryboard *activitySB = [UIStoryboard storyboardWithName:@"activity" bundle:[NSBundle mainBundle]];
    
    activityViewController *myView = [activitySB instantiateInitialViewController];
    myView.sourceId = model.sourceId;
    //    bbs.channelid = model.channelId;
    //    bbs.imagee = model.imagee;
    [self.navigationController pushViewController:myView animated:YES];
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    

    return 1;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"推荐活动";
    return str;
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
