//
//  BBSSecondViewController.m
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//
#define kBBSsecond @"http://apis.znw.me/index.php/Moment/moments/get/channel/mid/1294487/isTable/0/appid/3/mk/4406fd692c2b9d550ef7e807c601c503/p/1"
#import "BBSSecondViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Header.h"
#import "BBSSecondModel.h"
#import <UIImageView+WebCache.h>
#import "BBSSecondTableViewCell.h"
#import "VOSegmentedControl.h"
#import "PersonViewController.h"
#import "dynamicViewController.h"
#import "BBSSecondView.h"
@interface BBSSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) VOSegmentedControl *segementedControl;
@property (nonatomic, strong) VOSegmentedControl *segementedControl1;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) BBSSecondView *headView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *allarray;
@end

@implementation BBSSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //请求头部标题
    [self workOne];
    [self workTwo];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor redColor];
//    self.tableView.rowHeight = 395;
        [self.tableView registerNib:[UINib nibWithNibName:@"BBSSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"BBSSecondView" owner:nil options:nil] lastObject];
    self.headView.frame = CGRectMake(0, 0, kwidth, 180);
    self.tableView.tableHeaderView = self.headView;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBSSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.allarray[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard *dyn = [UIStoryboard storyboardWithName:@"dynamic" bundle:nil];
//    BBSSecondModel *model = self.allarray[indexPath.section][indexPath.row];
//    dynamicViewController *dVC = [[dynamicViewController alloc] init];
//    dVC.momentId = model.momentId;
////    
//    [self.navigationController pushViewController:dVC animated:YES];
//    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *group = self.allarray[indexPath.section];
    BBSSecondModel *model1 = group[indexPath.row];
    CGFloat cellHeight = [BBSSecondTableViewCell getCellHeightWithModel:model1];
    return cellHeight;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kwidth, 100)];
//    [view1 addSubview:self.segementedControl];
//    [view1 addSubview:self.segementedControl1];
//    return view1;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)workOne{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://apis.znw.me/index.php/Channel/channel?" parameters:@{@"mid":@"1294487",@"channelId":self.channelid,@"appid":@"3",@"mk":@"44064406fd692c2b9d550ef7e807c601c503"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
       NSArray *data = dic[@"data"];
        if ([message isEqualToString:@"操作成功"]) {
            self.dictionary = data[0];
           self.headView.des.text = self.dictionary[@"des"];
            NSString *ima = self.dictionary[@"background"];
            NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"@700w_400h_20-10bl.webp" withString:@"@720w_518h_1e_1c.jpg"];
            [self.headView.headImage sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];
            self.headView.renqi.text = [NSString stringWithFormat:@"人气:%@",_dictionary[@"follower_count"]];
            self.headView.neirong.text = [NSString stringWithFormat:@"内容:%@",_dictionary[@"moment_count"]];
            self.headView.biaoti.text = self.dictionary[@"subject"];
                        }
                 [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ZHLog(@"%@",error);
    }];
}
- (void)workTwo{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:[NSString stringWithFormat:@"%@/channelId/%@",kBBSsecond,self.channelid] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
       
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic1 in data) {
                BBSSecondModel *model = [[BBSSecondModel alloc] initWithDictionary:dic1];
                [self.textArray addObject:model];
                
                
//                [self.textArray addObject:dic1[@"text"]];
                NSMutableDictionary *dic2 = dic1[@"fromUser"];
                
                BBSSecondModel *model1 = [[BBSSecondModel alloc] initWithDictionary:dic2];
                [self.nameArray addObject:model1];
                
                //[self.nameArray addObject:dic2[@"name"]];
                for (NSDictionary *dic3 in dic1[@"images"]) {
                    
                    BBSSecondModel *model2 = [[BBSSecondModel alloc] initWithDictionary:dic3];
                    [self.imageArray addObject:model2];
                    
                   // [self.imageArray addObject:dic3[@"large"]];
                }
               
            }
            [self.allarray addObject:self.textArray];
            [self.allarray addObject:self.nameArray];
            [self.allarray addObject:self.imageArray];

             //ZHLog(@"%@",self.textArray);
            //ZHLog(@"%@",self.allarray);
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ZHLog(@"%@",error);
    }];
}
- (NSMutableArray *)allarray{
    if (_allarray == nil) {
        self.allarray = [NSMutableArray new];
    }
    return _allarray;
}
- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        self.imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
- (NSMutableArray *)nameArray{
    if (_nameArray == nil) {
        self.nameArray = [NSMutableArray new];
    }
    return _nameArray;
}
- (NSMutableDictionary *)dictionary{
    if (_dictionary == nil) {
        self.dictionary = [NSMutableDictionary new];
    }
    return _dictionary;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (NSMutableArray *)textArray{
    if (_textArray == nil) {
        self.textArray = [NSMutableArray new];
    }
    return _textArray;
}
- (VOSegmentedControl *)segementedControl{
    if (_segementedControl == nil) {
        self.segementedControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"吃货秀"},
                                                                                @{VOSegmentText: @"社区活动"}]];
        self.segementedControl.contentStyle = VOContentStyleTextAlone;
        self.segementedControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segementedControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.segementedControl.selectedBackgroundColor = self.segementedControl.backgroundColor;
        self.segementedControl.allowNoSelection = NO;
        self.segementedControl.frame = CGRectMake(0, 0, kwidth, 60);
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
    NSInteger index = segmentCtrl.selectedSegmentIndex;
    switch (index) {
        case 0:
            ZHLog(@"0 clicked");
            
            
            
            break;
        case 1:
            NSLog(@"1 clicked");
            
            
            break;
           
        default:
            break;
    }
}
- (VOSegmentedControl *)segementedControl1{
    if (_segementedControl1 == nil) {
        self.segementedControl1 = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"吃货秀"},
                                                                                @{VOSegmentText: @"社区活动"}]];
        self.segementedControl1.contentStyle = VOContentStyleTextAlone;
        self.segementedControl1.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segementedControl1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.segementedControl1.selectedBackgroundColor = self.segementedControl.backgroundColor;
        self.segementedControl1.allowNoSelection = NO;
        self.segementedControl1.frame = CGRectMake(0, 60, kwidth, 40);
        self.segementedControl1.indicatorThickness = 4;
        self.segementedControl1.tag = 1;
        [self.segementedControl1 setIndexChangeBlock:^(NSInteger index) {
            ZHLog(@"1: block --> %@", @(index));
        }];
        [self.segementedControl1 addTarget:self action:@selector(segmentCtrlValuechange1:) forControlEvents:UIControlEventValueChanged];
    }
    return _segementedControl1;
}
- (void)segmentCtrlValuechange1: (VOSegmentedControl *)segmentCtrl{
    NSInteger index = segmentCtrl.selectedSegmentIndex;
    switch (index) {
        case 0:
            ZHLog(@"0 clicked");
            
            
            
            break;
        case 1:
            NSLog(@"1 clicked");
            
            
            break;
        case 3:
            NSLog(@"3 clicked");
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
