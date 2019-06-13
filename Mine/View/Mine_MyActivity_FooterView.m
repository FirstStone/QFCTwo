//
//  Mine_MyActivity_FooterView.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyActivity_FooterView.h"

@implementation Mine_MyActivity_FooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.Text_Label];
    [self.Text_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
        make.top.equalTo(self.contentView.mas_top).offset(10.0f);
    }];
    [self.contentView addSubview:self.Delect_BT];
    [self.Delect_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
        make.height.offset(30.0f);
        make.top.equalTo(self.Text_Label.mas_bottom).offset(10.0f);
    }];
}

#pragma mark----懒加载

- (UILabel *)Text_Label {
    if (!_Text_Label) {
        _Text_Label = [[UILabel alloc] init];
        _Text_Label.font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightMedium];
        _Text_Label.textColor = QFC_Color_333333;
        _Text_Label.text = @"消费方式：\n适用范围：活动时间：\n";
        _Text_Label.numberOfLines = 0;
    }
    return _Text_Label;
}

- (UIButton *)Delect_BT {
    if (!_Delect_BT) {
        _Delect_BT = [[UIButton alloc] init];
        [_Delect_BT setTitle:@"删除活动" forState:UIControlStateNormal];
        _Delect_BT.backgroundColor = QFC_Color_30AC65;
        [_Delect_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Delect_BT addTarget:self action:@selector(delectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Delect_BT.layer.cornerRadius = 15.0f;
    }
    return _Delect_BT;
}

- (void)delectButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(MineMyActivityFooterViewDelectButtonClick:)]) {
        [self.delegate MineMyActivityFooterViewDelectButtonClick:self.Mymodel];
    }
}


@end
