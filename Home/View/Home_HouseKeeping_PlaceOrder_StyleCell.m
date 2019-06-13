//
//  Home_HouseKeeping_PlaceOrder_StyleCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlaceOrder_StyleCell.h"

#define ViewWidth (SCREEN_WIDTH - 60.0f)/5.0f
@interface Home_HouseKeeping_PlaceOrder_StyleCell ()

@end

@implementation Home_HouseKeeping_PlaceOrder_StyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = QFC_Color_F5F5F5;
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
        label.text = @"选择服务类型";
        label;
    });
    [backView addSubview:Tip_Label];
    [Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(10.0f);
        make.right.equalTo(backView.mas_right).offset(-10.0f);
        make.top.equalTo(backView.mas_top).offset(10.0f);
        make.height.offset(15.0f);
    }];
    for (int i = 0; i < self.dataArray.count; i++) {
        Home_HouseKeep_PlaceOrder_Model *model = self.dataArray[i];
        UILabel *title_lable = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
            label.textColor = QFC_Color_333333;
            label.text = model.names;
            label;
        });
        [backView addSubview:title_lable];
        [title_lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Tip_Label.mas_bottom).offset(10.0f + ((model.list.count / 5) + i) * 50.0f + 10.0f * ((model.list.count / 5) + i));
            make.left.equalTo(backView.mas_left).offset(10.0f);
            make.size.mas_offset(CGSizeMake(ViewWidth, 15.0f));
        }];
        for (int j = 0; j < model.list.count; j++) {
            Home_HouseKeep_PlaceOrderBranch_Model *branchModel = model.list[j];
            ButtonAndLabel *BLView = ({
                ButtonAndLabel *Middle = [[ButtonAndLabel alloc] init];
                [Middle.Top_BT setTitle:branchModel.content forState:UIControlStateNormal];
                [Middle.Top_BT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                Middle.Top_BT.selected = branchModel.Button_State;
                Middle.Down_Label.text = [NSString stringWithFormat:@"%@元", branchModel.price];
                Middle.Down_Label.textAlignment = NSTextAlignmentCenter;
                Middle.Top_BT.tag = 10000 + j + i * 10000;
                Middle;
            });
            [backView addSubview:BLView];
            [BLView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(ViewWidth, 50.0f));
                NSLog(@">>>>>>>>>>>>>>>%f", 35 + 10.0f + ((j / 4) + i) * 50.0f + 10.0f * ((j / 4) + i));
                NSLog(@"===============%f", 20.0f + ViewWidth + (j % 4) * ViewWidth + (j % 4) * 10.0f);
                make.top.equalTo(backView.mas_top).mas_offset(25 + 10.0f + ((j / 4) + i) * 50.0f + 10.0f * ((j / 4) + i));//.priorityHigh();//(model.list.count / 4)
                make.left.equalTo(backView.mas_left).mas_offset(20.0f + ViewWidth + (j % 4) * ViewWidth + (j % 4) * 10.0f).priorityHigh();
            }];
            if (i == (self.dataArray.count - 1)) {
                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(BLView.mas_bottom).offset(10.0f).priorityHigh();
                }];
            }
        }
    }
}


- (void)buttonClick:(UIButton *)button {
    NSLog(@"%ld", (long)button.tag);
    Home_HouseKeep_PlaceOrder_Model *model = self.dataArray[(button.tag / 10000) - 1];
    Home_HouseKeep_PlaceOrderBranch_Model *branchModel = model.list[button.tag % 10000];
    for (int i = 0; i < model.list.count; i++) {
        Home_HouseKeep_PlaceOrderBranch_Model *MiddlehModle  = model.list[i];
        if (((button.tag % 10000) == i) && (MiddlehModle.Button_State == YES)) {
            break;
        }else {
            MiddlehModle.Button_State = NO;
        }
    }
    
//    for (Home_HouseKeep_PlaceOrderBranch_Model *midModel in model.list) {
//        if (midModel.Button_State == YES) {
//
//        }else {
//            midModel.Button_State = NO;
//        }
//    }
    
    branchModel.Button_State = !branchModel.Button_State;
    [model.list replaceObjectAtIndex:(button.tag % 10000) withObject:branchModel];
    if ([self.delegate respondsToSelector:@selector(HomeHouseKeepingPlaceOrderStyleButtonClick:sectionListArray:Section:index:)]) {
        [self.delegate HomeHouseKeepingPlaceOrderStyleButtonClick:model sectionListArray:model.list Section:(button.tag / 10000 - 1) index:button.tag%10000];
    }
}

@end
