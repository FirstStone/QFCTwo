//
//  Mine_CV_TopImageDownLabel_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_CV_TopImageDownLabel_Cell.h"

@interface Mine_CV_TopImageDownLabel_Cell ()

@end

@implementation Mine_CV_TopImageDownLabel_Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.icon_View];
    [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.4f);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.4f);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(20.0f);
//        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.contentView addSubview:self.Text_Label];
    [self.Text_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(14.0f);
        make.top.equalTo(self.icon_View.mas_bottom).offset(5.0f);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}

#pragma mark----懒加载

- (UIImageView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIImageView alloc] init];
        _icon_View.image = [UIImage imageNamed:@"icon_WD_daifukuan"];
    }
    return _icon_View;
}

- (UILabel *)Text_Label {
    if (!_Text_Label) {
        _Text_Label = [[UILabel alloc] init];
        _Text_Label.font = [UIFont systemFontOfSize:12.0f];
        _Text_Label.textColor = QFC_Color_Six;
        _Text_Label.textAlignment = NSTextAlignmentCenter;
        _Text_Label.text = @"待付款";
    }
    return _Text_Label;
}

@end
