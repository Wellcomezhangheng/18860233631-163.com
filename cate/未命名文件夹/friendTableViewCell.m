//
//  friendTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "friendTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Header.h"
@interface friendTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
@implementation friendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(friendModel *)model{
    self.address.text = model.address;
    self.introduce.text = model.title;
    [self.imageName sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:nil];
    self.timeLable.text = model.simpleTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
