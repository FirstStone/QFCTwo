//
//  Square_HT_Details_Comment_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Square_detailsDiscuss_Model;

@protocol SquareHTDetailsCommentCellDelegate <NSObject>
/**1 回复   2点赞*/
- (void)SquareHTDetailsCommentCell:(NSInteger)index model:(Square_detailsDiscuss_Model *)model;

- (void)SquareHTDetailsCommentCellMoreButton:(Square_detailsDiscuss_Model *)model;

@end
@interface Square_HT_Details_Comment_Cell : UITableViewCell


- (void)setDataSoureToCell:(Square_detailsDiscuss_Model *)model;

@property (nonatomic, assign) id <SquareHTDetailsCommentCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
