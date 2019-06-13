//
//  Home_ShopCatr_Settlement_FooterView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_ShoppingCatr_Settlement_Model;

@protocol HomeShopCatrSettlementFooterViewDelegate <NSObject>
/**1为 自取 2 为 配送*/
- (void)HomeShopCatrSettlementFooterViewButton:(NSInteger)state modelID:(NSString *)modleid;

- (void)HomeShopCatrSettlementFooterViewRemark:(NSString *)Remark modelID:(NSString *)modleid;

@end

@interface Home_ShopCatr_Settlement_FooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *Delivery_BT;
@property (nonatomic, strong) UIButton *Invite_BT;
@property (nonatomic, strong) UILabel *Price_Label;
@property (nonatomic, strong) UILabel *Discount_Label;
@property (nonatomic, strong) UITextField *Remarks_Field;
@property (nonatomic, strong) UILabel *Total_Label;

- (void)setDataSoureToCell:(Home_ShoppingCatr_Settlement_Model *)model;

@property (nonatomic, assign) id <HomeShopCatrSettlementFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
