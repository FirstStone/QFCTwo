//
//  Square_HT_ImageCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareRecommend_Model;
@class Square_QuestionsAndAnswers_List_Model;
@protocol SquareHTImageCellDelegate <NSObject>
/**indx 1 为顶*/
- (void)SquareHTImageCellButtonClick:(NSInteger)index SquareRecommendModel:(SquareRecommend_Model *)model;

- (void)SquareHTImageCellButtonClick:(NSInteger)index SquareQuestionsAndAnswersListModel:(Square_QuestionsAndAnswers_List_Model *)model;

- (void)iconViewClick:(NSString *)mid;

@end

@interface Square_HT_ImageCell : UITableViewCell


- (void)setDataSoureToCell:(SquareRecommend_Model *)model;

- (void)setSquareQuestionsAndAnswersListModelToCell:(Square_QuestionsAndAnswers_List_Model *)model;


@property (nonatomic, assign) id <SquareHTImageCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
