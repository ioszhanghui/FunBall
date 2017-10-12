//
//  BaseTableViewCell.m
//  ZHFinancialClient
//
//  Created by 正和 on 16/11/7.
//  Copyright © 2016年 正和. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView  Identifier:(NSString*)identifier{
    
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }else{
    
        for(UIView * subView in cell.contentView.subviews){
        
            if ([subView isKindOfClass:[UITextField class]]||[subView isKindOfClass:[UITextView class]]) {
                
                [subView removeFromSuperview];
            }
        
        }
    
    }

    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //cell背景色
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel=[UILabel addLabelWithFrame:CGRectMake(ZHFit(20), 0, ZHFit(82), ZHFit(45)) title:nil titleColor:UIColorWithRGB(0x323232,1.0) font:ZHFont_Title];
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.titleLabel.backgroundColor=ZHClearColor;
        [self.contentView addSubview:self.titleLabel];
        
        ZHLableButton *detailLabel=[ZHLableButton addLabelWithFrame:CGRectMake(self.titleLabel.right, 0,ZHScreenW-self.titleLabel.right-ZHFit(17)-ZHFit(7)-ZHFit(10), ZHFit(45)) title:nil titleColor:UIColorWithRGB(0x656565,1.0) font:ZHFont_Title];
        self.detailLabel = detailLabel;
        self.detailLabel.textAlignment=NSTextAlignmentLeft;
        self.detailLabel.backgroundColor=ZHClearColor;
        self.detailLabel.change=YES;
        [self.contentView addSubview:detailLabel];
  
    }
    return self;
}


/*初始化title*/
-(void)setUpTitleWithArr:(NSArray*)title IndexPath:(NSIndexPath*)indexPath{
    
    NSArray * sectionTitles = [title objectAtIndex:indexPath.section];
    self.titleLabel.text = [sectionTitles objectAtIndex:indexPath.row];
        
    if ([self.titleLabel.text isEqualToString:@"家人是否知晓"]) {
        
        self.titleLabel.width = ZHFit(105);
    }else{
        
        self.titleLabel.width = ZHFit(82);
    }
    
    self.detailLabel.x= self.titleLabel.right;
    self.detailLabel.width=ZHScreenW-self.titleLabel.right-ZHFit(17)-ZHFit(7)-ZHFit(10);
    
}

@end
