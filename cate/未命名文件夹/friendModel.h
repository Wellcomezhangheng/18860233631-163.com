//
//  friendModel.h
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface friendModel : NSObject
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *simpleTime;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageName;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
