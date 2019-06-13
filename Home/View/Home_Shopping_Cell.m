//
//  Home_Shopping_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_Shopping_Cell.h"

@interface Home_Shopping_Cell ()

@property (strong, nonatomic) IBOutlet UIButton *CellState_BT;

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (nonatomic, strong) IBOutlet UILabel *sum_Label;

@property (nonatomic, strong) IBOutlet UIButton *plus_BT_Right;

@property (nonatomic, strong) IBOutlet UIButton *reduce_BT_Lift;

@property (nonatomic, strong) Home_ShoppingCart_Branch_Model *MYmodel;

@end

@implementation Home_Shopping_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.reduce_BT_Lift addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.plus_BT_Right addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)CellStateButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeShoppingCellButtonClick:)]) {
        [self.delegate HomeShoppingCellButtonClick:self.MYmodel.Branch_id];
    }
}

- (void)buttonChange:(UIButton *)button {
    switch (button.tag) {
        case 50683:{//减
            //左边   减少
            if ([self.delegate respondsToSelector:@selector(HomeShoppingCellSum:State:)]) {
                [self.delegate HomeShoppingCellSum:self.MYmodel.Branch_id State:1];
            }
        }
            break;
        case 50684:{//加
            //右边
            if ([self.delegate respondsToSelector:@selector(HomeShoppingCellSum:State:)]) {
                [self.delegate HomeShoppingCellSum:self.MYmodel.Branch_id State:2];
            }
        }
            break;
        default:
            break;
    }
}

- (void)setModelToCell:(Home_ShoppingCart_Branch_Model *)model {
    self.MYmodel = model;
    self.CellState_BT.selected = model.ButtonState;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    if (model.specification.length) {
        self.Sub_Label.text = model.specification;
    }else {
        self.Sub_Label.hidden = YES;
    }
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
    self.sum_Label.text = model.goods_sum;
}


@end
