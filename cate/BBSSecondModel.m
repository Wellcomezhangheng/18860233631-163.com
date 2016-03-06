//
//  BBSSecondModel.m
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSSecondModel.h"

@implementation BBSSecondModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
//        self.name = dict[@"name"];
        
        
        self.text = dict[@"text"];
//        self.large = dict[@"large"];
        
        NSMutableDictionary *dic1 = dict[@"fromUser"];
        self.name = dic1[@"name"];
        NSMutableArray *arr1 = dict[@"images"];
        NSDictionary *dic2 = arr1[0];
        self.large = dic2[@"large"];
//        NSLog(@"%@",self.large);
        
    }
    return self;
}
@end
