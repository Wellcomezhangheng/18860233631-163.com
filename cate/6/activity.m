//
//  activity.m
//  cate
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "activity.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
@interface activity()
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *introduceLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
@property (nonatomic, strong)UILabel *activityLable;



@end
@implementation activity
- (void)awakeFromNib{
    
    
    [self.mainScroll addSubview:self.activityLable];
}

- (void)setDataDic:(NSDictionary *)dataDic{

    self.introduceLable.text = dataDic[@"title"];
   self.timeLable.text = [NSString stringWithFormat:@"%@到%@ %@",dataDic[@"begin_time"],dataDic[@"end_time"],dataDic[@"address"]];
    [self.imageName sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholderImage:nil];
    self.distanceLable.text = [NSString stringWithFormat:@"%@ %@",dataDic[@"gps"][0],dataDic[@"gps"][1]];
    CGFloat height = [[self class] getTextHeightWithText:dataDic[@"content"]];
    CGRect frame = self.activityLable.frame;
    frame.size.height = height;
    self.activityLable.frame = frame;
    
    self.activityLable.text = dataDic[@"content"];
    self.activityLable.numberOfLines = 0;
    self.mainScroll.contentSize = CGSizeMake(kwidth, 490+_activityLable.frame.size.height);
}
- (UILabel *)activityLable{
    if (_activityLable == nil) {
        self.activityLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 490, kwidth-10, kheight)];
    }
    return _activityLable;
}
+ (CGFloat)getTextHeightWithText:(NSString *)textLable{
    CGRect text = [textLable boundingRectWithSize:CGSizeMake(kwidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil ];
    return text.size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
