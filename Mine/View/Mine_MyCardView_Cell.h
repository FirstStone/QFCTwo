//
//  Mine_MyCardView_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_MyCard_Model;

@protocol MineMyCardViewCellDelegate <NSObject>

- (void)MineMyCardViewCellButtonClick:(Mine_MyCard_Model *)model;

@end
@interface Mine_MyCardView_Cell : UITableViewCell

- (void)setModelToCell:(Mine_MyCard_Model *)model;

- (void)setUserModelToCell:(Mine_MyCard_Model *)model;

@property (nonatomic, assign) id <MineMyCardViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
