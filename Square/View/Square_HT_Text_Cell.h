//
//  Square_HT_Text_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;
@protocol SquareHTTextCellDelegate <NSObject>

- (void)SquareHTTextCellIconImageViewClick:(NSString *)mid;

- (void)SquareHTTextCellMoreButtonClick:(SquareRecommend_Model *)model;

@end
@interface Square_HT_Text_Cell : UITableViewCell

- (void)setDataSoureToCell:(SquareRecommend_Model *)model;

@property (nonatomic, assign) id <SquareHTTextCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
