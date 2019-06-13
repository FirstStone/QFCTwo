//
//  Home_ShoppingCatr_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCatr_HeaderView.h"

@interface Home_ShoppingCatr_HeaderView ()

@property (nonatomic, strong) Home_ShoppingCart_Model *MyModel;

@end

@implementation Home_ShoppingCatr_HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.contentView.backgroundColor = QFC_Color_F5F5F5;
    UIView *backView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        view;
    });
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10.0f).priorityHigh();
        make.top.equalTo(self.contentView.mas_top).offset(5.0f).priorityHigh();
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f).priorityHigh();
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10.0f).priorityHigh();
    }];
    
    [backView addSubview:self.ShopState_BT];
    [self.ShopState_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(10.0f);
        make.left.equalTo(backView.mas_left).offset(11.0f);
//        make.bottom.equalTo(backView.mas_bottom).offset(-15.0f);
        make.size.mas_offset(CGSizeMake(15.0f, 15.0f));
    }];
    UIImageView *icon_View = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_hui"];
        imageView;
    });
    [backView addSubview:icon_View];
    [icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(15.0f, 15.0f));
        make.centerY.equalTo(self.ShopState_BT);
        make.left.equalTo(self.ShopState_BT.mas_right).offset(10.0f);
    }];
    [backView addSubview:self.ShopName_Label];
    [self.ShopName_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15.0f);
        make.left.equalTo(icon_View.mas_right).offset(4.0f);
        make.centerY.equalTo(icon_View);
    }];
    UIImageView * right_image = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_you_Hui"];
        imageView;
    });
    [backView addSubview:right_image];
    [right_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(5.0f, 9.0f));
        make.centerY.equalTo(self.ShopName_Label);
        make.left.equalTo(self.ShopName_Label.mas_right).offset(12.0f);
    }];
    [backView addSubview:self.Coupon_BT];
    [self.Coupon_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(self.ShopName_Label);
        make.right.equalTo(backView.mas_right).offset(-10.0f);
//        make.bottom.equalTo(backView.mas_bottom).offset(-15.0f);
    }];
    self.contentView.clipsToBounds = YES;
}

#pragma mark----懒加载
- (UIButton *)ShopState_BT {
    if (!_ShopState_BT) {
        _ShopState_BT = [[UIButton alloc] init];
        [_ShopState_BT setImage:[UIImage imageNamed:@"icon_Mine_SetUP_duigou_kong"] forState:UIControlStateNormal];
         [_ShopState_BT setImage:[UIImage imageNamed:@"icon_Mine_SetUP_duigou"] forState:UIControlStateSelected];
        [_ShopState_BT addTarget:self action:@selector(shopStateButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ShopState_BT;
}

- (UILabel *)ShopName_Label {
    if (!_ShopName_Label) {
        _ShopName_Label = [[UILabel alloc] init];
        _ShopName_Label.textColor = QFC_Color_333333;
        _ShopName_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
    }
    return _ShopName_Label;
}

- (UIButton *)Coupon_BT {
    if (!_Coupon_BT) {
        _Coupon_BT = [[UIButton alloc] init];
        [_Coupon_BT setTitle:@"领劵" forState:UIControlStateNormal];
        _Coupon_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        [_Coupon_BT setTitleColor:QFC_Color_30AC65 forState:UIControlStateNormal];
        _Coupon_BT.hidden = YES;
    }
    return _Coupon_BT;
}

- (void)shopStateButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(HomeShoppingCatrHeaderViewButton:)]) {
        [self.delegate HomeShoppingCatrHeaderViewButton:self.MyModel];
    }
}

- (void)setDataSoureToCell:(Home_ShoppingCart_Model *)model {
    self.MyModel = model;
    self.ShopName_Label.text = model.merchant;
    self.ShopState_BT.selected = model.ButtonState;
}

@end
