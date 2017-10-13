//
//  ZHHomeViewController.m
//  FunBall
//
//  Created by zhph on 2017/10/12.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import "ZHHomeViewController.h"
#import "SDCycleScrollView.h"

@interface ZHHomeViewController ()<SDCycleScrollViewDelegate>
/*滚动视图*/
@property(nonatomic,strong)SDCycleScrollView * sd;

@end

@implementation ZHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"首页";
    
    [self setupTableView];
    [self configUI];
    
}

#pragma mark
-(void)configUI{
    self.sd = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ZHScreenW, ZHFit(150))
                                                            delegate:self
                                                    placeholderImage:nil];
    
    self.sd.localizationImageNamesGroup = @[@"zu1.jpg",
                                                       @"zu2.jpg",
                                                       @"zu3.jpg",@"zu4.jpg"];
    self.sd.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
    self.sd.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;// 翻页 右下角
    self.sd.titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];// 图片对应的标题的 背景色。（因为没有设标题）
    
    // ok xib 自动布局都可以。还是很不错的。
    [SDCycleScrollView clearImagesCache];// 清除缓存。
    self.sd.titlesGroup = @[@"世预-梅西带帽 阿根廷3-1逆转出线",@"世预-暴力鸟破门 巴西3-0送智利出局",
                                       @"球员场上变现竟和这项数据挂钩",
                                       @"新浪《一球成名3》激情开启"];
    
    self.tableView.tableHeaderView=self.sd;

}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

@end
