//
//  Publish_Location_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/5.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Publish_Location_Model;

@interface Publish_Location_Cell : UITableViewCell

- (void)setDataSoureToCell:(Publish_Location_Model *)model;

@end

NS_ASSUME_NONNULL_END
