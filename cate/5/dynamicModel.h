//
//  dynamicModel.h
//  cate
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dynamicModel : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *timeLable;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *introduce;
@property (nonatomic, retain) NSString *praise;
@property (nonatomic, retain) NSString *subject;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
