//
//  Mine_MyOrderDetails_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrderDetails_HeaderView.h"

@implementation Mine_MyOrderDetails_HeaderView

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
    [contentView addSubview:self.Lift_BT];
    [self.Lift_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20.0f);
        make.top.equalTo(self.Photo_View.mas_bottom).offset(8.0f);
        make.right.equalTo(contentView.mas_centerX).offset(- 10.0f);
    }];
    [contentView addSubview:self.Right_BT];
    [self.Right_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20.0f);
        make.top.equalTo(self.Photo_View.mas_bottom).offset(8.0f);
        make.left.equalTo(contentView.mas_centerX).offset(10.0f);
    }];
    
    [contentView addSubview:self.State_Label];
    [self.State_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(self.Lift_BT.mas_bottom).offset(7.0f);
        make.height.offset(22.0f);
    }];
    [contentView addSubview:self.Tip_Label];
    [self.Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX);
        make.top.equalTo(self.State_Label.mas_bottom).offset(8.0f);
        make.height.offset(12.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];
}

#pragma mark----懒加载
- (UIImageView *)Photo_View {
    if (!_Photo_View) {
        _Photo_View = [[UIImageView alloc] init];
        _Photo_View.image = [UIImage imageNamed:@"icon_Photo"];
    }
    return _Photo_View;
}

- (UIButton *)Lift_BT {
    if (!_Lift_BT) {
        _Lift_BT = [[UIButton alloc] init];
        [_Lift_BT setTitle:@"  配送  " forState:UIControlStateNormal];
        _Lift_BT.backgroundColor = QFC_Color_30AC65;
        _Lift_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        [_Lift_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Lift_BT.layer.cornerRadius = 10.0f;
    }
    return _Lift_BT;
}

- (UIButton *)Right_BT {
    if (!_Right_BT) {
        _Right_BT = [[UIButton alloc] init];
        [_Right_BT setTitle:@" 自送  " forState:UIControlStateNormal];
        _Right_BT.backgroundColor = QFC_Color_30AC65;
        _Right_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        [_Right_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Right_BT.layer.cornerRadius = 10.0f;
    }
    return _Right_BT;
}


- (UILabel *)State_Label {
    if (!_State_Label) {
        _State_Label = [[UILabel alloc] init];
        _State_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        _State_Label.textColor = QFC_Color_30AC65;
        _State_Label.text = @"等待评价";
        _State_Label.textAlignment = NSTextAlignmentCenter;
    }
    return _State_Label;
}

- (UILabel *)Tip_Label {
    if (!_Tip_Label) {
        _Tip_Label = [[UILabel alloc] init];
        _Tip_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Tip_Label.textColor = QFC_Color_Six;
        _Tip_Label.text = @"已接单成功，尽快赶往商家取货哦~";
    }
    return _Tip_Label;
}

@end
