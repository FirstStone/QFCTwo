//
//  Home_CommunityNearby_FreshFruitSink_Three_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_FreshFruitSink_Three_Cell.h"

@interface Home_CommunityNearby_FreshFruitSink_Three_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *Lift_imageView;
@property (strong, nonatomic) IBOutlet UIImageView *Middle_imageview;
@property (strong, nonatomic) IBOutlet UIImageView *Right_imageview;
@property (strong, nonatomic) IBOutlet UILabel *Lift_RedLabel;
@property (strong, nonatomic) IBOutlet UILabel *Middle_RedLabel;
@property (strong, nonatomic) IBOutlet UILabel *Right_RedLabel;
@property (strong, nonatomic) IBOutlet UILabel *Lift_BlackLabel;
@property (strong, nonatomic) IBOutlet UILabel *Middle_BlackLabel;
@property (strong, nonatomic) IBOutlet UILabel *Right_BlackLabel;
@property (strong, nonatomic) IBOutlet UILabel *Lift_TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *Middle_TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *Right_TitleLabel;

@property (nonatomic, strong) NSMutableArray *MyArray;

@end

@implementation Home_CommunityNearby_FreshFruitSink_Three_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *LiftZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LiftimageViewClick:)];
    [self.Lift_imageView addGestureRecognizer:LiftZer];
    UITapGestureRecognizer *MiddleZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MiddleimageViewClick:)];
    [self.Middle_imageview addGestureRecognizer:MiddleZer];
    
    UITapGestureRecognizer *RightZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightimageViewClick:)];
    [self.Right_imageview addGestureRecognizer:RightZer];
}

- (void)LiftimageViewClick:(UIGestureRecognizer*)Zer {
    if ([self.delegate respondsToSelector:@selector(HomeCommunityNearbyFreshFruitSinkThreeCellImageLiftClick:)]) {
        Home_CommunityNearby_Activity_Model *model = self.MyArray[0];
        [self.delegate HomeCommunityNearbyFreshFruitSinkThreeCellImageLiftClick:model.activity_id];
    }
}
- (void)MiddleimageViewClick:(UIGestureRecognizer*)Zer {
    if ([self.delegate respondsToSelector:@selector(HomeCommunityNearbyFreshFruitSinkThreeCellMiddleImageClick:)]) {
        Home_CommunityNearby_Activity_Model *model = self.MyArray[1];
        [self.delegate HomeCommunityNearbyFreshFruitSinkThreeCellMiddleImageClick:model.activity_id];
    }
}
- (void)RightimageViewClick:(UIGestureRecognizer*)Zer {
    if ([self.delegate respondsToSelector:@selector(HomeCommunityNearbyFreshFruitSinkThreeCellRightImageClick:)]) {
        Home_CommunityNearby_Activity_Model *model = self.MyArray[2];
        [self.delegate HomeCommunityNearbyFreshFruitSinkThreeCellRightImageClick:model.activity_id];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLabelHiddle:(BOOL)Hiddle {
    self.RightMoney_Label.hidden = Hiddle;
    self.LiftMoney_Label.hidden = Hiddle;
    self.MiddleMoney_Label.hidden = Hiddle;
}

- (void)setDataSoureToCell:(NSMutableArray *)dataArray; {
    self.MyArray = dataArray;
    for (int i = 0; i < dataArray.count; i++) {
        Home_CommunityNearby_Activity_Model *model = dataArray[i];
        if (i == 0) {
            [self.Lift_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Lift_RedLabel.text = [NSString stringWithFormat:@"¥%@", model.price];
            self.Lift_TitleLabel.text = model.goods_name;
        }else if (i == 1) {
            [self.Middle_imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Middle_RedLabel.text = [NSString stringWithFormat:@"¥%@", model.price];;
            self.Middle_TitleLabel.text = model.goods_name;
        }else {
            [self.Right_imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Right_RedLabel.text = [NSString stringWithFormat:@"¥%@", model.price];;
            self.Right_TitleLabel.text = model.goods_name;
        }
    }
}

- (void)setDataSourefruitslistToCell:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i++) {
        Home_CommunityNearby_Activity_Model *model = dataArray[i];
        if (i == 0) {
            [self.Lift_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Lift_BlackLabel.text = [NSString stringWithFormat:@"¥%@", model.price];;
            self.Lift_RedLabel.text = @"满减";
            self.Lift_TitleLabel.text = model.goods_name;
        }else if (i == 1) {
            [self.Middle_imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Middle_BlackLabel.text = [NSString stringWithFormat:@"¥%@", model.price];;
            self.Middle_TitleLabel.text = model.goods_name;
            self.Middle_RedLabel.text = @"满减";
        }else {
            [self.Right_imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
            self.Right_BlackLabel.text = [NSString stringWithFormat:@"¥%@", model.price];;
            self.Right_TitleLabel.text = model.goods_name;
            self.Right_RedLabel.text = @"满减";
        }
    }
}
@end
