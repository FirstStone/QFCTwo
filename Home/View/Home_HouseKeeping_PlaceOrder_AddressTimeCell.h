//
//  Home_HouseKeeping_PlaceOrder_AddressTimeCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeHouseKeepingPlaceOrderAddressTimeCellDelegate <NSObject>
/**
 1 地址 2 时间
 */
- (void)ViewClick:(NSInteger)index;


@end

@interface Home_HouseKeeping_PlaceOrder_AddressTimeCell : UITableViewCell


@property (nonatomic, assign) id <HomeHouseKeepingPlaceOrderAddressTimeCellDelegate> delegate;

- (void)setAddressTocell:(NSString *)AddressString;
- (void)setTimesTocell:(NSString *)TimesString;
@end

NS_ASSUME_NONNULL_END
