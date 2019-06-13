//
//  Mine_MyOrder_ButtonAndTableView_View.h
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MyOrderViewStyleHouseKeeping,
    MyOrderViewStyleRunErrands,
    MyOrderViewStyleShop,
} MineMyOrderStyle;

@interface Mine_MyOrder_ButtonAndTableView_View : UIView
/**
 *滑动菜单，选择的索引
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, assign) MineMyOrderStyle MyOrderViewStyle;

- (void)TabelViewBeginDataSoure;

@end

NS_ASSUME_NONNULL_END
