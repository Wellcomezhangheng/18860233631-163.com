//
//  BBSSecondTableViewCell.h
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSSecondModel.h"
@interface BBSSecondTableViewCell : UITableViewCell

@property (nonatomic, strong)BBSSecondModel *model;
+ (CGFloat)getCellHeightWithModel:(BBSSecondModel *)model;
@end
