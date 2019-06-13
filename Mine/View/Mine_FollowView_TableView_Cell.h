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
@interface Mine_FollowView_TableView_Cell : UITableViewCell

- (void)setModelToCell:(Mine_Follow_Model *)model;

@end

NS_ASSUME_NONNULL_END
