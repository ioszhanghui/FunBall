//
//  UZGetAddressPhone.m
//  访问通讯录
//
//  Created by 小飞鸟 on 16/5/13.
//  Copyright © 2016年 小飞鸟. All rights reserved.
//

#import "UZGetAddressPhone.h"

#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import "UZAddressPhoneModel.h"


static UZGetAddressPhone * _instance = nil;

@interface UZGetAddressPhone()

@property(nonatomic,strong)NSMutableArray * phoneArray;


@end

@implementation UZGetAddressPhone

+(instancetype)shareAdressBook{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

-(instancetype)init{
    
    if (self=[super init]) {
        
        self.phoneArray=[[NSMutableArray alloc]init];
        
    }
    
    return self;
}


+(void)loadPersonWithVC:(UIViewController*)VC GetSuccessful:(void(^)(NSArray* addressPhoneArr))Success{
    [UZGetAddressPhone shareAdressBook];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            if (granted) {//请求授权页面用户同意授权
                CFErrorRef *error = NULL;
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
                NSArray * phoneArray= [[self class] getAddressBook:addressBook];
                Success(phoneArray);
                CFRelease(addressBook);
            }
        });
    }else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        NSArray * phoneArray= [[self class] getAddressBook:addressBook];
        Success(phoneArray);
        CFRelease(addressBook);
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
               // 更新界面
            [AlertViewTool showAlertWithTitle:@"提示" message:@"请在“设置-正好有钱-通讯录”选项中，允许访问您的通讯录" clickAtIndex:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url])
                    {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
                
            } cancleButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
         

            return;
        });
    }
}


+(NSArray*)getAddressBook:(ABAddressBookRef)addressBook{
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addressBook);
    //进行遍历
    for (NSInteger i=0; i<number; i++) {
        
        NSMutableDictionary * dict =[NSMutableDictionary dictionary];
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        //读取middlename
        NSString *middlename = (__bridge NSString*)ABRecordCopyValue(people, kABPersonMiddleNameProperty);
        
        NSString * actualName =[NSString stringWithFormat:@"%@%@%@",lastName? lastName:@"",middlename? lastName:@"",firstName? firstName:@""];
        [dict setObject:actualName forKey:@"name"];
        
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        CFIndex arrCount=ABMultiValueGetCount(phones);
        
        NSInteger arrayCount=arrCount;
        
        
        NSMutableString * mutableStr=[[NSMutableString alloc]init];
        
        for (NSInteger j=0; j<arrayCount; j++) {
            CFStringRef pNumber = ABMultiValueCopyValueAtIndex(phones,j);
            NSString * phoneNumber = [NSString stringWithFormat:@"%@", (__bridge NSString *)pNumber];
            
            [mutableStr appendString:phoneNumber];
            
            if (j<arrCount && arrCount!=1 && j!=arrCount-1) {
                [mutableStr appendString:@","];
            }
        }
        
        [dict setObject:mutableStr forKey:@"phoneList"];
        
        [[UZGetAddressPhone shareAdressBook].phoneArray addObject:dict];
    }
    
    return [UZGetAddressPhone shareAdressBook].phoneArray;
}


@end
