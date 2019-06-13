//
//  Mine_MyOrder_Shop_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_Shop_Cell.h"

@interface Mine_MyOrder_Shop_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *image_View;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;
@property (strong, nonatomic) IBOutlet UILabel *Number_Label;
@property (strong, nonatomic) IBOutlet UILabel *Discount_Label;
@property (strong, nonatomic) IBOutlet UILabel *Univalent_Label;

@end

@implementation Mine_MyOrder_Shop_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Message_Shoping_Branch_Model *)model runPrice:(NSString *)runPrice YouhuiPrice:(NSString *)YHPrice {
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Sub_Label.text = model.specification;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
    self.Number_Label.text = [NSString stringWithFormat:@"X %@", model.goods_sum];
    self.Discount_Label.text = [NSString stringWithFormat:@"跑腿费用：¥%@\n优惠：¥%@", runPrice, YHPrice];
    
}


@end
