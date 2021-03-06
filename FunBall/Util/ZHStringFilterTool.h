//
//  ZHStringFilterTool.h
//  ZHPay
//
//  Created by admin on 16/8/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHStringFilterTool : NSObject

/*日期字符串转化拼接*/
+(NSString*)appendDateWithStartDate:(NSString*)startDate DelayDays:(NSString*)day;

/*计算有行间距的文字宽度或者高度*/
+(CGSize)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font LineHeight:(CGFloat)lineHight  Range:(CGSize)size TextAlignment:(NSTextAlignment)textAlign;

/*给文字设置行间距*/
+(NSAttributedString*)setLabelSpacewithValue:(NSString*)str withFont:(UIFont*)font LineHeight:(CGFloat)lineHight TextAlignment:(NSTextAlignment)textAlign;

/*计算文字高度*/
+(CGSize)computeTextSizeHeight:(NSString*)text Range:(CGSize)size FontSize:(UIFont*)font;

/**
 检验密码位数
 **/
+(BOOL)checkNumOfPassword:(NSString*)pwd;

//base64解密base64加密文件
+(NSData*)Base64DecodeWithCodeString:(NSString*)codeString;

//保存文件的路径
+(void)saveFilePathWithFileName:(NSString*)fileName File:(NSData*)data FilePath:(void(^)(NSString *))filePath;

//判断是不是中文
+ (BOOL)filterByUserNameChinese:(NSString *)userName;

//身份证号码检测正确
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;

/**
 @brief 登陆密码
 */
+ (BOOL)filterByLoginPassWord:(NSString *)passWord;

/**
 * 手机正则匹配
 */
+ (BOOL)filterByPhoneNumber:(NSString *)phone;

/**
 *  身份证号
 */
+ (BOOL) filterByIdentityCard: (NSString *)identityCard;

/**
 *  银行卡卡号
 */
+ (BOOL) filterBybankCardluhmCheck: (NSString *)bankCard;

/**
 *  把格式化的JSON格式的字符串转换成字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 检测手机号是不是正确

 @param phoneNum 手机号
 */
+(BOOL)checkPhoneNumRight:(NSString*)phoneNum;

/**
 @breif 从plist中取出版本号
 */
+ (NSString *)getCurrentVersion;


/**
 判断身份证号是男是女

 @param numberStr 身份证号码

 */
+(BOOL)getIdentityCardSex:(NSString *)numberStr;

/**
 *  字典转换为字符串
*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 */
+ (NSString *)firstCharactor:(NSString *)aString;

/**
 *  按首字母分组排序数组
 */
+ (NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr Model:(NSObject *)model keyStr:(NSString *)keyStr;


/**
 *
 *判断是不是大写字母
 */

+(BOOL)isCatipalLetter:(NSString *)str;

/**
 *
 *判断是不是纯数字
 */

+(BOOL)isPureInt:(NSString*)string;

/**
 *  是不是固定电话号码
 *
 */

+(BOOL)isFixedNumError:(NSString*)fixNum;


//邮箱
+ (BOOL)validateEmail:(NSString *)email;


@end
