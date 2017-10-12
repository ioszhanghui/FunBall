//
//  ZHNavigationViewController.m
//  ZHPayment
//
//  Created by admin on 16/8/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ZHNavigationController.h"

@interface ZHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZHNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 清空弹出手势的代理，就可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = self;

}
#pragma mark 边缘手势处理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    return YES;
}

+ (void)initialize
{
    [self setupNavigationBar];
    [self setupBarBtnItem];
    
}

+(void)setupNavigationBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部背景"] forBarMetrics:UIBarMetricsDefault];
    //修改NavigationBar黑线的颜色
    [navBar setShadowImage:[self imageWithColor:ZHLineColor size:CGSizeMake(ZHScreenW, 0.5)]];
    
    
    // title
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = UIColorWithRGB(0x282828,1.0);
    attrDict[NSFontAttributeName] = ZHFontSize(18);
    [navBar setTitleTextAttributes:attrDict];
}

+(void)setupBarBtnItem
{
    UIBarButtonItem *barBtnItem = [UIBarButtonItem appearance];
    // nor
    NSMutableDictionary *norAttrDict = [NSMutableDictionary dictionary];
    norAttrDict[NSForegroundColorAttributeName] = UIColorWithRGB(0x323232,1.0);
    [barBtnItem setTitleTextAttributes:norAttrDict forState:UIControlStateNormal];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 0) {
        
        // 默认每个push进来的控制器左右都有返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    }
}

-(void)back
{
    [self popViewControllerAnimated:YES];
 
}

-(void)backToMainMenu {
    [self popToRootViewControllerAnimated:YES];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
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
