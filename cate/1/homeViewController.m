//
//  homeViewController.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//


#import "homeViewController.h"
#import "VOSegmentedControl.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "homeTableViewCell.h"
#import "PullingRefreshTableView.h"
#import "homeModel.h"
#import "Header.h"
#import "BBSSecondViewController.h"
#import "JRSegmentViewController.h"
#import "firstViewController.h"
#import "SecondViewController.h"
#import "thirdViewController.h"
#import "ProgressHUD.h"
#define kHomeTheme @"http://apis.znw.me/index.php/Channel/channelsUpdate/mid/1294487/appid/3/mk/4406fd692c2b9d550ef7e807c601c503/p/1"
@interface homeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger _pageCount;   //请求的页数
}


@property (nonatomic, strong) VOSegmentedControl *segementedControl;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)UIView *footView;
@property (nonatomic, strong) UIView *view1;
@end

@implementation homeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    

     [self getOneModel];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
   self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight)];

        self.tableView.tableFooterView = self.footView;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"homeTableViewCell" bundle:nil] forCellReuseIdentifier:@"celll"];
   
    
       [self foot];
    
    //添加分段选择
    [self.view addSubview:self.segementedControl];

    
}


- (UIView *)footView{
    if (_footView == nil) {
        self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
    }
    return _footView;
}


- (void)foot{
       self.tableView.tableFooterView = self.footView;
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kwidth, 60)];
//    lable.textAlignment = NSTextAlignmentCenter;
//    
//    lable.text = @"探索更多吃货社区";
//    lable.textColor = [UIColor redColor];
//    [self.footView addSubview:lable];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kwidth, 60)];
    [btn setTitle:@"探索更多吃货社区" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btn addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:btn];
    
    
    
}
- (void)chick{
//    BBSViewController *BBS = [[BBSViewController alloc] init];
//    [self.navigationController pushViewController:BBS animated:YES];
    
    
    firstViewController *firstVC = [[firstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    thirdViewController *thirdVC = [[thirdViewController alloc] init];
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor colorWithRed:18.0f/255 green:50.0f/255 blue:110.0f/255 alpha:1.0f];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    
    [vc setViewControllers:@[firstVC, secondVC, thirdVC]];
    [vc setTitles:@[@"推荐", @"最新", @"招募"]];
    
    [self.navigationController pushViewController:vc animated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    homeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"celll" forIndexPath:indexPath];
    if (self.segementedControl.selectedSegmentIndex == 0) {
        cell.model = _array[indexPath.row];
    }
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segementedControl.selectedSegmentIndex == 0) {
        homeModel *model = self.array[indexPath.row];
        UIStoryboard *BBSs = [UIStoryboard storyboardWithName:@"BBSsecond" bundle:nil];
        
        BBSSecondViewController *bbs = BBSs.instantiateInitialViewController;
        bbs.channelid = model.channelId;
        
        [self.navigationController pushViewController:bbs animated:YES];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
               return self.array.count;

}



- (void)getOneModel{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manger GET:kHomeTheme parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //ZHLog(@"downloadProgress=%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //ZHLog(@"responseObject=%@",responseObject);
       
        
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        if (self.array .count >0) {
            [self.array removeAllObjects];
        }
        if ([message isEqualToString:@"操作成功"]) {
            NSArray *data = dic[@"data"];
                        for (NSDictionary *dictt in data) {
                homeModel *model = [[homeModel alloc] initWithDictionary:dictt];
               
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
          
        }
       

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"error = %@",error);
    }];
    [self.tableView reloadData];
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    
    switch (segmentCtrl.selectedSegmentIndex) {
        case 0:
            ZHLog(@"0 clicked");
            
[self.view1 removeFromSuperview];
           
            [self first];
//            [self.tableView reloadData];
            
            break;
            case 1:
            NSLog(@"1 clicked");
            
[self.tableView removeFromSuperview];
            [self second];
            
            break;
        default:
            break;
    }
}
- (void)first{
    
     [self getOneModel];
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, kwidth, kheight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}
- (void)second{
  
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kwidth, 200)];
    lable.text = @"sa5s4a5s4a5";
    [self.view1 addSubview:lable];
    [self.view addSubview:self.view1];
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, kwidth, kheight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.rowHeight = 50;
        [self.view addSubview:self.tableView];
        
    }
    return _tableView;
}
- (UIView *)view1{
    if (_view1 == nil) {
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 104, kwidth, kheight)];
        
    }
    return _view1;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
        
    }
    return _array;
}


- (VOSegmentedControl *)segementedControl{
    if (_segementedControl == nil) {
        self.segementedControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"主题社区"},
  @{VOSegmentText: @"个人"}]];
        self.segementedControl.selectedSegmentIndex = 0;
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
