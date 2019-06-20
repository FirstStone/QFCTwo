//
//  Home_Seach_Goods_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_Seach_Goods_Cell.h"

@interface Home_Seach_Goods_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@end

@implementation Home_Seach_Goods_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToCell:(Home_Seach_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
}

@end
