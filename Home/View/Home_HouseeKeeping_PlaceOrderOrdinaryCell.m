//
//  Home_HouseeKeeping_PlaceOrderOrdinaryCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseeKeeping_PlaceOrderOrdinaryCell.h"

@interface Home_HouseeKeeping_PlaceOrderOrdinaryCell ()

@property (nonatomic, strong) UILabel *Price_Label;

//@property (nonatomic, strong) UIView *backView;

@end

@implementation Home_HouseeKeeping_PlaceOrderOrdinaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)Price_Label {
    if (!_Price_Label) {
        _Price_Label = [[UILabel alloc] init];
        _Price_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Price_Label.textColor = QFC_Color_999999;
        _Price_Label.text = @"(80元起)";
    }
    return _Price_Label;
}
//- (UIView *)backView {
//    if (!_backView) {
//        _backView = [[UIView alloc] init];
//        _backView.backgroundColor = [UIColor whiteColor];
//    }
//    return _backView;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = QFC_Color_F5F5F5;
//        [self setUPUI];
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setUPUI {
    [self.contentView removeAllSubviews];
    UIView *backView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
    UILabel *Tip_Label = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        label.textColor = QFC_Color_333333;
        label.text = @"选择服务面积";
        label;
    });
    [backView addSubview:Tip_Label];
    [Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(10.0f);
        make.top.equalTo(backView.mas_top).offset(10.0f);
        make.height.offset(15.0f);
    }];
    [backView addSubview:self.Price_Label];
    [self.Price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(Tip_Label);
        make.left.equalTo(Tip_Label.mas_right).offset(10.0f);
    }];
    /*
     "content": "50平米以内",
     "times": 2,
     "price": "80.00",
     "id": 1
     */
    for (int i = 0; i < self.dataArray.count; i ++) {
        Home_HouseKeep_PlaceOrderOrdinary_Model *model = self.dataArray[i];
        ButtonAndLabel *BLView = ({
            ButtonAndLabel *Middle = [[ButtonAndLabel alloc] init];
            [Middle.Top_BT setTitle:model.content forState:UIControlStateNormal];
            [Middle.Top_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            Middle.Top_BT.selected = model.Button_State;
            Middle.Down_Label.text = [NSString stringWithFormat:@"%@个小时%@元", model.times, model.price];
            Middle.Top_BT.tag = 10000 + i;
            Middle;
        });
        [backView addSubview:BLView];
        [BLView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake((SCREEN_WIDTH - 50.0f) / 4.0f, 50.0f));
            make.top.equalTo(Tip_Label.mas_bottom).offset((i/4) * 60.0f + 10.0f);
            make.left.equalTo(backView.mas_left).offset((i % 4) * ((SCREEN_WIDTH - 50.0f) / 4.0f) + ((i % 4) * 10.0f) + 10.0f);
        }];
        
        if (i == (self.dataArray.count - 1)) {
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(BLView.mas_bottom).offset(10.0f);
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(HomeHouseeKeepingPlaceOrderOrdinaryCellButtonClick:Number:)]) {
        [self.delegate HomeHouseeKeepingPlaceOrderOrdinaryCellButtonClick:self.dataArray[button.tag - 10000] Number:button.tag - 10000];
    }
}


@end
