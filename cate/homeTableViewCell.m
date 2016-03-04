//
//  homeTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "homeTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface homeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *subjectLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@end


@implementation homeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(homeModel *)model{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];

    self.subjectLable.text = model.subject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
