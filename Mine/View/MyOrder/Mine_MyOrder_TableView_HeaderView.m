//
//  Mine_MyOrder_TableView_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_TableView_HeaderView.h"

@implementation Mine_MyOrder_TableView_HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.contentView.backgroundColor = QFC_BackColor_Gray;
    UIView *contentView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 12.0f;
        view;
    });
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(7.0f).priorityHigh();
        make.left.equalTo(self.contentView.mas_left).offset(10.0f).priorityHigh();
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f).priorityHigh();
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10.0f).priorityHigh();
//        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7.0f, 10.0f, -10.0f, -10.0f));
    }];
    [contentView addSubview:self.Icon_imageView];
    [self.Icon_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(26.0f, 26.0f));
        make.top.equalTo(contentView.mas_top).offset(11.0f);
        make.left.equalTo(contentView.mas_left).offset(11.0f);
    }];
    [contentView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15.0f);
        make.left.equalTo(self.Icon_imageView.mas_right).offset(10.0f);
        make.centerY.equalTo(self.Icon_imageView.mas_centerY);
    }];
    UIImageView *Right_View = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_you_Hui"];
        imageView;
    });
    [contentView addSubview:Right_View];
    [Right_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Title_Label);
        make.size.mas_offset(CGSizeMake(5.0f, 9.0f));
        make.left.equalTo(self.Title_Label.mas_right).offset(10.0f);
    }];
    
    [contentView addSubview:self.Right_Label];
    [self.Right_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Icon_imageView.mas_centerY);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.height.offset(15.0f);
    }];
    [contentView addSubview:self.Right_imageView];
    [self.Right_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Right_Label);
        make.size.mas_offset(CGSizeMake(12.0f, 15.0f));
        make.right.equalTo(self.Right_Label.mas_left).offset(-6.0f);
    }];
    UIView *Line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [contentView addSubview:Line_View];
    [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1.0f);
        make.left.right.equalTo(contentView);
        make.top.equalTo(self.Icon_imageView.mas_bottom).offset(5.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-15.0f);
    }];
    self.contentView.clipsToBounds = YES;
}

#pragma mark----懒加载
- (UIImageView *)Icon_imageView {
    if (!_Icon_imageView) {
        _Icon_imageView = [[UIImageView alloc] init];
        _Icon_imageView.image = [UIImage imageNamed:@"icon_touxiang"];
        _Icon_imageView.layer.cornerRadius = 13.0f;
        _Icon_imageView.layer.masksToBounds = YES;
    }
    return _Icon_imageView;
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Title_Label.textColor = QFC_Color_333333;
        _Title_Label.text = @"";
    }
    return _Title_Label;
}

- (UILabel *)Right_Label {
    if (!_Right_Label) {
        _Right_Label = [[UILabel alloc] init];
        _Right_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Right_Label.textColor = QFC_Color_30AC65;
        _Right_Label.text = @"配送";
    }
    return _Right_Label;
}

- (UIImageView *)Right_imageView {
    if (!_Right_imageView) {
        _Right_imageView = [[UIImageView alloc] init];
        _Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_LV"];
    }
    return _Right_imageView;
}

@end
