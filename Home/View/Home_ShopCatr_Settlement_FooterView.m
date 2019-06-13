//
//  Home_ShopCatr_Settlement_FooterView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopCatr_Settlement_FooterView.h"

@interface Home_ShopCatr_Settlement_FooterView ()<UITextFieldDelegate>

@property (nonatomic, strong) Home_ShoppingCatr_Settlement_Model *MyModel;

@end

@implementation Home_ShopCatr_Settlement_FooterView

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
        make.left.equalTo(self.contentView.mas_left).offset(10.0f).priorityHigh();
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f).priorityHigh();
        make.top.equalTo(self.contentView.mas_top).offset(-12.0f).priorityHigh();
//        make.bottom.equalTo(self.contentView.mas_bottom).priorityHigh();
    }];
    UILabel *Title_Label_1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"配送方式：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    [contentView addSubview:Title_Label_1];
    [Title_Label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(70.0f, 30.0f));
        make.left.equalTo(contentView .mas_left).offset(10.0f);
        make.top.equalTo(contentView.mas_top).offset(17.0f);
    }];
    
    [contentView addSubview:self.Invite_BT];
    [self.Invite_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(50.0f, 22.0f));
        make.centerY.equalTo(Title_Label_1.mas_centerY);
        make.left.equalTo(Title_Label_1.mas_right).offset(10.0f);
    }];
    [contentView addSubview:self.Delivery_BT];
    [self.Delivery_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.equalTo(self.Invite_BT);
        make.left.equalTo(self.Invite_BT.mas_right).offset(10.0f);
    }];

    UILabel *Title_Label_2 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"跑腿费用：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    [contentView addSubview:Title_Label_2];
    [Title_Label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(Title_Label_1);
        make.top.equalTo(Title_Label_1.mas_bottom);
    }];
    [contentView addSubview:self.Price_Label];
    [self.Price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(Title_Label_2);
        make.left.equalTo(Title_Label_2.mas_right).offset(10.0f);
    }];
    UILabel *Title_Label_3 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"优惠：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    [contentView addSubview:Title_Label_3];
    [Title_Label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(Title_Label_2);
        make.top.equalTo(Title_Label_2.mas_bottom);
    }];
    [contentView addSubview:self.Discount_Label];
    [self.Discount_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(Title_Label_3);
        make.left.equalTo(Title_Label_3.mas_right).offset(10.0f);
    }];
    UILabel *Title_Label_4 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        label.textColor = QFC_Color_333333;
        label.text = @"备注：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    [contentView addSubview:Title_Label_4];
    [Title_Label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(Title_Label_3);
        make.top.equalTo(Title_Label_3.mas_bottom);
    }];
    [contentView addSubview:self.Remarks_Field];
    [self.Remarks_Field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(Title_Label_4);
        make.left.equalTo(Title_Label_4.mas_right).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
    }];
    [contentView addSubview:self.Total_Label];
    [self.Total_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(Title_Label_4);
        make.top.equalTo(Title_Label_4.mas_bottom);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];
    self.contentView.clipsToBounds = YES;
}


#pragma mark----懒加载
- (UIButton *)Delivery_BT{
    if (!_Delivery_BT) {
        _Delivery_BT = [[UIButton alloc] init];
        [_Delivery_BT setTitle:@"配送" forState:UIControlStateNormal];
        _Delivery_BT.backgroundColor = QFC_BackColor_Gray;
        [_Delivery_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_Delivery_BT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Delivery_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_Delivery_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Delivery_BT.layer.cornerRadius =11.0f;
        _Delivery_BT.tag = 4958580;
    }
    return _Delivery_BT;
}

- (UIButton *)Invite_BT {
    if (!_Invite_BT) {
        _Invite_BT = [[UIButton alloc] init];
        [_Invite_BT setTitle:@"自取" forState:UIControlStateNormal];
        _Invite_BT.backgroundColor = QFC_Color_30AC65;
        [_Invite_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_Invite_BT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Invite_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_Invite_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _Invite_BT.layer.cornerRadius =11.0f;
        _Invite_BT.tag = 4958581;
        _Invite_BT.selected = YES;
    }
    return _Invite_BT;
}

- (UILabel *)Price_Label {
    if (!_Price_Label) {
        _Price_Label = [[UILabel alloc] init];
        _Price_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Price_Label.textColor = QFC_Color_Six;
        _Price_Label.text = @"0元";
    }
    return _Price_Label;
}

- (UILabel *)Discount_Label {
    if (!_Discount_Label) {
        _Discount_Label = [[UILabel alloc] init];
        _Discount_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Discount_Label.textColor = QFC_Color_Six;
        _Discount_Label.text = @"无优惠券";
    }
    return _Discount_Label;
}

- (UITextField *)Remarks_Field {
    if (!_Remarks_Field) {
        _Remarks_Field = [[UITextField alloc] init];
        _Remarks_Field.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Remarks_Field.textColor = QFC_Color_Six;
        _Remarks_Field.placeholder = @"有什么要说的吗？";
        _Remarks_Field.delegate = self;
    }
    return _Remarks_Field;
}

- (UILabel *)Total_Label {
    if (!_Total_Label) {
        _Total_Label = [[UILabel alloc] init];
        _Total_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Total_Label.textColor = QFC_Color_Six;
        _Total_Label.text = @"小计：¥0";
    }
    return _Total_Label;
}

- (void)setDataSoureToCell:(Home_ShoppingCatr_Settlement_Model *)model {
    self.MyModel = model;
    self.Price_Label.text = [NSString stringWithFormat:@"%@元",model.RunPrice];
    self.Remarks_Field.text = model.Remark;
    if (model.DeliveryState) {
        self.Delivery_BT.selected = NO;
        self.Delivery_BT.backgroundColor = QFC_BackColor_Gray;
        self.Invite_BT.selected = YES;
        self.Invite_BT.backgroundColor = QFC_Color_30AC65;
    } else {
        self.Delivery_BT.selected = YES;
        self.Delivery_BT.backgroundColor = QFC_Color_30AC65;
        self.Invite_BT.selected = NO;
        self.Invite_BT.backgroundColor = QFC_BackColor_Gray;
    }
    
    double price = 0.0f;
    for (int i = 0; i < model.goods.count; i ++) {
        Home_ShoppingCart_Branch_Model *middleModel = model.goods[i];
        price = price + [middleModel.price doubleValue] * [middleModel.goods_sum intValue];
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"小计："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%0.2f", (price + [model.RunPrice doubleValue])]];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_FF492B range:NSMakeRange(0, redStr.length)];
    // 为label添加Attributed
    [noteStr appendAttributedString:redStr];
    [self.Total_Label setAttributedText:noteStr];
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 4958580) {//配送
        self.Delivery_BT.selected = YES;
        self.Delivery_BT.backgroundColor = QFC_Color_30AC65;
        self.Invite_BT.selected = NO;
        self.Invite_BT.backgroundColor = QFC_BackColor_Gray;
        if ([self.delegate respondsToSelector:@selector(HomeShopCatrSettlementFooterViewButton:modelID:)]) {
            [self.delegate HomeShopCatrSettlementFooterViewButton:2 modelID:self.MyModel.merchant_id];
        }
    } else {//自取
        self.Delivery_BT.selected = NO;
        self.Delivery_BT.backgroundColor = QFC_BackColor_Gray;
        self.Invite_BT.selected = YES;
        self.Invite_BT.backgroundColor = QFC_Color_30AC65;
        if ([self.delegate respondsToSelector:@selector(HomeShopCatrSettlementFooterViewButton:modelID:)]) {
            [self.delegate HomeShopCatrSettlementFooterViewButton:1 modelID:self.MyModel.merchant_id];
        }
    }
}

#pragma mark----UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(HomeShopCatrSettlementFooterViewRemark:modelID:)]) {
        [self.delegate HomeShopCatrSettlementFooterViewRemark:textField.text modelID:self.MyModel.merchant_id];
    }
}



@end
