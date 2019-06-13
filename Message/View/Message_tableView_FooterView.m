//
//  Message_tableView_FooterView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_tableView_FooterView.h"

@interface Message_tableView_FooterView ()

@property (nonatomic, strong) Message_Shoping_Model *MyShopModel;

@end

@implementation Message_tableView_FooterView

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
        view.layer.cornerRadius = 15.0f;
        view;
    });
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
        make.top.equalTo(self.contentView.mas_top).offset(-12.0f);
        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5.0f, 10.0f, 0, 10.0f));
    }];
    [contentView addSubview:self.Price_Label];
    [self.Price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.top.equalTo(contentView.mas_top).offset(17.0f);
    }];
    [contentView addSubview:self.Text_Label];
    [self.Text_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.top.equalTo(self.Price_Label.mas_bottom);
    }];
    [contentView addSubview:self.Lift_BT];
    [self.Lift_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30.0f);
        make.top.equalTo(self.Text_Label.mas_bottom).offset(20.0f);
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.width.mas_offset((SCREEN_WIDTH-30.0f)/2.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];
    [contentView addSubview:self.Right_BT];
    [self.Right_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(self.Lift_BT);
        make.left.equalTo(self.Lift_BT.mas_right).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
    }];
    self.contentView.clipsToBounds = YES;
}
#pragma mark----懒加载

- (UILabel *)Price_Label {
    if (!_Price_Label) {
        _Price_Label = [[UILabel alloc] init];
        _Price_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        _Price_Label.textColor = QFC_Color_Six;
        _Price_Label.text = @"付款金额：阿斯顿发送到发";
    }
    return _Price_Label;
}

- (UILabel *)Text_Label {
    if (!_Text_Label) {
        _Text_Label = [[UILabel alloc] init];
        _Text_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        _Text_Label.textColor = QFC_Color_Six;
        _Text_Label.numberOfLines = 0;
        _Text_Label.text = @"创建时间：4天前\n用户昵称：华晨宇\n联系方式：185 3946 5047\n服务地址：上海市松江区泗泾镇泗泾新苑东区8号楼1402室";
    }
    return _Text_Label;
}

- (UIButton *)Lift_BT {
    if (!_Lift_BT) {
        _Lift_BT = [[UIButton alloc] init];
        [_Lift_BT setTitle:@"自送" forState:UIControlStateNormal];
        _Lift_BT.titleLabel.textColor = [UIColor whiteColor];
        _Lift_BT.backgroundColor = QFC_Color_30AC65;
        _Lift_BT.layer.cornerRadius = 15.0f;
        [_Lift_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Lift_BT.tag = 2948484;
    }
    return _Lift_BT;
}
- (UIButton *)Right_BT {
    if (!_Right_BT) {
        _Right_BT = [[UIButton alloc] init];
        [_Right_BT setTitle:@"配送" forState:UIControlStateNormal];
        _Right_BT.titleLabel.textColor = [UIColor whiteColor];
        _Right_BT.backgroundColor = QFC_Color_30AC65;
        _Right_BT.layer.cornerRadius = 15.0f;
        [_Right_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Right_BT.tag = 2948485;
    }
    return _Right_BT;
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 2948484) {//左边
        if ([self.delegate respondsToSelector:@selector(MessagetableViewFooterViewButtonClick:index:)]) {
            [self.delegate MessagetableViewFooterViewButtonClick:self.MyShopModel index:1];
        }
    } else {//右边
        [self.delegate MessagetableViewFooterViewButtonClick:self.MyShopModel index:2];
    }
}

- (void)setDataSoureToCell:(Message_Shoping_Model *)model style:(NSInteger)style {
    self.MyShopModel = model;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"付款金额："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@", model.sum_price]];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_FF492B range:NSMakeRange(0, redStr.length)];
    [noteStr appendAttributedString:redStr];
    [self.Price_Label setAttributedText:noteStr];
    self.Text_Label.text = [NSString stringWithFormat:@"创建时间：%@\n用 户 名：%@\n手 机 号：%@\n服务地址：%@", model.createtime, model.finish_realname, model.finish_phone, model.finish_address];
    if (style) {//待完成
//        self.Lift_BT.hidden = YES;
        [self.Lift_BT mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.0f);
        }];
        if ([model.status intValue] == 2) {
            [self.Right_BT setTitle:@"待跑腿接单" forState:UIControlStateNormal];
        }else if ([model.status intValue] == 3) {
            [self.Right_BT setTitle:@"待跑腿取货" forState:UIControlStateNormal];
        }else if ([model.status intValue] == 4) {
            [self.Right_BT setTitle:@"待配送完成" forState:UIControlStateNormal];
        }
    }else {//待接单
        if ([model.merchant_errand intValue] == 1) {
            [self.Lift_BT setTitle:@"自送" forState:UIControlStateNormal];
            [self.Right_BT setTitle:@"配送" forState:UIControlStateNormal];
        } else if ([model.merchant_errand intValue] == 2){
            self.Lift_BT.hidden = YES;
            [self.Lift_BT mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(0.0f);
            }];
            [self.Right_BT setTitle:@"立即接单" forState:UIControlStateNormal];
        }
    }
}


- (void)setHousekeepingDataSoureToCell:(Message_Housekeeping_Model *)model style:(NSInteger)style {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"付款金额："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@", model.sum_price]];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_FF492B range:NSMakeRange(0, redStr.length)];
    [noteStr appendAttributedString:redStr];
    [self.Price_Label setAttributedText:noteStr];
    self.Text_Label.text = [NSString stringWithFormat:@"用 户 名：%@\n手 机 号：%@\n服务地址：%@", model.finish_realname, model.finish_phone, model.finish_address];
    if (style) {//待完成
        self.Lift_BT.hidden = YES;
        [self.Lift_BT mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.0f);
        }];
        if ([model.status intValue] == 3) {
            [self.Right_BT setTitle:@"开始服务" forState:UIControlStateNormal];
        }else if ([model.status intValue] == 4) {
            [self.Right_BT setTitle:@"完成服务" forState:UIControlStateNormal];
        }
    }else {//待接单
            self.Lift_BT.hidden = YES;
            [self.Lift_BT mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(0.0f);
            }];
            [self.Right_BT setTitle:@"立即接单" forState:UIControlStateNormal];
    }
}



@end
