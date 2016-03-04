//
//  homeModel.m
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "homeModel.h"

@implementation homeModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.icon = dict[@"icon"];
        self.subject = dict[@"subject"];
    }
    return self;
}
@end
