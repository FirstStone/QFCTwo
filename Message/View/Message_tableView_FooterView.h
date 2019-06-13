//
//  Message_tableView_FooterView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_Shoping_Model;
@class Message_Housekeeping_Model;
@protocol MessagetableViewFooterViewDelegate <NSObject>
/**1 为 左边  2为右边*/
- (void)MessagetableViewFooterViewButtonClick:(Message_Shoping_Model *)model index:(NSInteger)index;

@end

@interface Message_tableView_FooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *Text_Label;

@property (nonatomic, strong) UILabel *Price_Label;

@property (nonatomic, strong) UIButton *Lift_BT;

@property (nonatomic, strong) UIButton *Right_BT;

- (void)setDataSoureToCell:(Message_Shoping_Model *)model style:(NSInteger)style;

- (void)setHousekeepingDataSoureToCell:(Message_Housekeeping_Model *)model style:(NSInteger)style;

@property (nonatomic, assign) id <MessagetableViewFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
