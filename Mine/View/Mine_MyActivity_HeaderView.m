//
//  Mine_MyActivity_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyActivity_HeaderView.h"

@implementation Mine_MyActivity_HeaderView

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
    UIView *TopView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    [self.contentView addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.offset(10.0f);
    }];
    
    [self.contentView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(TopView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
    }];
}

#pragma mark----懒加载
- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        _Title_Label.textColor = QFC_Color_333333;
//        _Title_Label.text = @"<#再买1杯，享买2赠1。#>";
    }
    return _Title_Label;
}

@end
