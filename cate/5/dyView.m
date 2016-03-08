//
//  dyView.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "dyView.h"
@interface dyView()
@property (nonatomic, retain) UIButton *Btnname;
@property (nonatomic, retain) UILabel *timeLable;
@property (nonatomic, retain) UIImageView *imageName;
@property (nonatomic, retain) UILabel *introduce;
@property (nonatomic, retain) UILabel *praise;
@property (nonatomic, retain) UIButton *Btnsubject;
@end
@implementation dyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}
- (void)config{
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self addSubview:self.timeLable];
    
}
- (void)setDataDic:(NSDictionary *)dataDic{
//    self.timeLable = dataDic[@"ctime"];
//    self.introduce = dataDic[@"text"];
//    self.praise = dataDic[@"likes_count"];
//    NSDictionary *dic1 = dataDic[@"channel"];
//    self.Btnsubject = dic1[@"subject"];
//    NSDictionary *dic2 = dict[@"fromUser"];
//    self.name = dic2[@"name"];
//    NSArray *arr1 = dict[@"images"];
//    NSDictionary *dic3 = arr1[0];
//    self.imageName = dic3[@"large"];
    self.timeLable.text = dataDic[@"ctime"];
    self.introduce.text = dataDic[@"text"];



}
    
    
    
@end
