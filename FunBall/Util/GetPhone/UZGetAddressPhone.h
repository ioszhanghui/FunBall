//
//  UZGetAddressPhone.h
//  访问通讯录
//
//  Created by 小飞鸟 on 16/5/13.
//  Copyright © 2016年 小飞鸟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UZGetAddressPhone : NSObject

+(instancetype)shareAdressBook;

+(void)loadPersonWithVC:(UIViewController*)VC GetSuccessful:(void(^)(NSArray* addressPhoneArr))Success;

@end
