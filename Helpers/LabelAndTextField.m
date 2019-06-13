//
//  LabelAndTextField.m
//  eKang
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LabelAndTextField.h"

@implementation LabelAndTextField

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    [self addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(20.0f);
        make.width.offset(80.0f);
    }];
    [self addSubview:self.Text_Field];
    [self.Text_Field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.Title_Label);
        make.left.equalTo(self.Title_Label.mas_right).offset(20.0f);
        make.right.equalTo(self.mas_right).offset(-20.0f);
    }];
    UIView *Line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [self addSubview:Line_View];
    [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1.0f);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
        _Title_Label.textColor = QFC_Color_333333;
    }
    return _Title_Label;
}

- (UITextField *)Text_Field {
    if (!_Text_Field) {
        _Text_Field= [[UITextField alloc] init];
    }
    return _Text_Field;
}


@end
