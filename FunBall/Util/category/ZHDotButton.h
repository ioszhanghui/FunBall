//
//  ZHDotButton.h
//  ZHMoneyClient
//
//  Created by zhph on 2017/7/18.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapButtonBlock) (UIButton *button);

@interface ZHDotButton : UIButton

/*未读消息数量*/
@property(nonatomic,copy)NSString * messageCount;

/*点击回调*/
@property (copy, nonatomic) TapButtonBlock action;



/**

 @param frame  frame
 @param title title
 @param backgroundColor backgroundColor
 @param titleColor titleColor
 @param tapAction tapAction
 @return button
 */
+ (instancetype)addDotButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                                 font:(UIFont *)font
                                image:(NSString *)image
                            highImage:(NSString *)highImage
                      backgroundColor:(UIColor *)backgroundColor
                            tapAction:(TapButtonBlock)tapAction;

@end
