//
//  Mine_HouseKeep_Service_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Mine_MyHouseKeep_Model;

@protocol MineHouseKeepServiceCellDelegate <NSObject>

- (void)MineHouseKeepServiceCellButtonClick:(NSString *)index;

@end

@interface Mine_HouseKeep_Service_Cell : UITableViewCell

- (void)setDataSoureToCell:(Mine_MyHouseKeep_Model *)model;

@property (nonatomic, assign) id <MineHouseKeepServiceCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
