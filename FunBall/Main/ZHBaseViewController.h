//
//  ZHBaseViewController.h
//  ZHPay
//
//  Created by 正和 on 16/8/31.
//  Copyright © 2016年 正和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


#define TextFiedFrame CGRectMake(ZHFit(100), 0, ZHScreenW-ZHFit(100)-ZHFit(7), ZHFit(45))


#define BaseRighText(section,row)   ((BaseTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]]).detailLabel.text

#define BaseCell(section,row)   ((BaseTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]])

#define SystemCell(section,row)   ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]])

#define ArrowView  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"向右icon"]]

#define LockView  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lock"]]

typedef enum : NSUInteger {
    RequestBlock, //请求回调
    CommitBlock, //提交回调
    AddressReqestBlock// 单独是填了地址信息 或者联系人信息
} BlockType;

@interface ZHBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/** 标题数组 */
@property (strong, nonatomic) NSMutableArray *titles;

/** 组尾 */
@property (strong, nonatomic) UIButton *footBtn;

/** tableView */
@property (strong, nonatomic) UITableView *tableView;

/** 进件号 */
@property (copy, nonatomic)  NSString *loanKey;

/**客户类型*/
@property (copy, nonatomic) NSString *cust_type;

/** 请求下来的数据的字典 */
@property (strong, nonatomic)  NSMutableDictionary *dataDictionary;

/*点击方法*/
@property(nonatomic,copy)void(^commitDidClick)(BlockType type);


/*创建tableView*/
- (void)setupTableView;

/*创建组尾*/
- (void)setupBaseFooterWithTitle:(NSString*)title;

/*请求数据*/
- (void)requestData;


@end
