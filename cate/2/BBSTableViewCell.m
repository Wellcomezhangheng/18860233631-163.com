//
//  BBSTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Header.h"
@interface BBSTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UIImageView *ima;

@end
@implementation BBSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(BBSModel *)model{
    self.lable.text = model.subject;
    NSString *ima = model.imagee;
    NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
    [self.ima sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
