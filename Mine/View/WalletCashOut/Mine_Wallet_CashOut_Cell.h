//
//  Mine_Wallet_CashOut_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_Wallet_CashOut_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *CardNumber;
@property (strong, nonatomic) IBOutlet UILabel *Stat_Label;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Right_Button;



@end

NS_ASSUME_NONNULL_END
