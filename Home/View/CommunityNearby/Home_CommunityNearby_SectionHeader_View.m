//
//  Home_CommunityNearby_SectionHeader_View.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_SectionHeader_View.h"

@implementation Home_CommunityNearby_SectionHeader_View

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.backgroundColor = QFC_Color_F5F5F5;
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:contView];
    [contView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);//.offset(10.0f)
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10.0f);
        make.right.equalTo(self.mas_right).offset(-10.0f);
    }];
    [contView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contView);
        make.left.equalTo(contView.mas_left).offset(10.0f);
    }];
    UIView *line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    [contView addSubview:line_View];
    [line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Title_Label.mas_right).offset(5.0f);
        make.width.offset(1.0f);
        make.top.bottom.equalTo(self.Title_Label);
    }];
    [contView addSubview:self.Sub_Label];
    [self.Sub_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line_View.mas_right).offset(5.0f);
        make.top.bottom.equalTo(self.Title_Label);
    }];
    [contView addSubview:self.More_BT];
    [self.More_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contView);
        make.right.equalTo(contView.mas_right).offset(10.0f);
        make.width.offset(70.0f);
    }];
}

#pragma mark----懒加载
- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
    }
    return _Title_Label;
}

- (UILabel *)Sub_Label {
    if (!_Sub_Label) {
        _Sub_Label = [[UILabel alloc] init];
        _Sub_Label.font = [UIFont systemFontOfSize:11.0f weight:UIFontWeightMedium];
    }
    return _Sub_Label;
}

- (UIButton *)More_BT {
    if (!_More_BT) {
        _More_BT = [[UIButton alloc] init];
        [_More_BT setTitle:@"查看更多" forState:UIControlStateNormal];
        _More_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightRegular];
        [_More_BT setTitleColor:QFC_Color_Six forState:UIControlStateNormal];
    }
    return _More_BT;
}

@end
