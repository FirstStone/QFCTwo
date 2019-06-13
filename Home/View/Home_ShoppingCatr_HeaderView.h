//
//  Home_ShoppingCatr_HeaderView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_ShoppingCart_Model;

@protocol HomeShoppingCatrHeaderViewDelegate <NSObject>

- (void)HomeShoppingCatrHeaderViewButton:(Home_ShoppingCart_Model *)model;

@end

@interface Home_ShoppingCatr_HeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *ShopState_BT;

@property (nonatomic, strong) UILabel *ShopName_Label;

@property (nonatomic, strong) UIButton *Coupon_BT;

@property (nonatomic, assign) id <HomeShoppingCatrHeaderViewDelegate> delegate;

- (void)setDataSoureToCell:(Home_ShoppingCart_Model *)model;

@end

NS_ASSUME_NONNULL_END
