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
@interface Home_KDROrder_Cell : UITableViewCell

- (void)setDataSoureToCell:(Home_KDR_Order_Model *)model;

@end

NS_ASSUME_NONNULL_END
