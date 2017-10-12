//
//  ZHDotButton.m
//  ZHMoneyClient
//
//  Created by zhph on 2017/7/18.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import "ZHDotButton.h"

@implementation ZHDotButton

- (instancetype)init
{
    if(self = [super init])
    {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)btnClick:(UIButton *)button
{
    if(self.action)
    {
        self.action(self);
    }
}

//创建文字和图片按钮
+ (instancetype)addDotButtonWithFrame:(CGRect)frame
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                   backgroundColor:(UIColor *)backgroundColor
                         tapAction:(TapButtonBlock)tapAction
{
    ZHDotButton *btn = [ZHDotButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;    
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;

    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    if (highImage) {
        
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    
    btn.action = tapAction;
    return btn;
    
    
}

#pragma mark 显示未读消息数量
-(void)showMessageCount:(NSString*)count{
    
    [[self viewWithTag:3000] removeFromSuperview];
    //215 192 153
    UILabel * label =[UILabel addLabelWithFrame:CGRectMake(ZHFit(48)-ZHFit(22),0, ZHFit(22), ZHFit(14)) title:count titleColor:ZHThemeColor font:ZHFontSize(11)];
    label.textAlignment=NSTextAlignmentCenter;
    label.layer.cornerRadius=ZHFit(7);
    label.clipsToBounds=YES;
    label.tag=3000;
    label.backgroundColor=[UIColor clearColor];
    [self addSubview:label];
}

-(void)setMessageCount:(NSString *)messageCount{

    _messageCount=messageCount;
    NSInteger count =[messageCount integerValue];
    
    if (count>0) {
        
        [self showMessageCount:messageCount];
        [self setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateHighlighted];
        self.width=ZHFit(48);
    }else{
    
        [self hiddenMessageCount];
        [self setImage:[UIImage imageNamed:@"无消息"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"无消息"] forState:UIControlStateHighlighted];
        self.width=ZHFit(33);
    }
}

#pragma mark 隐藏消息数量
-(void)hiddenMessageCount{

    [[self viewWithTag:3000] removeFromSuperview];

}

@end
