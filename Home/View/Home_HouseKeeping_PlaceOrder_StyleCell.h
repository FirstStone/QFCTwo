//
//  Home_HouseKeeping_PlaceOrder_StyleCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Home_HouseKeep_PlaceOrder_Model;
NS_ASSUME_NONNULL_BEGIN
@protocol HomeHouseKeepingPlaceOrderStyleCellDelegate <NSObject>
/**
 BranchModel 选中的子菜单
 section  种类索引
 index    详细索引
 */
- (void)HomeHouseKeepingPlaceOrderStyleButtonClick:(Home_HouseKeep_PlaceOrder_Model *)Model sectionListArray:(NSMutableArray *)listArray Section:(NSInteger)section index:(NSInteger)index;

@end
@interface Home_HouseKeeping_PlaceOrder_StyleCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)setUPUI;

@property (nonatomic, assign) id <HomeHouseKeepingPlaceOrderStyleCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
