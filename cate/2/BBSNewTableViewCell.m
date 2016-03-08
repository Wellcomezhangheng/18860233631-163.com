//
//  BBSNewTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSNewTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface BBSNewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end
@implementation BBSNewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(BBSModel *)model{
    self.subject.text = model.subject;
    self.des.text = model.des;
    NSString *ima = model.icon;
    NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
