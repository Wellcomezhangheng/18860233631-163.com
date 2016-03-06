//
//  BBSSecondTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSSecondTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface BBSSecondTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *largeImage;
@property (weak, nonatomic) IBOutlet UILabel *textLable;

@end
@implementation BBSSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(BBSSecondModel *)model{
    self.nameLable.text = model.name;
    self.textLable.text = model.text;
    NSString *ima = model.large;
    NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"webp" withString:@"png"];
    [self.largeImage sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];
    NSLog(@"%@",self.nameLable.text);
    NSLog(@"%@",self.textLable.text);
    NSLog(@"%@",self.largeImage);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
