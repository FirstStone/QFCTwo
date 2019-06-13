//
//  Message_tableView_HeaderView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_tableView_HeaderView.h"

@interface Message_tableView_HeaderView ()

@end

@implementation Message_tableView_HeaderView

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
        make.top.equalTo(self.contentView.mas_top).offset(7.0f);
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10.0f);
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(7.0f, 10.0f, 5.0f, 10.0f));
    }];
    [contentView addSubview:self.Icon_View];
    [self.Icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30.0f, 30.0f));
        make.top.equalTo(contentView.mas_top).offset(11.0f);
        make.left.equalTo(contentView.mas_left).offset(11.0f);
    }];
    [contentView addSubview:self.Order_Label];
    [self.Order_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15.0f);
        make.left.equalTo(self.Icon_View.mas_right).offset(10.0f);
        make.centerY.equalTo(self.Icon_View.mas_centerY);
    }];
    [contentView addSubview:self.Price_Label];
    [self.Price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Icon_View.mas_centerY);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.height.offset(15.0f);
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
        make.top.equalTo(self.Icon_View.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.contentView.clipsToBounds = YES;
}

- (UIImageView *)Icon_View {
    if (!_Icon_View) {
        _Icon_View = [[UIImageView alloc] init];
        _Icon_View.image = [UIImage imageNamed:@"icon_touxiang"];
        
    }
    return _Icon_View;
}

- (UILabel *)Order_Label {
    if (!_Order_Label) {
        _Order_Label = [[UILabel alloc] init];
        _Order_Label.font = [UIFont systemFontOfSize:14.0f];
        _Order_Label.textColor = QFC_Color_333333;
        _Order_Label.text = @"订单号：00000000000000";
    }
    return _Order_Label;
}

- (UILabel *)Price_Label {
    if (!_Price_Label) {
        _Price_Label = [[UILabel alloc] init];
        _Price_Label.font = [UIFont systemFontOfSize:16.0f weight:200.0f];
        _Price_Label.textColor = QFC_Color_FF492B;
        _Price_Label.text = @"¥4984";
        _Price_Label.hidden = YES;
    }
    return _Price_Label;
}

- (void)setDataSoureToCell:(Message_Shoping_Model *)model {
    [self.Icon_View sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Order_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
}

- (void)setHousekeepingDataSoureToCell:(Message_Housekeeping_Model *)model {
    [self.Icon_View sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Order_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
}

@end
