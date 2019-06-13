//
//  Mine_MyOrderDetails_Time_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_Order_Details_Model;

@interface Mine_MyOrderDetails_Time_Cell : UITableViewCell

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model;

@end

NS_ASSUME_NONNULL_END
