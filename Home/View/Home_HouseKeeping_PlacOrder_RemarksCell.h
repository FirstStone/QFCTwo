//
//  Home_HouseKeeping_PlacOrder_RemarksCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeHouseKeepingPlacOrderRemarksCellDelegate <NSObject>

- (void)textFieldText:(NSString *)text;

@end

@interface Home_HouseKeeping_PlacOrder_RemarksCell : UITableViewCell

@property (nonatomic, assign) id <HomeHouseKeepingPlacOrderRemarksCellDelegate> delegate;

- (void)setTextToTextField:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
