//
//  WQTabBarController.m
//  魔颜
//
//  Created by abc on 15/9/23.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHHomeViewController.h"
#import "ZHMeViewController.h"
#import "ZHNavigationController.h"
#import "ZHFindViewController.h"

@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加所有的子控制器
    [self setupChildVcs];

    //设置item属性
    [self setItems];
    
}


/**
 *  添加所有的子控制器
 */
- (void)setupChildVcs{
    
    [self addChildVC:[[ZHHomeViewController alloc]init] title:@"首页" imageName:@"Tabbar_home_nol_35x50_" selIamgeName:@"Tabbar_home_sel_35x50_"];
    
    [self addChildVC:[[ZHFindViewController alloc]init] title:@"我的订单" imageName:@"Tabbar_light_nol_35x50_" selIamgeName:@"Tabbar_light_sel_35x50_"];

    [self addChildVC:[[ZHMeViewController alloc]init] title:@"我的" imageName:@"Tabbar_me_nol_35x50_" selIamgeName:@"Tabbar_me_sel_35x50_"];
    
}

-(void)setSelectedIndexChild{

    self.selectedViewController = self.childViewControllers[0];
}
/**
 *  设置item文字属性
 */
- (void)setItems{
    
    //修改UITabBarItem黑线的颜色
    UIImage *colorImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(ZHScreenW, 0.5)];
    [self.tabBar setBackgroundImage:colorImage];
    [self.tabBar setShadowImage:[self imageWithColor:ZHLineColor size:CGSizeMake(ZHScreenW,0.5)]];
    
    //修改tabBar整体背景色
    self.tabBar.backgroundImage = [UIImage imageNamed:@"操作栏-背景"];
}

/**
 *  添加一个子控制器
 *
 *  @param VC            控制器
 *  @param title         标题
 *  @param imageName     图标
 *  @param selImageName  选中的图标
 */
-(void)addChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selIamgeName:(NSString *)selImageName{

    [VC.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC.tabBarItem setSelectedImage:[[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC.tabBarItem setImageInsets:UIEdgeInsetsMake(4, 0, -4, 0)];
    
    ZHNavigationController *nav = [[ZHNavigationController alloc]initWithRootViewController:VC];
    
    // 添加到tabBarController
    [self addChildViewController:nav];
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
