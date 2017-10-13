//
//  ZHBaseViewController.m
//  ZHPay
//
//  Created by 正和 on 16/8/31.
//  Copyright © 2016年 正和. All rights reserved.
//

#import "ZHBaseViewController.h"

#import "UITableView+Extension.h"
#import "UIView+CLKeyboardOffsetView.h"
#import <SVProgressHUD.h>
#import "SupportedInterfaceOrientations.h"

@interface ZHBaseViewController ()

@end

@implementation ZHBaseViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    //页面离开，让弹框隐藏
    [SVProgressHUD dismiss];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 打开键盘补偿视图
    [self.view openKeyboardOffsetView];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // 关闭键盘补偿视图
    [self.view closeKeyboardOffsetView];
}

- (NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZHBackgroundColor;
    self.edgesForExtendedLayout=UIRectEdgeNone;
 }



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

#pragma mark 请求数据
- (void)requestData{


}

//创建tableView
- (void)setupTableView{
    
    UITableView *tableView = [UITableView initWithGroupTableView:CGRectMake(0, 0, ZHScreenW, ZHScreenH-64) withDelegate:self];
    self.tableView = tableView;
    tableView.sectionHeaderHeight = 0.01;
    tableView.sectionFooterHeight=ZHFit(10);
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor=UIColorWithRGB(0xe8e8e8, 1.0);
    tableView.backgroundColor = ZHBackgroundColor;
    [self.view addSubview:tableView];    
    //去掉头部留白
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = view;
    
}

//设置tableView的组尾
- (void)setupBaseFooterWithTitle:(NSString*)title{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ZHFit(90))];
    self.tableView.tableFooterView = view;
    view.backgroundColor=ZHClearColor;
    
    UIButton *btn = [UIButton addCustomButtonWithFrame:CGRectMake(ZHFit(12), ZHFit(10), ZHScreenW - ZHFit(12)*2, ZHFit(45)) title:title backgroundColor:ZHThemeColor titleColor:[UIColor whiteColor] tapAction:^(UIButton *button) {
        [self nextStep];
    }];
    btn.titleLabel.font = ZHFont_BtnTitle;
    self.footBtn = btn;
    [view addSubview:btn];
}

//点击组尾后的操作
- (void)nextStep{

}

#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellWithTableView:tableView Identifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return ZHFit(45);
}

#pragma mark - Table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

//设置分割线上下去边线，
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets UIEgde = UIEdgeInsetsMake(0, ZHFit(12), 0, 0);
    
    [cell setSeparatorInset:UIEgde];

}

@end
