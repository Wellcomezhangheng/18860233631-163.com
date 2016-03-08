//
//  BBSSecondModel.h
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSSecondModel : NSObject
@property (nonatomic, retain) NSString *large;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *momentId;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
