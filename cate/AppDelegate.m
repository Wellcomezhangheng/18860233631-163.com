//
//  AppDelegate.m
//  cate
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "homeViewController.h"
#import "friendViewController.h"
#import "messageViewController.h"
#import "mineViewController.h"
#import "loginViewController.h"
#import "WeiboSDK.h"
//#import <//Bmob.h>
//#import <BmobMessageSDK/Bmob.h>

@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end
@interface AppDelegate ()<UITabBarControllerDelegate,WeiboSDKDelegate,WBHttpRequestDelegate>

@end

@implementation AppDelegate
@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    homeViewController *home = [[homeViewController alloc] init];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:home];
    home.navigationItem.title = @"首页";
    homeNVC.tabBarItem.title = @"首页";
    homeNVC.tabBarItem.image = [UIImage imageNamed:@"1"];
    UIImage *homeImage = [UIImage imageNamed:@"2.png"];
    homeNVC.tabBarItem.selectedImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    friendViewController *friend = [[friendViewController alloc] init];
    UINavigationController *friendNVC = [[UINavigationController alloc] initWithRootViewController:friend];
    friend.navigationItem.title = @"发现";
   friendNVC.tabBarItem.title = @"发现";
//    [friendNVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(100, 0)];
    
    friendNVC.tabBarItem.image = [UIImage imageNamed:@"faxian2.png"];
    
    
    UIStoryboard *messageSB = [UIStoryboard storyboardWithName:@"message" bundle:nil];
   
    UINavigationController *messageNVC = messageSB.instantiateInitialViewController;
//    messageSB.navigationItem.title = @"消息";
    messageNVC.tabBarItem.title = @"消息";
    messageNVC.tabBarItem.image = [UIImage imageNamed:@"5.png"];
    UIImage *messageImage = [UIImage imageNamed:@"6.png"];
    messageNVC.tabBarItem.selectedImage = [messageImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"mine" bundle:nil];
    
    UINavigationController *mineNVC = mineSB.instantiateInitialViewController;
    
    mineNVC.tabBarItem.title = @"我的";
    mineNVC.tabBarItem.image = [UIImage imageNamed:@"7.png"];
    UIImage *mineImage = [UIImage imageNamed:@"8.png"];
    mineNVC.tabBarItem.selectedImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarVC.viewControllers=@[homeNVC,friendNVC,messageNVC,mineNVC];
    tabBarVC.delegate = self;
    tabBarVC.tabBar.tintColor=[UIColor redColor];
    tabBarVC.tabBar.barTintColor=[UIColor whiteColor];
     self.window.rootViewController=tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
//    [Bmob registerWithAppKey:kBmob];
        return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:self];
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

@end
