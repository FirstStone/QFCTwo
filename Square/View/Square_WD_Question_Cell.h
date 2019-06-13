//
//  Square_WD_ Question_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Square_address_Model;
@protocol SquareWDQuestionCellDelegate <NSObject>

- (void)SquareWDQuestionCellIconimageViewClick:(NSString *)mid;

@end

@interface Square_WD_Question_Cell : UITableViewCell

- (void)setModelToCell:(Square_address_Model *)model;

@property (nonatomic, assign) id <SquareWDQuestionCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
