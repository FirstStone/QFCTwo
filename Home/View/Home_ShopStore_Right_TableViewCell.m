
//
//  Home_ShopStore_Right_TableViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_Right_TableViewCell.h"

@interface Home_ShopStore_Right_TableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *Icon_ImageView;

@property (strong, nonatomic) IBOutlet UILabel *ShopStore_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UIView *Sum_View;

@property (strong, nonatomic) IBOutlet UIButton *Cart_BT;

@property (strong, nonatomic) IBOutlet UIButton *Jian_BT;

@property (strong, nonatomic) IBOutlet UIButton *Jia_BT;

@property (strong, nonatomic) IBOutlet UILabel *Sum_Label;



@property (nonatomic, strong) Home_ShopStore_Branch_Model *MyModel;

@end

@implementation Home_ShopStore_Right_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)CartButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeShopStoreRightTableViewCellCartButtonClick:)]) {
        [self.delegate HomeShopStoreRightTableViewCellCartButtonClick:self.MyModel];
    }
}

- (IBAction)AddButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeShopStoreRightTableViewCellAddButtonClick:)]) {
        [self.delegate HomeShopStoreRightTableViewCellAddButtonClick:self.MyModel];
    }
}

- (IBAction)SubtractButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeShopStoreRightTableViewCellSubtractButtonClick:)]) {
        [self.delegate HomeShopStoreRightTableViewCellSubtractButtonClick:self.MyModel];
    }
}


- (void)SetDataSoureToRightCell:(Home_ShopStore_Branch_Model *)model {
    self.MyModel = model;
    [self.Icon_ImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.ShopStore_Label.text = [NSString stringWithFormat:@"%@  大约%@g/份", model.goods_name, model.goods_unit];
    self.Sub_Label.text = [NSString stringWithFormat:@"月销%@份", model.sales_sum];
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
    if (model.Cart_Sate) {
        self.Sum_Label.text = model.sum;
        self.Cart_BT.hidden = model.Cart_Sate;
        self.Sum_View.hidden = NO;
    }else {
        self.Cart_BT.hidden = model.Cart_Sate;
        self.Sum_View.hidden = YES;
    }
}


@end
