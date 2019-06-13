//
//  Home_CommunityNearby_FirstEnjoy_OneCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_FirstEnjoy_OneCell.h"

@interface Home_CommunityNearby_FirstEnjoy_OneCell ()

@property (strong, nonatomic) IBOutlet UIImageView *image_View;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;


@end

@implementation Home_CommunityNearby_FirstEnjoy_OneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Home_CommunityNearby_Activity_Model *)model {
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Price_Label.text = model.price;
}

@end
