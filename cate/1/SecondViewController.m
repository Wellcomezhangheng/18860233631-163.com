//
//  SecondViewController.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "SecondViewController.h"
#import "PullingRefreshTableView.h"
#import "BBSSecondViewController.h"
#import "Header.h"
#import "BBSModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "BBSNewTableViewCell.h"
#define kNew @"http://apis.znw.me/index.php/Channel/channels/get/fresh/mid/1294487/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"
#import "ProgressHUD.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    NSInteger _pageCount;   //请求的页数
}
@property(nonatomic, assign) BOOL refreshing;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)PullingRefreshTableView *tableView;
@property (nonatomic, strong)NSMutableArray *NewArray;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    [self workone];
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight)pullingDelegate:self];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _pageCount = 1;
     [self.tableView launchRefreshing];
    
    [self.view addSubview:self.tableView];
    self.tabBarController.tabBar.hidden = YES;
}
//在页面将要消失的时候，调用此方法，去掉所有的
- (void)viewDidDisappear:(BOOL)animated{
        [ProgressHUD dismiss];
}
#pragma mark -------------------------------- PullingRefreshTableView

//下拉刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    [self performSelector:@selector(workone) withObject:nil afterDelay:1.0];
    
}

//上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount += 1;
    self.refreshing = NO;
    [self performSelector:@selector(workone) withObject:nil afterDelay:1.0];
}


//手指开始拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}

//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

- (void)workone{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
         [ProgressHUD show:@"拼命加载中…"];
    [manger GET:[NSString stringWithFormat:@"%@/p/%ld",kNew,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        ZHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [ProgressHUD showSuccess:@"加载成功！"];
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if (_refreshing) {
            if (self.NewArray.count > 0) {
                [self.NewArray removeAllObjects];
            }
        }
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic in data) {
                BBSModel *model = [[BBSModel alloc] initWithDictionary:dic];
                [self.NewArray addObject:model];
            }
            //完成加载
            [self.tableView tableViewDidFinishedLoading];
            self.tableView.reachedTheEnd = NO;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"%@",error);
    }];
}
- (NSMutableArray *)NewArray{
    if (_NewArray == nil) {
        self.NewArray = [NSMutableArray new];
    }
    return _NewArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        BBSNewTableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        CELL.model = self.NewArray[indexPath.row];
        return CELL;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return self.NewArray.count;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBSModel *model = self.NewArray[indexPath.row];
    UIStoryboard *BBSs = [UIStoryboard storyboardWithName:@"BBSsecond" bundle:nil];
    
    BBSSecondViewController *bbs = BBSs.instantiateInitialViewController;
    bbs.channelid = model.channelId;
    //    bbs.imagee = model.imagee;
    [self.navigationController pushViewController:bbs animated:YES];
    
    
    
    
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (self.segementedControl.selectedSegmentIndex == 0) {
//        return self.headArray.count;
//    }else if (self.segementedControl.selectedSegmentIndex == 1){
//        return 1;
//    }else{
//        return 1;
//    }
//    
//}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (self.segementedControl.selectedSegmentIndex == 0) {
//        return self.headArray[section];
//    }
//    else{
//        return nil;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (self.segementedControl.selectedSegmentIndex == 0) {
//        return 40;
//    }else {
//        return 0;
//    }
//    
//}

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
