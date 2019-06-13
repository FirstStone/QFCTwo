//
//  Message_ApexCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_Apex_Model;
@class Message_Comment_Model;
@protocol MessageApexCellDelegate <NSObject>

- (void)MessageApexCellRightButtonClick;

@end

@interface Message_ApexCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *RightButton;

@property (nonatomic, assign) id <MessageApexCellDelegate> delegate;

- (void)setDataSoureToCell:(Message_Apex_Model *)model type:(NSInteger)type;

- (void)setCommentDataSoureToCell:(Message_Comment_Model *)model;

@end

NS_ASSUME_NONNULL_END
