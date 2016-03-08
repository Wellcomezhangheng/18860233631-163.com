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
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    homeViewController *home = [[homeViewController alloc] init];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:home];
    home.navigationItem.title = @"首页";
    homeNVC.tabBarItem.title = @"首页";
    homeNVC.tabBarItem.image = [UIImage imageNamed:@"home.png"];
    
    friendViewController *friend = [[friendViewController alloc] init];
    UINavigationController *friendNVC = [[UINavigationController alloc] initWithRootViewController:friend];
    friend.navigationItem.title = @"朋友";
    friendNVC.tabBarItem.title = @"朋友                                                                                                                                                                    ";
    friendNVC.tabBarItem.image = [UIImage imageNamed:@"friend.png"];
    
    messageViewController *message = [[messageViewController alloc] init];
    UINavigationController *messageNVC = [[UINavigationController alloc] initWithRootViewController:message];
    message.navigationItem.title = @"消息";
    messageNVC.tabBarItem.title = @"消息";
    messageNVC.tabBarItem.image = [UIImage imageNamed:@"message.png"];
    
    mineViewController *mine = [[mineViewController alloc] init];
    UINavigationController *mineNVC = [[UINavigationController alloc] initWithRootViewController:mine];
    mine.navigationItem.title = @"我的";
    mineNVC.tabBarItem.title = @"我的";
    mineNVC.tabBarItem.image = [UIImage imageNamed:@"mine.png"];

    tabBarVC.viewControllers=@[homeNVC,friendNVC,messageNVC,mineNVC];
    tabBarVC.delegate = self;
    tabBarVC.tabBar.tintColor=[UIColor redColor];
    tabBarVC.tabBar.barTintColor=[UIColor whiteColor];
     self.window.rootViewController=tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

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

@end
