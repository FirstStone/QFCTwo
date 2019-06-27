//
//  Mine_SetUP_Privacy_Blacklist_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_BlackUser_Model;

@protocol MineSetUPPrivacyBlacklistCellDelegate <NSObject>

- (void)MineSetUPPrivacyBlacklistCellButtonClick:(Mine_BlackUser_Model *)model;

@end

@interface Mine_SetUP_Privacy_Blacklist_Cell : UITableViewCell

- (void)setDataSoureToVell:(Mine_BlackUser_Model *)model;

@property (nonatomic, assign) id <MineSetUPPrivacyBlacklistCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
