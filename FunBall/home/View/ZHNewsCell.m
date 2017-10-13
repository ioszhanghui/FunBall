//
//  ZHNewsCell.m
//  FunBall
//
//  Created by zhph on 2017/10/13.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import "ZHNewsCell.h"

@interface ZHNewsCell ()
/*图片*/
@property(nonatomic,strong)UIImageView *iconImageView;
/*标题*/
@property(nonatomic,strong)UILabel * titleLabel;
/*描述*/
@property(nonatomic,strong)UILabel * descLabel;

@end

@implementation ZHNewsCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView  Identifier:(NSString*)identifier{
    
    ZHNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[ZHNewsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图标
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ZHFit(10), (ZHFit(100)-ZHFit(60))/2, ZHFit(110), ZHFit(65))];
        self.iconImageView=imageView;
        imageView.layer.cornerRadius=10;
        imageView.clipsToBounds=YES;
        [self.contentView addSubview:imageView];
        
        //标题
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(imageView.right+ZHFit(8),imageView.top, ZHFit(30), ZHFit(37))];
        self.titleLabel.textColor=UIColorWithRGB(0xCC00FF, 1.0);
        self.titleLabel.font=ZHFontSize(16);
        [self.contentView addSubview:self.titleLabel];
        
        //标题
        self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(imageView.right+ZHFit(8), imageView.bottom-ZHFit(13), ZHFit(30), ZHFit(13))];
        self.descLabel.textColor=UIColorWithRGB(0xCC00FF, 1.0);
        self.descLabel.font=ZHFontSize(13);
        [self.contentView addSubview:self.descLabel];

    }
    
    return self;
}

-(void)setHomeModel:(ZHNewsModel *)homeModel{
    
    _newsModel=homeModel;
    


}



@end
