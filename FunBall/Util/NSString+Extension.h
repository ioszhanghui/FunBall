//
//  NSString+Extension.h
//  魔颜
//
//  Created by Meiyue on 16/1/14.
//  Copyright © 2016年 Meiyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  自适应高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 返回的高度
 */
- (float) heightWithFont: (UIFont *) font withinWidth: (float) width;

- (float) widthWithFont: (UIFont *) font;


/**
 兼容iOS7 判断是否包含某个字符

 @param str 字符串
 @return 返回的bool值
 */
- (BOOL)containsString:(NSString *)str;

+(NSString *)getIndexStringWithindex:(NSInteger)index FromString:(NSString*)string;

+(NSString*)changeLocation:(NSString*)str;


//String 转化成 NSMutableAttributedString
+(NSMutableAttributedString*)changeStringToAttributeString:(NSString*)str Range:(NSRange)range Color:(UIColor*)color;


//替换字符串
+(NSString*)replaceStringWithSpaceChar:(NSString*)str;

@end
