//
//  User.m
//  ShoppingDemo
//
//  Created by zhph on 2017/5/10.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)userWithInfoDict:(NSDictionary *)dict{

    User *info = [[User alloc]init];
    if (!dict) {
        return info;
    }
    info.custno = [NSString stringWithRequestDicValue:dict[@"custno"] defultValue:@""];
    info.idcardno = [NSString stringWithRequestDicValue:dict[@"idcardno"] defultValue:@""];
    info.phoneno =[NSString stringWithRequestDicValue:dict[@"phoneno"] defultValue:@""];
    info.face_state =[NSString stringWithRequestDicValue:dict[@"face_state"] defultValue:@"F"];
    info.auth_state =[NSString stringWithRequestDicValue:dict[@"auth_state"] defultValue:@"F"];
    info.apply_loan_key=[NSString stringWithRequestDicValue:dict[@"apply_loan_key"] defultValue:@""];
    info.realname=[NSString stringWithFormat:@"%@",dict[@"realname"]];
    info.audit_status=[NSString stringWithFormat:@"%@",dict[@"audit_status"]];
    info.istd = [NSString stringWithFormat:@"%@",dict[@"istd"]];
    info.bankcardno = [NSString stringWithFormat:@"%@",dict[@"bankcardno"]];
    info.loan_amount = [NSString stringWithFormat:@"%@",dict[@"loan_amount"]];
    
    return info;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.custno forKey:@"custno"];
    [coder encodeObject:self.idcardno forKey:@"idcardno"];
    [coder encodeObject:self.phoneno forKey:@"phoneno"];
    [coder encodeObject:self.face_state forKey:@"face_state"];
    [coder encodeObject:self.auth_state forKey:@"auth_state"];
    [coder encodeObject:self.apply_loan_key forKey:@"apply_loan_key"];
    [coder encodeObject:self.realname forKey:@"realname"];
    [coder encodeObject:self.audit_status forKey:@"audit_status"];
    [coder encodeObject:self.istd forKey:@"istd"];
    [coder encodeObject:self.bankcardno forKey:@"bankcardno"];
    [coder encodeObject:self.loan_amount forKey:@"loan_amount"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.custno = [coder decodeObjectForKey:@"custno"];
        self.idcardno = [coder decodeObjectForKey:@"idcardno"];
        self.phoneno = [coder decodeObjectForKey:@"phoneno"];
        self.auth_state = [coder decodeObjectForKey:@"auth_state"];
        self.face_state = [coder decodeObjectForKey:@"face_state"];
        self.apply_loan_key = [coder decodeObjectForKey:@"apply_loan_key"];
        self.realname = [coder decodeObjectForKey:@"realname"];
        self.audit_status = [coder decodeObjectForKey:@"audit_status"];
        self.istd = [coder decodeObjectForKey:@"istd"];
        self.bankcardno = [coder decodeObjectForKey:@"bankcardno"];
        self.loan_amount = [coder decodeObjectForKey:@"loan_amount"];

    }
    return self;
}

@end
