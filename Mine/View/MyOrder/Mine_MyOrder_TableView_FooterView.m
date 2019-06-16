//
//  Mine_MyOrder_TableView_FooterView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_TableView_FooterView.h"

@interface Mine_MyOrder_TableView_FooterView ()

@end

@implementation Mine_MyOrder_TableView_FooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
        [self.Lift_BT addTarget:self action:@selector(LiftButtonClaick) forControlEvents:UIControlEventTouchUpInside];
        [self.Right_BT addTarget:self action:@selector(RightButtonClaick) forControlEvents:UIControlEventTouchUpInside];
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
        make.bottom.equalTo(self.contentView.mas_bottom).priorityHigh();
        //        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5.0f, 10.0f, 0, 10.0f));
    }];
    [contentView addSubview:self.Discount_Label];
    [self.Discount_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.top.equalTo(contentView.mas_top).offset(17.0f);
    }];
    [contentView addSubview:self.Total_Label];
    [self.Total_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.top.equalTo(self.Discount_Label.mas_bottom).offset(5.0f);
    }];
    [contentView addSubview:self.Right_BT];
    [self.Right_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(25.0f);
        make.top.equalTo(self.Total_Label.mas_bottom).offset(15.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
        make.width.offset(93.0f);
    }];
    [contentView addSubview:self.Lift_BT];
    [self.Lift_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.Right_BT);
        make.right.equalTo(self.Right_BT.mas_left).offset(-15.0f);
    }];
    [contentView addSubview:self.More_BT];
    [self.More_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(self.Lift_BT);
        make.width.offset(60.0f);
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.bottom.equalTo(contentView.mas_bottom).offset(-10.0f);
    }];
    [contentView addSubview:self.image_View];
    [self.image_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(53.0f, 53.0f));
        make.right.equalTo(contentView.mas_right);//.offset(5.0f);
        make.bottom.equalTo(contentView.mas_bottom);//.offset(5.0);
    }];
    contentView.clipsToBounds = YES;
    self.contentView.clipsToBounds = YES;
}

#pragma mark----懒加载

- (UILabel *)Discount_Label {
    if (!_Discount_Label) {
        _Discount_Label = [[UILabel alloc] init];
        _Discount_Label.font = [UIFont systemFontOfSize:9.0f weight:UIFontWeightBold];
        _Discount_Label.numberOfLines = 0;
        _Discount_Label.textColor = QFC_Color_FF492B;
        _Discount_Label.textAlignment = NSTextAlignmentRight;
    }
    return _Discount_Label;
}

- (UIImageView *)image_View {
    if (!_image_View) {
        _image_View = [[UIImageView alloc] init];
        _image_View.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_tuikuan"];
        _image_View.hidden = YES;
    }
    return _image_View;
}

- (UILabel *)Total_Label {
    if (!_Total_Label) {
        _Total_Label = [[UILabel alloc] init];
        _Total_Label.textAlignment = NSTextAlignmentRight;
    }
    return _Total_Label;
}
- (UIButton *)Lift_BT {
    if (!_Lift_BT) {
        _Lift_BT = [[UIButton alloc] init];
        [_Lift_BT setTitle:@"  取消订单  " forState:UIControlStateNormal];
        _Lift_BT.layer.cornerRadius = 13.0f;
        _Lift_BT.layer.borderColor = QFC_Color_30AC65.CGColor;
        _Lift_BT.layer.borderWidth = 1.0f;
        _Lift_BT.backgroundColor = QFC_Color_30AC65;
        _Lift_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_Lift_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Lift_BT.hidden = YES;
    }
    return _Lift_BT;
}
- (UIButton *)Right_BT {
    if (!_Right_BT) {
        _Right_BT = [[UIButton alloc] init];
        [_Right_BT setTitle:@"  等待接单...  " forState:UIControlStateNormal];
        _Right_BT.layer.cornerRadius = 13.0f;
        _Right_BT.backgroundColor = QFC_Color_30AC65;
        _Right_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_Right_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Right_BT.hidden = YES;
    }
    return _Right_BT;
}

- (UIButton *)More_BT {
    if (!_More_BT) {
        _More_BT = [[UIButton alloc] init];
        [_More_BT setTitle:@"更多" forState:UIControlStateNormal];
        _More_BT.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        [_More_BT setTitleColor:QFC_Color_Six forState:UIControlStateNormal];
        _More_BT.hidden = YES;
    }
    return _More_BT;
}

- (void)setToTotalLabel:(NSString *)Text redText:(NSString *)Price {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:Text];
    // 需要改变的区间
    //        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:Price];
    [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, redStr.length)];
    self.Total_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
    [noteStr appendAttributedString:redStr];
    [self.Total_Label setAttributedText:noteStr];
}

- (void)LiftButtonClaick {
    if ([self.delegate respondsToSelector:@selector(buttonStyle:model:OrderStyle:)]) {
        [self.delegate buttonStyle:1 model:self.MyModel OrderStyle:self.OrderCellStyle];
    }
}

- (void)RightButtonClaick {
    if ([self.delegate respondsToSelector:@selector(buttonStyle:model:OrderStyle:)]) {
        [self.delegate buttonStyle:2 model:self.MyModel OrderStyle:self.OrderCellStyle];
    }
}



@end
