//
//  Home_ShoppingCatr_Settlement_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCatr_Settlement_Cell.h"

@interface Home_ShoppingCatr_Settlement_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sum_Label;

@end

@implementation Home_ShoppingCatr_Settlement_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Home_ShoppingCatr_Settlement_Branch_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Sub_Label.text = model.specification;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
    self.Sum_Label.text = [NSString stringWithFormat:@"X %@", model.goods_sum];
}

@end
