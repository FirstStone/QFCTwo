//
//  Message_Shoping_Tableview_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Message_Shoping_Branch_Model;

@interface Message_Shoping_Tableview_Cell : UITableViewCell

- (void)setDataSoureToCell:(Message_Shoping_Branch_Model *)model;

@end

NS_ASSUME_NONNULL_END
