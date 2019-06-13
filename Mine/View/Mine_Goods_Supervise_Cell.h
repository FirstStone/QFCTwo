//
//  Mine_Goods_Supervise_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_Goods_Supervise_Model;
@protocol MineGoodsSuperviseCellDelegate <NSObject>

- (void)MineGoodsSuperviseCellButtonClick:(Mine_Goods_Supervise_Model *)model index:(NSInteger)index;

@end
@interface Mine_Goods_Supervise_Cell : UITableViewCell

- (void)setModelToCell:(Mine_Goods_Supervise_Model *)model;

@property (nonatomic, assign) id <MineGoodsSuperviseCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
