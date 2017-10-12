//
//  NSString+Extension.m
//  魔颜
//
//  Created by Meiyue on 16/1/14.
//  Copyright © 2016年 Meiyue. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (float) heightWithFont: (UIFont *) font withinWidth: (float) width
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return ceil(textRect.size.height);
}

- (float) widthWithFont: (UIFont *) font
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect.size.width + 10;
}


- (BOOL)containsString:(NSString *)str{
    
    return [self rangeOfString: str].location != NSNotFound;
}

#pragma mark 替换文件
+(NSString*)changeLocation:(NSString*)str{
    
    NSString * addressStr = [NSString stringWithFormat:@"%@,%@",[[str componentsSeparatedByString:@","] lastObject],[[str componentsSeparatedByString:@","] firstObject]];
    
    return addressStr;
}

+(NSString *)getIndexStringWithindex:(NSInteger)index FromString:(NSString*)string{
    NSArray * array = [string componentsSeparatedByString:@","];
    NSString * str = @"";
    if (index<=array.count-1) {
        str = array[index];
    }
    return str;
}

#pragma mark 设置NSMutableAttributedString
+(NSMutableAttributedString*)changeStringToAttributeString:(NSString*)str Range:(NSRange)range Color:(UIColor*)color{

    NSMutableAttributedString * attributeStr =[[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributeStr;
}

//银行卡添加空格
+(NSString*)replaceStringWithSpaceChar:(NSString*)str{
    
    NSString *tempStr=str;

    NSInteger size =(tempStr.length / 4);

    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    
    for (int n = 0;n < size; n++){
        
        if (n==size-2) {
            
             [tmpStrArr addObject:@"****"];
            
        }else{
        
            [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n*4, 4)]];
        }
    }

    [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4, (tempStr.length % 4))]];

    tempStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tempStr;
    
}

@end
