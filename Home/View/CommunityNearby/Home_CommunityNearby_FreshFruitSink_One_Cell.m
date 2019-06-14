//
//  Home_CommunityNearby_Fruits_One_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_FreshFruitSink_One_Cell.h"

@interface Home_CommunityNearby_FreshFruitSink_One_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@end

@implementation Home_CommunityNearby_FreshFruitSink_One_Cell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Home_CommunityNearby_Activity_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Price_Label.text = model.price;
}

@end
