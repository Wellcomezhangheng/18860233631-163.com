//
//  AppDelegate.h
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import <UIKit/UIKit.h>
@class loginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

