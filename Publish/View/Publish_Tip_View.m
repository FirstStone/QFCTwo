//
//  Publish_Tip_View.m
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Publish_Tip_View.h"

@implementation Publish_Tip_View


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    [self addSubview:self.QB_BT];
    [self.QB_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(30.0f);
    }];
    UIView *Line_View_3 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [self addSubview:Line_View_3];
    [Line_View_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5.0f);
        make.right.equalTo(self.mas_right).offset(-5.0f);
        make.top.equalTo(self.QB_BT.mas_bottom);
        make.height.offset(1.0f);
    }];
    
    
    [self addSubview:self.GC_BT];
    [self.GC_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.QB_BT);
        make.top.equalTo(Line_View_3.mas_bottom);
//        make.top.left.right.equalTo(self);
//        make.height.offset(30.0f);
    }];
    UIView *Line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [self addSubview:Line_View];
    [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5.0f);
        make.right.equalTo(self.mas_right).offset(-5.0f);
        make.top.equalTo(self.GC_BT.mas_bottom);
        make.height.offset(1.0f);
    }];
    [self addSubview:self.ZY_BT];
    [self.ZY_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.GC_BT);
        make.top.equalTo(Line_View.mas_bottom);
    }];
    UIView *Line_View_1 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [self addSubview:Line_View_1];
    [Line_View_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(Line_View);
        make.top.equalTo(self.ZY_BT.mas_bottom);
        
    }];
    [self addSubview:self.ZJ_BT];
    [self.ZJ_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.GC_BT);
        make.top.equalTo(Line_View_1.mas_bottom);
    }];
    UIView *Line_View_2 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [self addSubview:Line_View_2];
    [Line_View_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(Line_View);
        make.top.equalTo(self.ZJ_BT.mas_bottom);
    }];
    [self addSubview:self.Text_Label];
    [self.Text_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(Line_View_1);
        make.top.equalTo(Line_View_2.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).offset(-10.0f);
    }];
}

- (CustomBT *)QB_BT {
    if (!_QB_BT) {
        _QB_BT = [[CustomBT alloc] init];
        [_QB_BT setTitle:@"全部可见" forState:UIControlStateNormal];
        [_QB_BT setImage:[UIImage imageNamed:@"icon_Gou_hui"] forState:UIControlStateNormal];
        [_QB_BT setImage:[UIImage imageNamed:@"icon_Gou_Green"] forState:UIControlStateSelected];
        [_QB_BT setTitleColor:QFC_Color(51, 51, 51) forState:UIControlStateNormal];
        [_QB_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _QB_BT.BTStyle = ImageLeftTitleRight;
        _QB_BT.ImageORTitle_Interval = 4.0f;
        //        _GC_BT.ImageTopTitleBottom_MultipliedBy = 3.0f;
        _QB_BT.Interval = 8.5f;
        _QB_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        _QB_BT.selected = YES;
    }
    return _QB_BT;
}

- (CustomBT *)GC_BT {
    if (!_GC_BT) {
        _GC_BT = [[CustomBT alloc] init];
        [_GC_BT setTitle:@"广场可见" forState:UIControlStateNormal];
        [_GC_BT setImage:[UIImage imageNamed:@"icon_Gou_hui"] forState:UIControlStateNormal];
        [_GC_BT setImage:[UIImage imageNamed:@"icon_Gou_Green"] forState:UIControlStateSelected];
        [_GC_BT setTitleColor:QFC_Color(51, 51, 51) forState:UIControlStateNormal];
        [_GC_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _GC_BT.BTStyle = ImageLeftTitleRight;
        _GC_BT.ImageORTitle_Interval = 4.0f;
//        _GC_BT.ImageTopTitleBottom_MultipliedBy = 3.0f;
        _GC_BT.Interval = 8.5f;
        _GC_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    }
    return _GC_BT;
}

- (CustomBT *)ZY_BT {
    if (!_ZY_BT) {
        _ZY_BT = [[CustomBT alloc] init];
        [_ZY_BT setTitle:@"主页可见" forState:UIControlStateNormal];
        [_ZY_BT setImage:[UIImage imageNamed:@"icon_Gou_hui"] forState:UIControlStateNormal];
        [_ZY_BT setImage:[UIImage imageNamed:@"icon_Gou_Green"] forState:UIControlStateSelected];
        [_ZY_BT setTitleColor:QFC_Color(51, 51, 51) forState:UIControlStateNormal];
        [_ZY_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _ZY_BT.BTStyle = ImageLeftTitleRight;
        _ZY_BT.ImageORTitle_Interval = 4.0f;
//        _ZY_BT.ImageTopTitleBottom_MultipliedBy = 3.5f;
        _ZY_BT.Interval = 8.5f;
        _ZY_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    }
    return _ZY_BT;
}

- (CustomBT *)ZJ_BT {
    if (!_ZJ_BT) {
        _ZJ_BT = [[CustomBT alloc] init];
        [_ZJ_BT setTitle:@"自己可见" forState:UIControlStateNormal];
        [_ZJ_BT setImage:[UIImage imageNamed:@"icon_Gou_hui"] forState:UIControlStateNormal];
        [_ZJ_BT setImage:[UIImage imageNamed:@"icon_Gou_Green"] forState:UIControlStateSelected];
        [_ZJ_BT setTitleColor:QFC_Color(51, 51, 51) forState:UIControlStateNormal];
        [_ZJ_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _ZJ_BT.BTStyle = ImageLeftTitleRight;
        _ZJ_BT.ImageORTitle_Interval = 4.0f;
//        _ZJ_BT.ImageTopTitleBottom_MultipliedBy = 3.5f;
        _ZJ_BT.Interval = 8.5f;
        _ZJ_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    }
    return _ZJ_BT;
}

- (UILabel *)Text_Label {
    if (!_Text_Label) {
        _Text_Label = [[UILabel alloc] init];
        _Text_Label.font = [UIFont systemFontOfSize:7.0f];
        _Text_Label.textColor = QFC_Color(153, 153, 153);
        _Text_Label.textAlignment = NSTextAlignmentCenter;
        _Text_Label.numberOfLines = 0;
        _Text_Label.text = @"你的个人主页和与你有关系的人均可见";
        _Text_Label.hidden = YES;
    }
    return _Text_Label;
}

- (void)buttonClick:(UIButton *)button {
    if ([button isEqual:self.QB_BT]) {
        button.selected = YES;
        self.GC_BT.selected = NO;
        self.ZY_BT.selected = NO;
        self.ZJ_BT.selected = NO;
        if ([self.delegate respondsToSelector:@selector(PublishTipViewButtonClick:)]) {
            [self.delegate PublishTipViewButtonClick:0];
        }
    }else if ([button isEqual:self.GC_BT]) {
        button.selected = YES;
        self.QB_BT.selected = NO;
        self.ZY_BT.selected = NO;
        self.ZJ_BT.selected = NO;
        if ([self.delegate respondsToSelector:@selector(PublishTipViewButtonClick:)]) {
            [self.delegate PublishTipViewButtonClick:1];
        }
    }else if ([button isEqual:self.ZY_BT]) {
        button.selected = YES;
        self.QB_BT.selected = NO;
        self.GC_BT.selected = NO;
        self.ZJ_BT.selected = NO;
        if ([self.delegate respondsToSelector:@selector(PublishTipViewButtonClick:)]) {
            [self.delegate PublishTipViewButtonClick:2];
        }
    }else {
        button.selected = YES;
        self.QB_BT.selected = NO;
        self.ZY_BT.selected = NO;
        self.GC_BT.selected = NO;
        if ([self.delegate respondsToSelector:@selector(PublishTipViewButtonClick:)]) {
            [self.delegate PublishTipViewButtonClick:3];
        }
    }
}

@end
