//
//  dynamicModel.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "dynamicModel.h"

@implementation dynamicModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.timeLable = dict[@"ctime"];
        self.introduce = dict[@"text"];
        self.praise = dict[@"likes_count"];
        NSDictionary *dic1 = dict[@"channel"];
        self.subject = dic1[@"subject"];
        NSDictionary *dic2 = dict[@"fromUser"];
        self.name = dic2[@"name"];
        NSArray *arr1 = dict[@"images"];
        NSDictionary *dic3 = arr1[0];
        self.imageName = dic3[@"large"];
        
    }
    return self;
}
@end
