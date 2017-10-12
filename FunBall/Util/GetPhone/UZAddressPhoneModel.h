//
//  UZAddressPhoneModel.h
//  访问通讯录
//
//  Created by 小飞鸟 on 16/5/13.
//  Copyright © 2016年 小飞鸟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZAddressPhoneModel : NSObject

//获取当前联系人名字
@property(nonatomic,copy)NSString*firstName;

//获取当前联系人姓氏
@property(nonatomic,copy)NSString*lastName;

//获取当前联系人中间名
@property(nonatomic,copy)NSString*middleName;

//获取当前联系人的电话 数组
@property(nonatomic,copy)NSArray*phoneArr;


@end
