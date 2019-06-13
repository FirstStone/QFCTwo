//
//  Mine_MyActivity_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Mine_MyActivity_Branch_Model;

@interface Mine_MyActivity_Cell : UITableViewCell

- (void)setModelToCell:(Mine_MyActivity_Branch_Model *)model;

@end

NS_ASSUME_NONNULL_END
