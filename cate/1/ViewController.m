//
//  ViewController.m
//  cate
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "ViewController.h"
#import "VOSegmentedControl.h"
#import "SCNavTabBarController.h"
#import "PersonViewController.h"
#import "Header.h"
#import "homeViewController.h"
@interface ViewController ()
@property (nonatomic, strong) VOSegmentedControl *segementedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    //添加分段选择
    [self.view addSubview:self.segementedControl];
  
}
- (VOSegmentedControl *)segementedControl{
    if (_segementedControl == nil) {
        self.segementedControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"主题社区"},
                                                                                @{VOSegmentText: @"个人"}]];
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
        default:
            break;
    }
}
- (void)first{
    homeViewController *oneVC = [[homeViewController alloc] init];
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (void)second{
    
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
