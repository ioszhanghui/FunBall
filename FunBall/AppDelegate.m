//
//  AppDelegate.m
//  FunBall
//
//  Created by zhph on 2017/10/12.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController=[ZHTabBarController new];
    
    return YES;
}


@end
