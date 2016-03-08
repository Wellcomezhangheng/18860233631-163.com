//
//  dynamicViewController.h
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dynamicViewController : UIViewController
@property (nonatomic, strong)NSString *momentId;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIImageView *imagee;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *praiseLable;
@property (nonatomic, strong) NSMutableArray *array;
@end
