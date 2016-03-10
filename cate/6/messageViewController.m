//
//  messageViewController.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "messageViewController.h"
@interface messageViewController ()


@end

@implementation messageViewController


//- (void)btn1:(id)sender{
//    messageTwoViewController *messVC = [[messageTwoViewController alloc] init];
//    [self.navigationController pushViewController:messVC animated:YES];
//}
//- (void)btn2:(id)sender{
//    messageTwoViewController *messVC = [[messageTwoViewController alloc] init];
//    [self.navigationController pushViewController:messVC animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
   
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





- (IBAction)btn1:(id)sender {
    messageTwoViewController *twoVC = [[messageTwoViewController alloc] init];
  [self.navigationController pushViewController:twoVC animated:YES];
}

- (IBAction)btn2:(id)sender {
    messageTwoViewController *twoVC = [[messageTwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}

@end
