//
//  Home_HouseKeepingCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RatingBar;
@class Home_HouseKeeping_Model;
@interface Home_HouseKeepingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet RatingBar *score_View;
@property (strong, nonatomic) IBOutlet UIImageView *Right_imageview;

- (void)setModelToCell:(Home_HouseKeeping_Model *)model;
- (void)setPlaceOrderModelToCell:(Home_HouseKeeping_Model *)model;

@end

NS_ASSUME_NONNULL_END
