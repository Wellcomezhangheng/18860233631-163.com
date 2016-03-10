//
//  messageTwoViewController.m
//  cate
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "messageTwoViewController.h"
#import "Header.h"
@interface messageTwoViewController ()

@end

@implementation messageTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.title = @"消息";
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kwidth, kheight-144)];
    imageView.image = [UIImage imageNamed:@"geren.png"];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, kheight-144, kwidth, 44)];
    lable.text = @"sorry,您暂时还没有数据";
    lable.textAlignment = NSTextAlignmentCenter;
    
    [imageView addSubview:lable];
    
    [self.view addSubview:imageView];
    
    
    
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
