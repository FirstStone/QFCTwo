//
//  Home_CommunityNearby_EspecialRegionFour_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_EspecialRegionFour_Cell.h"

@interface Home_CommunityNearby_EspecialRegionFour_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Lift_Title_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Lift_imgeView;

@property (strong, nonatomic) IBOutlet UILabel *Top_Title_Label;
@property (strong, nonatomic) IBOutlet UIImageView *Top_imgeView;


@property (strong, nonatomic) IBOutlet UILabel *DownLift_Title_Label;
@property (strong, nonatomic) IBOutlet UIImageView *DownLift_imgeView;


@property (strong, nonatomic) IBOutlet UILabel *DownRight_Title_Label;
@property (strong, nonatomic) IBOutlet UIImageView *DownRight_imgeView;

@end

@implementation Home_CommunityNearby_EspecialRegionFour_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataSoureToCell:(NSMutableArray *)array {
    for (int i = 0; i < array.count; i++) {
        Home_CommunityNearby_Activity_Model *model = array[i];
        if (i == 0) {
            [self.Lift_imgeView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Lift_Title_Label.text = model.activity_name;
        }else if (i == 1) {
            [self.Top_imgeView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Top_Title_Label.text = model.activity_name;
        }else if (i == 2){
            [self.DownLift_imgeView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.DownLift_Title_Label.text = model.activity_name;
        }else {
            [self.DownRight_imgeView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.DownRight_Title_Label.text = model.activity_name;
        }
    }
}
@end
