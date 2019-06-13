//
//  Square_TextCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;
@class Square_QuestionsAndAnswers_List_Model;

@protocol SquareTextCellDelegate <NSObject>

- (void)SquareTextCellIconViewClick:(NSString *)mid;

@end

@interface Square_TextCell : UITableViewCell

- (void)setDataSoureToCell:(SquareRecommend_Model *)model;
- (void)setSquareQuestionsAndAnswersListModelToCell:(Square_QuestionsAndAnswers_List_Model *)model;

@property (nonatomic, assign) id <SquareTextCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
