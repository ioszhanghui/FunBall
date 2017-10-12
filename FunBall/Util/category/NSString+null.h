//
//  NSString+null.h
//  WeiZaZhi
//
//  Created by 联动 on 15/5/30.
//  Copyright (c) 2015年 liandongzaixian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (null)


/**截断字符串*/
+(NSString*)cutStringWithComma:(NSString*)str;
/**是否同户籍*/
+(BOOL)stringTextWithRequestDicValue:(id)dicValue;
/*省市区字符串截断*/
+(NSString*)stringWithRequestProvinceValue:(NSString*)provinceValue CityValue:(NSString*)cityValue AreaValue:(NSString*)areaValue;

/*TextField*/
+(NSString*)stringFieldTextWithRequestDicValue:(id)dicValue SelectValue:(NSString*)selectValue;
/**
 上传服务器的值

 @param dicValue 请求的值
 @param selectValue 选择的值
 @return 上传的值
 */
+(NSString*)stringWithRequestDicValue:(id)dicValue SelectValue:(NSString*)selectValue;

/*label的内容  selectValue 和请求的内容  dicValue*/

/**
 获取Label的内容

 @param dicValue 请求的值
 @param selectValue 选择的值
 @return 返回显示的值
 */
+(NSString*)stringLabelTextWithRequestDicValue:(id)dicValue SelectValue:(NSString*)selectValue;

+(NSString*)stringWithRequestDicValue:(id)dicValue defultValue:(NSString*)defultValue;


+(BOOL)stringWithRequestDicValue:(id)dicValue;

//过滤
+(NSString *)stringWithFashionRequestDicValue:(id)dicValue defultValue:(NSString *)defultValue;

@end
