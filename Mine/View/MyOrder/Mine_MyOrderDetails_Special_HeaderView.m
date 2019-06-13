//
//  Mine_MyOrderDetails_Special_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrderDetails_Special_HeaderView.h"

@implementation Mine_MyOrderDetails_Special_HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.backgroundColor = QFC_Color_F5F5F5;
    UIView *contentView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10.0f, 10.0f, 5.0f, 10.0f));
    }];
    
    [contentView addSubview:self.Photo_View];
    [self.Photo_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60.0f, 60.0f));
        make.centerX.equalTo(contentView);
        make.top.offset(10.0f);
    }];
    [contentView addSubview:self.Tip_Label];
    [self.Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX);
        make.top.equalTo(self.Photo_View.mas_bottom).offset(8.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];
    /*[contentView addSubview:self.Pickup_BT];
    [self.Pickup_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20.0f);
        make.top.equalTo(self.Photo_View.mas_bottom).offset(8.0f);
        make.centerX.equalTo(contentView);
    }];
    [contentView addSubview:self.PickupNumber_Label];
    [self.PickupNumber_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(self.Pickup_BT.mas_bottom).offset(7.0f);
        make.height.offset(22.0f);
    }];
    [contentView addSubview:self.Tip_Label];
    [self.Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX);
        make.top.equalTo(self.PickupNumber_Label.mas_bottom).offset(8.0f);
        make.height.offset(12.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];*/
    
}

#pragma mark----懒加载
- (UIImageView *)Photo_View {
    if (!_Photo_View) {
        _Photo_View = [[UIImageView alloc] init];
        _Photo_View.image = [UIImage imageNamed:@"icon_Photo"];
    }
    return _Photo_View;
}

- (UIButton *)Pickup_BT {
    if (!_Pickup_BT) {
        _Pickup_BT = [[UIButton alloc] init];
        [_Pickup_BT setTitle:@"  取货二维码  " forState:UIControlStateNormal];
        _Pickup_BT.backgroundColor = QFC_Color_30AC65;
        _Pickup_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        [_Pickup_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Pickup_BT.layer.cornerRadius = 10.0f;
    }
    return _Pickup_BT;
}

- (UILabel *)PickupNumber_Label {
    if (!_PickupNumber_Label) {
        _PickupNumber_Label = [[UILabel alloc] init];
        _PickupNumber_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _PickupNumber_Label.textColor = QFC_Color_Six;
        _PickupNumber_Label.text = @"  取货码：123456  ";
        _PickupNumber_Label.layer.cornerRadius = 11.0f;
        _PickupNumber_Label.layer.masksToBounds = YES;
        _PickupNumber_Label.layer.borderColor = QFC_Color_30AC65.CGColor;
        _PickupNumber_Label.layer.borderWidth = 1.0f;
        _PickupNumber_Label.textAlignment = NSTextAlignmentCenter;
    }
    return _PickupNumber_Label;
}

- (UILabel *)Tip_Label {
    if (!_Tip_Label) {
        _Tip_Label = [[UILabel alloc] init];
        _Tip_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Tip_Label.textColor = QFC_Color_30AC65;
        _Tip_Label.text = @"已接单成功，尽快赶往商家取货哦~";
    }
    return _Tip_Label;
}

@end
