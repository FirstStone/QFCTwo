//
//  Square_WD_Text_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;
@class Square_WD_Model;
@protocol SquareWDTextCellDelegate <NSObject>

- (void)SquareWDTextCellIconView:(NSString *)mid;

- (void)SquareWDTextCellMoreButtonClick:(SquareRecommend_Model*)model QuestionsAndAnswersModel:(Square_WD_Model *)WDModel Style:(NSInteger)index;

@end

@interface Square_WD_Text_Cell : UITableViewCell

- (void)setDataSoureToCell:(SquareRecommend_Model *)model;

- (void)setSquareWDModelToCell:(Square_WD_Model *)model;

@property (nonatomic, assign) id <SquareWDTextCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
