//
//  Mine_MyOrder_HouseKeeping_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_Order_Model;
@class Mine_Order_Details_Model;

@interface Mine_MyOrder_HouseKeeping_Cell : UITableViewCell

- (void)setModelToCell:(Mine_Order_Model *)model;

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model;

@end

NS_ASSUME_NONNULL_END
