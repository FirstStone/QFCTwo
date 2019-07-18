//
//  Home_KDROrder_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Home_KDR_Order_Model;

@protocol HomeKDROrderCellDelegate <NSObject>

- (void)HomeKDROrderCellButtonClick:(Home_KDR_Order_Model *)model;

@end
@interface Home_KDROrder_Cell : UITableViewCell

- (void)setDataSoureToCell:(Home_KDR_Order_Model *)model;

- (void)setDataSoureTocell:(Home_KDR_Order_Model *)model style:(NSInteger)style;

@property (nonatomic, assign) id <HomeKDROrderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
