//
//  Home_HouseeKeeping_PlaceOrderOrdinaryCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_HouseKeep_PlaceOrderOrdinary_Model;
@protocol HomeHouseeKeepingPlaceOrderOrdinaryCellDelegate <NSObject>

- (void)HomeHouseeKeepingPlaceOrderOrdinaryCellButtonClick:(Home_HouseKeep_PlaceOrderOrdinary_Model *)model Number:(NSInteger)index;

@end

@interface Home_HouseeKeeping_PlaceOrderOrdinaryCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)setUPUI;

@property (nonatomic, assign) id <HomeHouseeKeepingPlaceOrderOrdinaryCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
