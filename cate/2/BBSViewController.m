//
//  BBSViewController.m
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//
#import "BBSSecondViewController.h"
#import "BBSViewController.h"
#import "VOSegmentedControl.h"
#import "Header.h"
#import "PullingRefreshTableView.h"
#import "BBSTableViewCell.h"
#import "BBSModel.h"
#import "BBSNewTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#define kBBS @"http://apis.znw.me/index.php/Channel/newIndex230/mid/1294487/gps/112.426815%2C34.6186/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"
#define kNew @"http://apis.znw.me/index.php/Channel/channels/get/fresh/mid/1294487/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"
#define kRecruit @"http://apis.znw.me/index.php/Channel/recruit/mid/1294487/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"

@interface BBSViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    NSInteger _pageCount;   //请求的页数
}

@property (nonatomic, strong)VOSegmentedControl *segementedControl;
@property (nonatomic, strong)NSMutableArray *headArray;
@property (nonatomic, strong)NSMutableArray *activityArray;

@property (nonatomic, strong)PullingRefreshTableView *tableView;
@property(nonatomic, assign) BOOL refreshing;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)PullingRefreshTableView *tableView1;
@property (nonatomic, strong)NSMutableArray *NewArray;
@property (nonatomic, strong)NSMutableArray *RecruitArray;

@end

@implementation BBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //第一次先请求第一个界面
    [self twoWork];
    
    self.tableView1 = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 44, kwidth, kheight)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.rowHeight = 120;
    [self.view addSubview:self.tableView1];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BBSNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self.tableView1 launchRefreshing];
    
    
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 44, kwidth, kheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 210;
  [self.view addSubview:self.tableView];
    
   
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSTableViewCell" bundle:nil]   forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.segementedControl];
    //刷新
    _pageCount = 1;
    [self.tableView launchRefreshing];
   [self segmentCtrlValuechange:self.segementedControl];
}

//在页面将要消失的时候，调用此方法，去掉所有的
- (void)viewDidDisappear:(BOOL)animated{
//    [ProgressHUD dismiss];
}
//开始刷新
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    [self performSelector:@selector(segmentCtrlValuechange:) withObject:nil afterDelay:1.0];
}
//开始加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount += 1;
    self.refreshing = NO;
    [self performSelector:@selector(segmentCtrlValuechange:) withObject:nil afterDelay:1.0];
}
// 手指开始拖动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    [self.tableView1 tableViewDidScroll:scrollView];
}
//下拉刷新时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    [self.tableView1 tableViewDidEndDragging:scrollView];
    
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
                           if (_refreshing) {
                               if (self.activityArray.count > 0) {
                                   [self.activityArray removeAllObjects];
                               }
                           }
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
- (void)twoWork{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
     manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//     [ProgressHUD show:@"拼命加载中…"];
    [manger GET:[NSString stringWithFormat:@"%@/p/%ld",kNew,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [ProgressHUD showSuccess:@"加载成功！"];
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
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"%@",error);
    }];
}
- (void)threeWork{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//     [ProgressHUD show:@"拼命加载中…"];
    [manger GET:[NSString stringWithFormat:@"%@/p/%ld",kRecruit,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [ProgressHUD showSuccess:@"加载成功！"];
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if (_refreshing) {
            if (self.RecruitArray.count > 0) {
                [self.RecruitArray removeAllObjects];
            }
        }
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic in data) {
                BBSModel *model = [[BBSModel alloc] initWithDictionary:dic];
                [self.RecruitArray addObject:model];
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
- (NSMutableArray *)RecruitArray{
    if (_RecruitArray == nil) {
        self.RecruitArray = [NSMutableArray new];
    }
    return _RecruitArray;
}
- (NSMutableArray *)NewArray{
    if (_NewArray == nil) {
        self.NewArray = [NSMutableArray new];
    }
    return _NewArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       if (self.segementedControl.selectedSegmentIndex == 0) {
        BBSTableViewCell *BBScell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        BBScell.model = self.activityArray[indexPath.row];
        return BBScell;
    }else if (self.segementedControl.selectedSegmentIndex == 1){
        BBSNewTableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        CELL.model = self.NewArray[indexPath.row];
        return CELL;
    }else{
        BBSNewTableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        CELL.model = self.RecruitArray[indexPath.row];
        return CELL;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.segementedControl.selectedSegmentIndex == 0) {
        return self.activityArray.count;
    }else if (self.segementedControl.selectedSegmentIndex == 1){
        return self.NewArray.count;
    }
    else{
        return self.RecruitArray.count;
    }
        
    
    
    
//    ZHLog(@"%ld",self.activityArray.count);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BBSModel *model = self.activityArray[indexPath.row];
    UIStoryboard *BBSs = [UIStoryboard storyboardWithName:@"BBSsecond" bundle:nil];
    
    BBSSecondViewController *bbs = BBSs.instantiateInitialViewController;
    bbs.channelid = model.channelId;
//    bbs.imagee = model.imagee;
    [self.navigationController pushViewController:bbs animated:YES];
 
 
    
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 50)];
//    if (section == 0) {
//        
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 40)];
//        lable.text = @"ndsss";
//        [view1 addSubview:lable];
//    }
//    
//    return view1;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.segementedControl.selectedSegmentIndex == 0) {
        return self.headArray.count;
    }else if (self.segementedControl.selectedSegmentIndex == 1){
        return 1;
    }else{
        return 1;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.segementedControl.selectedSegmentIndex == 0) {
        return self.headArray[section];
            }
    else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.segementedControl.selectedSegmentIndex == 0) {
        return 40;
    }else {
        return 0;
    }
   
}




//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *abView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
//    abView.backgroundColor=[UIColor redColor];
//    
//    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    lable.text=self.headArray[section];
//    ZHLog(@"%@",lable.text);
//    [abView addSubview:lable];
//    return abView;
//}


- (VOSegmentedControl *)segementedControl{
    if (_segementedControl == nil) {
        self.segementedControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"推荐"},@{VOSegmentText: @"最新"},@{VOSegmentText: @"招募"}]];
        self.segementedControl.contentStyle = VOContentStyleTextAlone;
        self.segementedControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segementedControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.segementedControl.selectedBackgroundColor = self.segementedControl.backgroundColor;
        self.segementedControl.allowNoSelection = NO;
        self.segementedControl.frame = CGRectMake(0, 60, kwidth, 44);
        self.segementedControl.indicatorThickness = 4;
        self.segementedControl.tag = 1;
        [self.segementedControl setIndexChangeBlock:^(NSInteger index) {
            ZHLog(@"1: block --> %@", @(index));
        }];
        [self.segementedControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segementedControl;
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    self.index =1;
    
    switch (segmentCtrl.selectedSegmentIndex) {
        case 0:
            if (self.NewArray.count > 0) {
                [self.NewArray removeAllObjects];
            }
            if (self.RecruitArray.count > 0) {
                [self.RecruitArray removeAllObjects];
            }
            [self.tableView reloadData];
            [self oneWork];
            break;
        case 1:
            NSLog(@"1 clicked");
            if (self.RecruitArray.count > 0) {
                [self.RecruitArray removeAllObjects];
            }
            if (self.headArray.count>0||self.activityArray.count>0) {
                [self.headArray removeAllObjects];
                [self.activityArray removeAllObjects];
            }
            [self.tableView1 reloadData];
        
            [self twoWork];
            break;
            case 2:
            ZHLog(@"2 chicked");
            if (self.headArray.count>0||self.activityArray.count>0) {
                [self.headArray removeAllObjects];
                [self.activityArray removeAllObjects];
            }
            if (self.NewArray.count > 0) {
                [self.NewArray removeAllObjects];
            }
[self.tableView1 reloadData];
            [self threeWork];
            break;
        default:
            break;
    }
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
