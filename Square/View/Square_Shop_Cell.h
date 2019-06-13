//
//  Square_Shop_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;

@interface Square_Shop_Cell : UITableViewCell
- (void)setDataSoureToCell:(SquareRecommend_Model *)model;

@end

NS_ASSUME_NONNULL_END
