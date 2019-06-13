//
//  Home_CommunityNearby_EspecialRegion_ThreeCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_EspecialRegion_ThreeCell.h"

@interface Home_CommunityNearby_EspecialRegion_ThreeCell ()

@property (strong, nonatomic) IBOutlet UIImageView *Lift_imageView;

@property (strong, nonatomic) IBOutlet UIImageView *Middle_imageView;

@property (strong, nonatomic) IBOutlet UIImageView *Right_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Lift_PriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *Middle_PriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *Right_PriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *Lift_CostLabel;
@property (strong, nonatomic) IBOutlet UIButton *Lift_Skip_BT;
@property (strong, nonatomic) IBOutlet UILabel *Middle_CostLabel;
@property (strong, nonatomic) IBOutlet UIButton *Middle_Skip_BT;
@property (strong, nonatomic) IBOutlet UILabel *Right_CostLabel;
@property (strong, nonatomic) IBOutlet UIButton *Right_Skip_BT;

@end

@implementation Home_CommunityNearby_EspecialRegion_ThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.Lift_Skip_BT addTarget:self action:@selector(LiftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.Middle_Skip_BT addTarget:self action:@selector(MiddleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.Right_Skip_BT addTarget:self action:@selector(RightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)LiftButtonClick:(UIButton *)button {
    
}

- (void)MiddleButtonClick:(UIButton *)button {
    
}

- (void)RightButtonClick:(UIButton *)button {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataSoureToCell:(NSMutableArray *)dataArray; {
    for (int i = 0; i < dataArray.count; i++) {
        Home_CommunityNearby_Activity_Model *model = dataArray[i];
        if (i == 0) {
            [self.Lift_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Lift_PriceLabel.text = model.activity_price;
            self.Lift_CostLabel.text = model.price;
        }else if (i == 1) {
            [self.Middle_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Middle_PriceLabel.text = model.activity_price;
            self.Middle_CostLabel.text = model.price;
        }else {
            [self.Right_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Right_PriceLabel.text = model.activity_price;
            self.Right_CostLabel.text = model.price;
        }
    }
}
@end
