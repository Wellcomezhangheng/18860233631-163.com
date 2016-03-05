//
//  BBSModel.m
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "BBSModel.h"

@implementation BBSModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.subject = dict[@"subject"];
        self.imagee = dict[@"background"];
         self.headName = dict[@"cate_category_name"];
    }
    return self;
}
@end
