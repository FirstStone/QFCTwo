//
//  Mine_SetUP_Title_image_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Title_image_Cell.h"

@interface Mine_SetUP_Title_image_Cell ()


@end

@implementation Mine_SetUP_Title_image_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (void)setUPUI {
    [self.contentView addSubview:self.title_Label];
    [self.title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(23.0f);
        make.left.equalTo(self.contentView.mas_left).offset(10.0f);
        make.height.offset(15.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-23.0f);
    }];
    [self.contentView addSubview:self.icon_ImageView];
    [self.icon_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(6.0f, 11.0f));
        make.centerY.equalTo(self.title_Label.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
    }];
    [self.contentView addSubview:self.photo_ImageView];
    [self.photo_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40.0f, 40.0f));
        make.centerY.equalTo(self.icon_ImageView);
        make.right.equalTo(self.icon_ImageView.mas_left).offset(- 10.0f);
    }];
}

- (UIImageView *)photo_ImageView {
    if (!_photo_ImageView) {
        _photo_ImageView = [[UIImageView alloc] init];
        _photo_ImageView.image = [UIImage imageNamed:@"icon_touxiang"];
    }
    return _photo_ImageView;
}

- (UILabel *)title_Label {
    if (!_title_Label) {
        _title_Label = [[UILabel alloc] init];
        _title_Label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        _title_Label.textColor = QFC_Color_333333;
    }
    return _title_Label;
}
- (UIImageView *)icon_ImageView {
    if (!_icon_ImageView) {
        _icon_ImageView = [[UIImageView alloc] init];
        _icon_ImageView.image = [UIImage imageNamed:@"icon_you_Hui"];
    }
    return _icon_ImageView;
}

@end
