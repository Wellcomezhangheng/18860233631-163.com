//
//  BBSViewController.m
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSViewController.h"
#import "VOSegmentedControl.h"
#import "Header.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#define kBBS @"http://apis.znw.me/index.php/Channel/newIndex230/mid/1294487/gps/112.426815%2C34.6186/appid/3/cityCode/0379/mk/4406fd692c2b9d550ef7e807c601c503"
@interface BBSViewController ()
@property (nonatomic, strong)VOSegmentedControl *segementedControl;
@property (nonatomic, strong)NSMutableArray *headArray;
@property (nonatomic, strong)NSMutableArray *activityArray;
@end

@implementation BBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segementedControl];
    [self oneWork];
}
- (void)oneWork{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manger GET:kBBS parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dict in data) {
                [self.headArray addObject:dict[@"cate_category_name"]];
                ZHLog(@"%@",self.headArray);
                for (NSDictionary *dictt  in dict[@"channels"]) {
                    [self.activityArray addObject:dictt[@"icon"]];
                                    }
            }

            

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"eeeeeeeeee=%@",error);
    }];
}

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
- (NSMutableArray *)headArray{
    if (_headArray == nil) {
        self.headArray = [[NSMutableArray alloc] init];
    }
    return _headArray;
}
- (NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        self.activityArray = [[NSMutableArray alloc] init];
    }
    return _activityArray;
}
- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    NSInteger index = segmentCtrl.selectedSegmentIndex;
    switch (index) {
        case 0:
            ZHLog(@"0 clicked");
            
            [self first];
            
            break;
        case 1:
            NSLog(@"1 clicked");
            
            [self second];
            break;
            case 2:
            ZHLog(@"2 chicked");
            [self third];
            break;
        default:
            break;
    }
}
- (void)first{
    
}
- (void)second{
    
}
- (void)third{
    
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
