//
//  Mine_BeginAnd_EndTimeCell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_MyShopStore_Model;

@protocol MineBeginAndEndTimeCellDelegate <NSObject>

- (void)MineBeginAndEndTimeCellLabelClick:(NSInteger)index;

@end

@interface Mine_BeginAnd_EndTimeCell : UITableViewCell

- (void)setDataSoureToCell:(Mine_MyShopStore_Model *)model;

@property (nonatomic, assign) id <MineBeginAndEndTimeCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
