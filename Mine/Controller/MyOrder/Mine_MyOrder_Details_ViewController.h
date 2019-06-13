//
//  Mine_MyOrder_Details_ViewController.h
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_ViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    MineMyOrderDetailsUser,
    MineMyOrderDetailsShop,
    MineMyOrderDetailsHouseKeeping,
    MineMyOrderDetailsRunErrands,
} MineMyOrderDetailsStyle;
@interface Mine_MyOrder_Details_ViewController : Basic_ViewController

@property (nonatomic, assign) MineMyOrderDetailsStyle MyOrderDetailsStyle;

@property (nonatomic, strong) NSString *OrderID;

@end

NS_ASSUME_NONNULL_END
