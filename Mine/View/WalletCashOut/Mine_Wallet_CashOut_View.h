//
//  Mine_Wallet_CashOut_View.h
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CashOutWeChat,
    CashOutAlipay,
} WalletCashOutStyle;

@interface Mine_Wallet_CashOut_View : UIView
@property (nonatomic, strong) UIImageView *icon_View;
@property (nonatomic, strong) UILabel *title_Label;
@property (nonatomic, strong) UILabel *CardNumber_Label;
@property (nonatomic, strong) UILabel *State_Label;
@property (nonatomic, strong) UIImageView *Right_imageView;


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, assign) WalletCashOutStyle CashOuytSty;

@end

NS_ASSUME_NONNULL_END
