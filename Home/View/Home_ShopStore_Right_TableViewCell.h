//
//  Home_ShopStore_Right_TableViewCell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_ShopStore_Branch_Model;
@protocol HomeShopStoreRightTableViewCellDelegate <NSObject>

- (void)HomeShopStoreRightTableViewCellCartButtonClick:(Home_ShopStore_Branch_Model *)model;
- (void)HomeShopStoreRightTableViewCellAddButtonClick:(Home_ShopStore_Branch_Model *)model;
- (void)HomeShopStoreRightTableViewCellSubtractButtonClick:(Home_ShopStore_Branch_Model *)model;

@end
@interface Home_ShopStore_Right_TableViewCell : UITableViewCell

- (void)SetDataSoureToRightCell:(Home_ShopStore_Branch_Model *)model;

@property (nonatomic, assign) id <HomeShopStoreRightTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
