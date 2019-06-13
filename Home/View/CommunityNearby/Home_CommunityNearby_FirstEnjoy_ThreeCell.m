//
//  Home_CommunityNearby_FirstEnjoy_ThreeCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_FirstEnjoy_ThreeCell.h"

@interface Home_CommunityNearby_FirstEnjoy_ThreeCell ()

@property (strong, nonatomic) IBOutlet UIImageView *Lift_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Lift_Title_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Middle_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Middle_Title_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Right_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Right_Title_Label;

@end

@implementation Home_CommunityNearby_FirstEnjoy_ThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i++) {
        Home_CommunityNearby_Activity_Model *model = dataArray[i];
        if (i == 0) {
            [self.Lift_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Lift_Title_Label.text = model.goods_name;
        }else if (i == 1) {
            [self.Middle_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Middle_Title_Label.text = model.goods_name;
        }else {
            [self.Right_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Right_Title_Label.text = model.goods_name;
        }
    }
}

@end
