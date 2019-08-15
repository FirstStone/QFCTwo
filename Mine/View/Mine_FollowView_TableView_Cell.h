//
//  Mine_FollowView_TableView_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_Follow_Model;

@protocol MineFollowViewTableViewCellDelegate <NSObject>

- (void)MineFollowViewTableViewCellButtonClick:(Mine_Follow_Model *)model;

@end

@interface Mine_FollowView_TableView_Cell : UITableViewCell

- (void)setModelToCell:(Mine_Follow_Model *)model;

@property (nonatomic, assign) id <MineFollowViewTableViewCellDelegate> delegate;

@property (nonatomic, assign) NSInteger Style;

@end

NS_ASSUME_NONNULL_END
