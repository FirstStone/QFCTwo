//
//  Home_CommunityNearby_Branch_CollectionViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Branch_CollectionViewCell.h"

@interface Home_CommunityNearby_Branch_CollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;
@property (strong, nonatomic) IBOutlet UILabel *Distance_Label;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;



@end

@implementation Home_CommunityNearby_Branch_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModelToCell:(Home_CommunityNearby_ActivityBranch_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@/%@", model.price, model.goods_unit];
    if (model.times.length) {
        self.Time_Label.hidden = NO;
        self.Time_Label.text = [NSString stringWithFormat:@"  %@  ", model.times];
    }
    if (model.distance.length) {
        self.Distance_Label.hidden = NO;
        self.Distance_Label.text = [NSString stringWithFormat:@"  %@  ", model.distance];
    }
}
@end
