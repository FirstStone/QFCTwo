//
//  Message_tableView_HeaderView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_Shoping_Model;
@class Message_Housekeeping_Model;
@interface Message_tableView_HeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *Icon_View;

@property (nonatomic, strong) UILabel *Order_Label;

@property (nonatomic, strong) UILabel *Price_Label;

- (void)setDataSoureToCell:(Message_Shoping_Model *)model;

- (void)setHousekeepingDataSoureToCell:(Message_Housekeeping_Model *)model;

@end

NS_ASSUME_NONNULL_END
