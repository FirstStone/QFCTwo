//
//  Message_RunErrands_TableView_NoOrderCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Message_RunErrands_Model;
@protocol MessageRunErrandsTableViewNoOrderCellDelegate <NSObject>

- (void)MessageRunErrandsTableViewNoOrderCellButtonClick:(Message_RunErrands_Model *)model;

@end
@interface Message_RunErrands_TableView_NoOrderCell : UITableViewCell


- (void)setDataSoureToCell:(Message_RunErrands_Model *)model index:(NSInteger)index;

@property (nonatomic, assign) id <MessageRunErrandsTableViewNoOrderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
