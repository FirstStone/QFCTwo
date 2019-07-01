//
//  Mine_Wallet_CashOut_View.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_CashOut_View.h"

@interface Mine_Wallet_CashOut_View ()

@property (nonatomic, strong) UIView *TopView;

@property (nonatomic, strong) UITextField *Money_Field;

@property (nonatomic, strong) UILabel *Price_Label;
@property (nonatomic, strong) UIButton *Sure_BT;

@end

@implementation Mine_Wallet_CashOut_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.backgroundColor = QFC_BackColor_Gray;
    [self addSubview:self.TopView];
    [self.TopView addSubview:self.icon_View];
    [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TopView.mas_left).offset(10.0f);
        make.top.equalTo(self.TopView.mas_top).offset(10.0f);
        make.size.mas_offset(CGSizeMake(40.0f, 40.0f));
    }];
    [self.TopView addSubview:self.title_Label];
    [self.title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(14.0f);
        make.bottom.equalTo(self.icon_View.mas_centerY).offset(-7.0);
        make.left.equalTo(self.icon_View.mas_right).offset(10.0f);
    }];
    [self.TopView addSubview:self.CardNumber_Label];
    [self.CardNumber_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title_Label);
        make.top.equalTo(self.title_Label.mas_bottom);
        make.bottom.equalTo(self.icon_View.mas_bottom);
    }];
    [self.TopView addSubview:self.Right_imageView];
    [self.Right_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(5.0, 9.0f));
        make.centerY.equalTo(self.icon_View);
        make.right.equalTo(self.TopView.mas_right).offset(-10.0f);
    }];
    [self.TopView addSubview:self.State_Label];
    [self.State_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Right_imageView);
        make.right.equalTo(self.Right_imageView.mas_left).offset(-10.0);
        make.height.offset(15.0f);
//        make.bottom.equalTo(self.TopView.mas_bottom).offset(10.0f);
    }];
    [self.TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.icon_View.mas_bottom).offset(10.0f);
    }];
    UIView *DownView = [self getDownView];
    [self addSubview:DownView];
    [DownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.TopView.mas_bottom).offset(10.0f);
    }];
    [self addSubview:self.Sure_BT];
    [self.Sure_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.0f);
        make.right.equalTo(self.mas_right).offset(-10.0f);
        make.height.offset(33.0f);
        make.top.equalTo(DownView.mas_bottom).offset(80.0f);
    }];
}

- (UIView *)getDownView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UILabel *tip_Label = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = QFC_Color_Six;
        label.text = @"提现金额";
        label;
    });
    [contView addSubview:tip_Label];
    [tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView.mas_top).offset(10.0f);
        make.left.equalTo(contView.mas_left).offset(10.0f);
        make.height.offset(15.0f);
    }];
    UILabel *tipLabel_1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:24.0f];
        label.textColor = QFC_Color_Six;
        label.text = @"¥";
        label;
    });
    [contView addSubview:tipLabel_1];
    [tipLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(15.0f, 30.0f));
        make.top.equalTo(tip_Label.mas_bottom).offset(10.0f);
        make.left.equalTo(tip_Label);
    }];
    [contView addSubview:self.Money_Field];
    [self.Money_Field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40.0f);
        make.left.equalTo(tipLabel_1.mas_right).offset(10.0f);
        make.right.equalTo(contView.mas_right).offset(-10.0f);
        make.centerY.equalTo(tipLabel_1);
    }];
    UIView *Line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [contView addSubview:Line_View];
    [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.height.offset(1.0f);
        make.top.equalTo(self.Money_Field.mas_bottom).offset(5.0f);
    }];
    [contView addSubview:self.Price_Label];
    [self.Price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(10.0f);
        make.top.equalTo(Line_View.mas_top).offset(5.0f);
        make.height.offset(30.0f);
        make.bottom.equalTo(contView.mas_bottom).offset(-10.0f);
    }];
    return contView;
}

#pragma mark----懒加载

- (UIView *)TopView {
    if (!_TopView) {
        _TopView = [[UIView alloc] init];
        _TopView.backgroundColor = [UIColor whiteColor];
    }
    return _TopView;
}

- (UIImageView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIImageView alloc] init];
    }
    return _icon_View;
}

- (UIImageView *)Right_imageView {
    if (!_Right_imageView) {
        _Right_imageView = [[UIImageView alloc] init];
        _Right_imageView.image = [UIImage imageNamed:@"icon_you_Hui"];
    }
    return _Right_imageView;
}

- (UILabel *)title_Label {
    if (!_title_Label) {
        _title_Label = [[UILabel alloc] init];
        _title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        _title_Label.textColor = QFC_Color_333333;
    }
    return _title_Label;
}

- (UILabel *)CardNumber_Label {
    if (!_CardNumber_Label) {
        _CardNumber_Label = [[UILabel alloc] init];
        _CardNumber_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
        _CardNumber_Label.textColor = QFC_Color_Six;
        _CardNumber_Label.text = @"185*******7";
    }
    return _CardNumber_Label;
}

- (UILabel *)State_Label {
    if (!_State_Label) {
        _State_Label = [[UILabel alloc] init];
        _State_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
        _State_Label.textColor = QFC_Color_Six;
        _State_Label.text = @"未绑定";
    }
    return _State_Label;
}

- (UITextField *)Money_Field {
    if (!_Money_Field) {
        _Money_Field = [[UITextField alloc] init];
        _Money_Field.keyboardType = UIKeyboardTypeDecimalPad;
        _Money_Field.placeholder = @"请输入提现金额，最多保留两位小数";
    }
    return _Money_Field;
}

- (UILabel *)Price_Label {
    if (!_Price_Label) {
        _Price_Label = [[UILabel alloc] init];
        _Price_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Price_Label.textColor = QFC_Color_Six;
        _Price_Label.text = @"可提现金额0.00元";
    }
    return _Price_Label;
}

- (UIButton *)Sure_BT {
    if (!_Sure_BT) {
        _Sure_BT = [[UIButton alloc] init];
        [_Sure_BT setTitle:@"立即提现" forState:UIControlStateNormal];
        _Sure_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        [_Sure_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Sure_BT.backgroundColor = QFC_Color_30AC65;
        _Sure_BT.layer.cornerRadius = 17.0f;
    }
    return _Sure_BT;
}



@end
