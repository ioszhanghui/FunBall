//
//  User.h
//  ShoppingDemo
//
//  Created by zhph on 2017/5/10.
//  Copyright © 2017年 正和普惠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/** 用户名 */
@property (copy, nonatomic)  NSString *realname;

/**身份证号码 */
@property (copy, nonatomic)  NSString *idcardno;

/** 用户ID */
@property(nonatomic , copy)NSString *custno;
/** 用户电话账户 */
@property(nonatomic , copy)NSString *phoneno;
/** 用户电话账户 */
@property(nonatomic , copy)NSString *checkstatus;
/**人脸认证状态*/
@property(nonatomic , copy)NSString * face_state;

/**身份证认证状态*/
@property(nonatomic , copy)NSString * auth_state;

/**订单状态*/
@property(nonatomic , copy)NSString * audit_status;
/*当前账户操作到的步数*/
@property(nonatomic,copy)NSString * stepCount;
/*当前的进件号*/
@property(nonatomic,copy)NSString * apply_loan_key;

/** 是否团贷认证 */
@property (copy, nonatomic)  NSString *istd;

/** 绑定的银行卡 */
@property (copy, nonatomic)  NSString *bankcardno;

/** 贷款金额 */
@property (copy, nonatomic)  NSString *loan_amount;

+(instancetype)userWithInfoDict:(NSDictionary *)dict;

@end
