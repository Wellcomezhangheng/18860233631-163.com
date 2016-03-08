//
//  BBSSecondTableViewCell.m
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSSecondTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Header.h"
@interface BBSSecondTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *largeImage;

@property (nonatomic, strong) UILabel *textLable;
@end
@implementation BBSSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.textLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 350, kwidth, 100)];
        self.textLable.numberOfLines = 0;
    self.textLable.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:self.textLable];
    
    
}
- (void)setModel:(BBSSecondModel *)model{
    self.nameLable.text = model.name;
    CGFloat height = [[self class] getTextHeightWithText:model.text];
    CGRect frame = self.textLable.frame;
    frame.size.height = height;
    self.textLable.frame = frame;
    
    self.textLable.text = model.text;

    ZHLog(@"%.f",self.textLable.frame.size.height);
    NSString *ima = model.large;
    NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"webp" withString:@"png"];
    [self.largeImage sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];
   
}

+ (CGFloat)getCellHeightWithModel:(BBSSecondModel *)model{
    CGFloat textHeight = [[self class] getTextHeightWithText:model.text];
   
    return textHeight + 350;
}
+ (CGFloat)getTextHeightWithText:(NSString *)textLable{
    CGRect text = [textLable boundingRectWithSize:CGSizeMake(kwidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil ];
    return text.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
