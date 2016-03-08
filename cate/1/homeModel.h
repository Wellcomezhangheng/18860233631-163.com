//
//  homeModel.h
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface homeModel : NSObject
@property (nonatomic, retain)NSString *icon;
@property (nonatomic, retain)NSString *subject;
@property (nonatomic, retain)NSString *channelId;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
