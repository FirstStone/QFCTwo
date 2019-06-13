//
//  Square_Default_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SquareDefaultCellDelegate <NSObject>

- (void)iconViewClick:(NSString *)mid;

@end

@interface Square_Default_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Share_BT;
@property (nonatomic, assign) id <SquareDefaultCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
