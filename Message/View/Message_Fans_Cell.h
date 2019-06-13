//
//  Message_Fans_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_FansList_Model;

@protocol MessageFansCellDelegate <NSObject>

- (void)MessageFansCellButtonClick:(Message_FansList_Model *)model;

@end

@interface Message_Fans_Cell : UITableViewCell

- (void)setDataSoureToCell:(Message_FansList_Model *)model;

@property (nonatomic, assign) id <MessageFansCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
