//
//  Home_CommunityNearby_EspecialRegion_OneCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_EspecialRegion_OneCell.h"

@interface Home_CommunityNearby_EspecialRegion_OneCell ()

@property (strong, nonatomic) IBOutlet UIImageView *image_View;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;
@property (strong, nonatomic) IBOutlet UILabel *Cost_Label;


@end

@implementation Home_CommunityNearby_EspecialRegion_OneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Home_CommunityNearby_Activity_Model *)model {
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.activity_name;
    self.Price_Label.text = model.activity_price;
    self.Cost_Label.text = model.price;
}

@end
