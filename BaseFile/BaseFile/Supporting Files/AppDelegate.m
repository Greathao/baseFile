//
//  AppDelegate.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/6.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import "AppDelegate.h"
#import "LHNTabBarViewController.h"
 
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LHNTabBarViewController * tabbar =  [[LHNTabBarViewController alloc]initWithConfigPlistName:@"APPRootTabbar"];
    tabbar.lh_tabbar.animType = LHTabBarAnimTypeJitter;
 
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:tabbar];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}
 
 

@end
