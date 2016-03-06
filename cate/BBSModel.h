//
//  BBSModel.h
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSModel : NSObject
//分区标题
@property (nonatomic, retain)NSString *headName;
@property (nonatomic, retain)NSString *imagee;
@property (nonatomic, retain)NSString *subject;
@property (nonatomic, retain)NSString *channelId;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
