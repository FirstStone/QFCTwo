//
//  ButtonAndLabel.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ButtonAndLabel.h"

@implementation ButtonAndLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    [self addSubview:self.Top_BT];
    [self.Top_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.6f);
    }];
    [self addSubview:self.Down_Label];
    [self.Down_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.Top_BT.mas_bottom);
    }];
}

- (UIButton *)Top_BT {
    if (!_Top_BT) {
        _Top_BT = [[UIButton alloc] init];
        [_Top_BT setTitleColor:QFC_Color_Six forState:UIControlStateNormal];
        [_Top_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_Top_BT setBackgroundImage:[UIImage imageWithColor:QFC_Color_F5F5F5] forState:UIControlStateNormal];
        [_Top_BT setBackgroundImage:[UIImage imageWithColor:QFC_Color_30AC65] forState:UIControlStateSelected];
        _Top_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Top_BT.backgroundColor = [UIColor whiteColor];
        _Top_BT.layer.cornerRadius = 15.0f;
        _Top_BT.layer.masksToBounds = YES;
    }
    return _Top_BT;
}

- (UILabel *)Down_Label {
    if (!_Down_Label) {
        _Down_Label = [[UILabel alloc] init];
        _Down_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Down_Label.textAlignment = NSTextAlignmentCenter;
        _Down_Label.textColor = QFC_Color_999999;
    }
    return _Down_Label;
}

@end
