//
//  Home_ShopStore_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_ShopStore_Model;
@interface Home_ShopStore_Cell : UITableViewCell

- (void)SetDataSoureToCell:(Home_ShopStore_Model *)model;

@end

NS_ASSUME_NONNULL_END
