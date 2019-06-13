//
//  Square_WD_ImageAndText_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;
@class Square_WD_Model;
@protocol SquareWDImageAndTextCellDelegate <NSObject>

- (void)SquareWDImageAndTextCellIconimage:(NSString *)mid;

@end
@interface Square_WD_ImageAndText_Cell : UITableViewCell

- (void)setDataSoureToCell:(SquareRecommend_Model *)model;

- (void)setSquareWDModelToCell:(Square_WD_Model *)model;

@property (nonatomic, assign) id <SquareWDImageAndTextCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
