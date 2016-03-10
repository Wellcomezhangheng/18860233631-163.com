//
//  friendModel.m
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "friendModel.h"

@implementation friendModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.imageName = dict[@"image_lmobile"];
        self.address = dict[@"address"];
        self.simpleTime = dict[@"simpleTime"];
        self.title = dict[@"title"];
        self.sourceId = dict[@"id"];
    }
    return self;
}

@end
